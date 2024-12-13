import 'dart:async';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/screens/ekarton_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentProvider = context.read<PacijentProvider>();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentProvider.get();
    setState(() {
      pacijentResult = data;
    });

    print(
        "Pacijenti: ${pacijentResult?.result.map((p) => p.pacijentId).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Carton number search!"),
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
              decoration: InputDecoration(labelText: "Carton number"),
              controller: _brojKartonaController,
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: _searchData,
            child: Text("Search"),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (_brojKartonaController.text.trim().isEmpty) {
        setState(() {
          pacijentResult = null;
        });
        return;
      }

      var data = await _pacijentProvider.get(filter: {
        'brojKartona': _brojKartonaController.text.trim(),
      });
      setState(() {
        pacijentResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    if (_brojKartonaController.text.trim().isEmpty) {
      setState(() {
        pacijentResult = null;
      });
      return;
    }

    var filter = {
      'brojKartona': _brojKartonaController.text,
    };

    var data = await _pacijentProvider.get(filter: filter);

    setState(() {
      pacijentResult = data;
    });
  }

  Expanded _buildDataListView() {
    if (pacijentResult == null || pacijentResult!.result.isEmpty) {
      return Expanded(child: Container());
    }

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
                            label: Text('First name',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(
                            label: Text('Last name',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(
                            label: Text('Date of birth',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(
                            label: Text('Carton number',
                                style: TextStyle(fontStyle: FontStyle.italic))),
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
                                      DataCell(Text(e.datumRodjenja != null
                                          ? DateFormat('dd.MM.yyyy')
                                              .format(e.datumRodjenja!)
                                          : "")),
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
