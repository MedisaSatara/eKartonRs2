import 'dart:async';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
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
    _loadInitialData();
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
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    return Expanded(
      child: Container(
        child: Card(
          child: AdaptiveScrollbar(
            underColor: Colors.blueGrey.withOpacity(0.3),
            sliderDefaultColor: Colors.grey.withOpacity(0.7),
            sliderActiveColor: Colors.grey,
            controller: _verticalScrollController,
            child: AdaptiveScrollbar(
              controller: _horizontalScrollController,
              position: ScrollbarPosition.bottom,
              underColor: Colors.blueGrey.withOpacity(0.3),
              sliderDefaultColor: Colors.grey.withOpacity(0.7),
              sliderActiveColor: Colors.grey,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
