import 'dart:async';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/termin_details_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TerminScreen extends StatefulWidget {
  Termin? termin;
  TerminScreen({Key? key, this.termin}) : super(key: key);

  @override
  State<TerminScreen> createState() => _TerminScreen();
}

class _TerminScreen extends State<TerminScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PacijentProvider _pacijentProvider;
  late TerminProvider _terminProvider;
  late DoktorProvider _doktorProvider;
  SearchResult<Termin>? terminResult;
  SearchResult<Pacijent>? pacijentResult;
  SearchResult<Doktor>? doktorResult;
  TextEditingController _imeDoktoraController = TextEditingController();
  TextEditingController _prezimeDoktoraController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentProvider = context.read<PacijentProvider>();
    _terminProvider = context.read<TerminProvider>();
    _doktorProvider = context.read<DoktorProvider>();
    _fetchTermini();
  }

  Future<void> _fetchTermini() async {
    var terminData = await _terminProvider.get();
    var pacijentData = await _pacijentProvider.get();
    var doktorData = await _doktorProvider.get();

    setState(() {
      terminResult = terminData;
      pacijentResult = pacijentData;
      doktorResult = doktorData;
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeDoktora': _imeDoktoraController.text,
      'prezimeDoktora': _prezimeDoktoraController.text,
    };

    var data = await _terminProvider.get(filter: filter);

    setState(() {
      terminResult = data;
      searchExecuted = true;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _terminProvider.get(filter: {
        'imeDoktora': _imeDoktoraController.text.trim(),
        'prezimeDoktora': _prezimeDoktoraController.text.trim(),
      });
      setState(() {
        terminResult = data;
      });
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: const Color.fromARGB(255, 34, 78, 57)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Doctor first name",
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 34, 78, 57)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                      ),
                      controller: _imeDoktoraController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: const Color.fromARGB(255, 34, 78, 57)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Doctor last name",
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 34, 78, 57)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                      ),
                      controller: _prezimeDoktoraController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _searchData,
                child: Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation deleting'),
              content:
                  Text('Are you sure you want to delete this appointment?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("See the list of scheduled appointments"),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            SizedBox(height: 16),
            Expanded(child: _buildDataListView()),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TerminDetailsScreen(
                      onDataChanged: _fetchTermini,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchTermini();
                }
              },
              child: Text("Add new appointment!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshTermini() async {
    var terminData = await _terminProvider.get();

    setState(() {
      terminResult = terminData;
    });
  }

  Expanded _buildDataListView() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Expanded(
      child: Card(
        elevation: 5,
        child: AdaptiveScrollbar(
          controller: _verticalScrollController,
          underColor: Colors.blueGrey.withOpacity(0.3),
          sliderDefaultColor: Colors.grey.withOpacity(0.7),
          sliderActiveColor: Colors.grey,
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
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Date',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Time',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Reason',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
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
                          'Doctor',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'State machine',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Broj transkacije',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Delete',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: terminResult?.result.map((Termin e) {
                        var pacijentName = pacijentResult?.result
                            .firstWhere((p) => p.pacijentId == e.pacijentId);

                        var doktorName = doktorResult?.result
                            .firstWhere((d) => d.doktorId == e.doktorId);

                        return DataRow(
                          onSelectChanged: (selected) async {
                            if (selected == true) {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TerminDetailsScreen(
                                    termin: e,
                                    onDataChanged: _refreshTermini,
                                  ),
                                ),
                              );

                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                _fetchTermini();
                              }
                            }
                          },
                          cells: [
                            DataCell(Text(e.datum ?? "")),
                            DataCell(Text(e.vrijeme ?? "")),
                            DataCell(Text(e.razlog ?? "")),
                            DataCell(Text(pacijentName?.ime ?? "")),
                            DataCell(Text(doktorName?.ime ?? "")),
                            DataCell(Text(e?.stateMachine ?? "")),
                            DataCell(Text(e?.brojTransakcije ?? "")),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  bool confirmDelete =
                                      await _showConfirmationDialog();
                                  if (confirmDelete) {
                                    await _terminProvider.delete(e.terminId);
                                    _fetchTermini();
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList() ??
                      [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
