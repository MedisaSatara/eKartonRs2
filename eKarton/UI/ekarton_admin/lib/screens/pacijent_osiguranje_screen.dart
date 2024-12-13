import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/osiguranje.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/pacijent_osiguranje.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class PacijentOsiguranjeScreen extends StatefulWidget {
  PacijentOsiguranje? pacijentOsiguranje;
  PacijentOsiguranjeScreen({Key? key, this.pacijentOsiguranje})
      : super(key: key);

  @override
  State<PacijentOsiguranjeScreen> createState() => _PacijentOsiguranjeScreen();
}

class _PacijentOsiguranjeScreen extends State<PacijentOsiguranjeScreen> {
  late PacijentOsiguranjeProvider _pacijentOsiguranjeProvider;
  late PacijentProvider _pacijentProvider;
  late OsiguranjeProvider _osiguranjeProvider;
  SearchResult<PacijentOsiguranje>? result;
  SearchResult<Pacijent>? pacijentResult;
  SearchResult<Osiguranje>? osiguranjeResult;

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _brojkartonaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentOsiguranjeProvider = context.read<PacijentOsiguranjeProvider>();
    _pacijentProvider = context.read<PacijentProvider>();
    _osiguranjeProvider = context.read<OsiguranjeProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentOsiguranjeProvider.get();
    var pacijentData = await _pacijentProvider.get();
    var osiguranjeData = await _osiguranjeProvider.get();

    setState(() {
      result = data;
      pacijentResult = pacijentData;
      osiguranjeResult = osiguranjeData;
    });
    print(
        "Pacijent: ${pacijentResult?.result.map((p) => p.pacijentId).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        "Patients insurence",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildDataListView(),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search patients:",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "First name",
            ),
            controller: _imeController,
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Last name",
            ),
            controller: _prezimeController,
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Carton number",
            ),
            controller: _brojkartonaController,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              var data = await _pacijentOsiguranjeProvider.get(filter: {
                'imePacijenta': _imeController.text.trim().toLowerCase(),
                'prezimePacijenta':
                    _prezimeController.text.trim().toLowerCase(),
                'brojKartona': _brojkartonaController.text.trim().toLowerCase(),
              });
              setState(() {
                result = data;
              });
            },
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 5.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Patient',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Insurence name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Date of insurence',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Valid',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result.map((PacijentOsiguranje e) {
                var pacijent = pacijentResult?.result.firstWhereOrNull(
                  (p) => p.pacijentId == e.pacijentId,
                );

                var osiguranje = osiguranjeResult?.result.firstWhereOrNull(
                  (o) => o.osiguranjeId == e.osiguranjeId,
                );

                String vazeceText = e.vazece! ? "Da" : "Ne";

                return DataRow(
                  cells: [
                    DataCell(Text(pacijent?.ime ?? "N/A")),
                    DataCell(Text(osiguranje?.osiguranik ?? "")),
                    DataCell(Text(e.datumOsiguranja ?? "")),
                    DataCell(Text(vazeceText)),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
