import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacijentiScreen extends StatefulWidget {
  Pacijent? pacijent;
  PacijentiScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<PacijentiScreen> createState() => _PacijentiScreenState();
}

class _PacijentiScreenState extends State<PacijentiScreen> {
  late PacijentProvider _pacijentiProvider;
  SearchResult<Pacijent>? result;
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _brojkartonaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentiProvider = context.read<PacijentProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentiProvider.get();
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        "Pacijenti",
        style: TextStyle(
          color: Colors.white, // Set the color of the title text
        ),
      ),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildDataListView(),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PacijentiDetailsScreen(pacijent: null),
                  ),
                );
              },
              child: Text("Dodaj novog pacijenta"),
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
          // Title for the search section
          Text(
            "Pretraži pacijenta:",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          // Input fields and button stacked vertically
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
              var data = await _pacijentiProvider.get(filter: {
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
                color: Colors.black, // Set the color of the title text
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 5.0, // Button background color
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
                  'Ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Prezime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Datum rodjenja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Broj kartona',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result
                  .map((Pacijent e) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PacijentiDetailsScreen(pacijent: e),
                              ),
                            );
                          }
                        },
                        cells: [
                          DataCell(Text(e.ime ?? "")),
                          DataCell(Text(e.prezime ?? "")),
                          DataCell(Text(e.datumRodjenja ?? "")),
                          DataCell(Text(e.brojKartona ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
