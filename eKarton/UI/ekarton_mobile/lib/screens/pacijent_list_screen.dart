import 'dart:async';

import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/screens/ekarton_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PacijentListScreen extends StatefulWidget {
  Pacijent? pacijent;
  PacijentListScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<PacijentListScreen> createState() => _PacijentListScreen();
}

class _PacijentListScreen extends State<PacijentListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PacijentProvider _pacijentProvider;
  SearchResult<Pacijent>? pacijentResult;
  TextEditingController _brojKartonaController = TextEditingController();
  bool searchExecuted = false;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentProvider = context.read<PacijentProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Pronadji svoj eKarton!"),
      child: Container(
        child: Column(children: [
          _buildSearch(),
          if (pacijentResult != null && pacijentResult!.result.isNotEmpty)
            _buildDataListView(),
        ]),
      ),
    );
  }

  Future<void> _loadInitialData() async {
    var data = await _pacijentProvider.get();
    setState(() {
      pacijentResult = data;
      searchExecuted = true;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Broj kartona"),
              controller: _brojKartonaController,
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: _searchData,
            child: Text("Pretraga"),
          ),
        ],
      ),
    );
  }

  Future<void> _searchData() async {
    var filter = {
      'brojKartona': _brojKartonaController.text,
    };

    var data = await _pacijentProvider.get(filter: filter);

    setState(() {
      pacijentResult = data;
      searchExecuted = true;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _pacijentProvider.get(filter: {
        'brojKartona': _brojKartonaController.text.trim(),
      });
      setState(() {
        pacijentResult = data;
      });
    });
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
          rows: pacijentResult?.result
                  .map((Pacijent e) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EkartonScreen(pacijent: e),
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
