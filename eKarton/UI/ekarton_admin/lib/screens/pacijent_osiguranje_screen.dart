import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/osiguranje.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/pacijent_osiguranje.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/preventivne_mjere_details_screen.dart';
import 'package:ekarton_admin/screens/preventivne_mjere_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        "Osiguranje pacijenata",
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
            "Pretraži pacijenta:",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Ime",
            ),
            controller: _imeController,
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Prezime",
            ),
            controller: _prezimeController,
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Broj kartona",
            ),
            controller: _brojkartonaController,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              var data = await _pacijentOsiguranjeProvider.get(filter: {
                'imePacijenta': _imeController.text,
                'prezimePacijenta': _prezimeController.text,
                'brojKartona': _brojkartonaController.text,
              });
              setState(() {
                result = data;
              });
            },
            child: Text(
              "Pretraga",
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
                  'Pacijent',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'OsiguranjeId',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Datum osiguranja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Vazece',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result.map((PacijentOsiguranje e) {
                var pacijent = pacijentResult?.result.firstWhere(
                  (p) => p.pacijentId == e.pacijentId,
                );
                var osiguranje = osiguranjeResult?.result.firstWhere(
                  (o) => o.osiguranjeId == e.osiguranjeId,
                );

                return DataRow(
                  cells: [
                    DataCell(Text(pacijent?.ime ?? "N/A")),
                    DataCell(Text(osiguranje?.osiguranik ?? "")),
                    DataCell(Text(e.datumOsiguranja ?? "")),
                    DataCell(Text(e.vazece.toString() ?? "")),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
