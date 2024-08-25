import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/osiguranje.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/screens/korisnik_details_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OsiguranjeScreen extends StatefulWidget {
  const OsiguranjeScreen({Key? key}) : super(key: key);

  @override
  State<OsiguranjeScreen> createState() => _OsiguranjeScreen();
}

class _OsiguranjeScreen extends State<OsiguranjeScreen> {
  late OsiguranjeProvider _osiguranjeProvider;
  SearchResult<Osiguranje>? result;
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _osiguranjeProvider = context.read<OsiguranjeProvider>();
    _fetchKorisnici(); // Fetch data on initialization
  }

  Future<void> _fetchKorisnici() async {
    var data = await _osiguranjeProvider.get(filter: {
      'ime': _imeController.text,
      'prezime': _prezimeController.text,
    });
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Lista osiguranja"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Ime"),
              controller: _imeController,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Prezime korisnika"),
              controller: _prezimeController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _fetchKorisnici();
            },
            child: Text("Pretraga"),
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
                  'Osiguranje',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result
                  .map((Osiguranje e) => DataRow(
                        cells: [
                          DataCell(Text(e.osiguranik ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
