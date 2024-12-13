import 'dart:async';

import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/preventivne_mjere_details_screen.dart';
import 'package:ekarton_admin/screens/preventivne_mjere_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PacijentiScreen extends StatefulWidget {
  Pacijent? pacijent;
  PacijentiScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<PacijentiScreen> createState() => _PacijentiScreenState();
}

class _PacijentiScreenState extends State<PacijentiScreen> {
  late PacijentProvider _pacijentiProvider;
  late PreventivneMjereProvider _preventivneMjereProvider;
  SearchResult<Pacijent>? result;
  SearchResult<PreventivneMjere>? preventivneMjereResult;

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _brojkartonaController = TextEditingController();
  Timer? _debounce;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentiProvider = context.read<PacijentProvider>();
    _preventivneMjereProvider = context.read<PreventivneMjereProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentiProvider.get();
    var preventivneMjereData = await _preventivneMjereProvider.get();
    setState(() {
      result = data;
      preventivneMjereResult = preventivneMjereData;
    });

    print("Pacijenti: ${result?.result.map((p) => p.pacijentId).toList()}");
    print(
        "Preventivne Mjere: ${preventivneMjereResult?.result.map((m) => m.pacijentId).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        "Patients",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildDataListView(),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PacijentiDetailsScreen(pacijent: null),
                  ),
                );

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.toString())),
                  );
                  _fetchInitialData();
                }
              },
              child: Text("Add new patient"),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PreventivneMjereDetailsScreen(),
                  ),
                );

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.toString())),
                  );
                  _fetchInitialData();
                }
              },
              child: Text("Add patient preventive measures"),
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
              labelText: "Name",
            ),
            controller: _imeController,
            //onChanged: (value) => _onSearchChanged(),
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Last name",
            ),
            controller: _prezimeController,
            // onChanged: (value) => _onSearchChanged(),
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Carton number",
            ),
            controller: _brojkartonaController,
            // onChanged: (value) => _onSearchChanged(),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              var data = await _pacijentiProvider.get(filter: {
                'imePacijenta': _imeController.text.trim().toLowerCase(),
                'prezimePacijenta':
                    _prezimeController.text.trim().toLowerCase(),
                'brojKartona': _brojkartonaController.text.trim(),
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

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _pacijentiProvider.get(filter: {
        'imePacijenta': _imeController.text.trim().toLowerCase(),
        'prezimePacijenta': _prezimeController.text.trim().toLowerCase(),
        'brojKartona': _brojkartonaController.text.trim(),
      });
      setState(() {
        result = data;
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
                  'First name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Last name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Date of birth',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Carton number',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Preventive measure',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result.map((Pacijent e) {
                var preventiveMjere = preventivneMjereResult?.result
                    .where(
                      (mj) => mj.pacijentId == e.pacijentId,
                    )
                    .toList();

                var preventiveMjereText =
                    preventiveMjere != null && preventiveMjere.isNotEmpty
                        ? preventiveMjere.map((mj) => mj.stanje).join(', ')
                        : "/";

                return DataRow(
                  onSelectChanged: (selected) async {
                    if (selected == true) {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PacijentiDetailsScreen(pacijent: e),
                        ),
                      );

                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        _fetchInitialData();
                      }
                    }
                  },
                  cells: [
                    DataCell(Text(e.ime ?? "")),
                    DataCell(Text(e.prezime ?? "")),
                    DataCell(Text(e.datumRodjenja != null
                        ? DateFormat('dd.MM.yyyy').format(e.datumRodjenja!)
                        : "")),
                    DataCell(Text(e.brojKartona ?? "")),
                    DataCell(
                      GestureDetector(
                        onTap: () async {
                          if (preventiveMjere != null &&
                              preventiveMjere.isNotEmpty) {
                            var selectedMeasure = preventiveMjere.first;

                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PreventivneMjereDetailsScreen(
                                        preventivneMjere: selectedMeasure),
                              ),
                            );

                            if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result)),
                              );
                              _fetchInitialData();
                            }
                          }
                        },
                        child: Text(
                          preventiveMjereText,
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
