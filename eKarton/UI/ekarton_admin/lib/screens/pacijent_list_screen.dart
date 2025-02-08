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
            Container(
              width: double.infinity,
              height: 200.0,
              color: const Color.fromARGB(255, 63, 125, 137),
              child: Center(
                child: Text(
                  'Patients Found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildSearch(),
            _buildDataListView(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(width: 16.0),
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Transform.translate(
        offset: Offset(0, -40),
        child: Card(
          elevation: 5.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: Colors.black.withOpacity(0.3),
          child: Container(
            width: 400,
            height: 300,
            padding: const EdgeInsets.all(16.0),
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
                SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
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
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 63, 125, 137),
                    elevation: 5.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        child: Column(
          children: result?.result.map((Pacijent e) {
                var preventiveMjere = preventivneMjereResult?.result
                    .where((mj) => mj.pacijentId == e.pacijentId)
                    .toList();

                var preventiveMjereText =
                    preventiveMjere != null && preventiveMjere.isNotEmpty
                        ? preventiveMjere.map((mj) => mj.stanje).join(', ')
                        : "/";

                return Card(
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PacijentiDetailsScreen(pacijent: e),
                        ),
                      );

                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                        _fetchInitialData();
                      }
                    },
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 63, 125, 137),
                      child: Text(
                        e.ime != null && e.prezime != null
                            ? '${e.ime![0]}${e.prezime![0]}'
                            : 'N/A',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      '${e.ime ?? ""} ${e.prezime ?? ""}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carton No: ${e.brojKartona ?? "N/A"}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Date of Birth: ${e.datumRodjenja != null ? DateFormat('dd.MM.yyyy').format(e.datumRodjenja!) : "N/A"}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (preventiveMjere != null &&
                                    preventiveMjere.isNotEmpty) {
                                  var selectedMeasure =
                                      await showDialog<PreventivneMjere>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text("Select Preventive Measure"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: preventiveMjere.map((mj) {
                                              return ListTile(
                                                title: Text(
                                                    mj.stanje ?? "No state"),
                                                onTap: () {
                                                  Navigator.of(context).pop(mj);
                                                },
                                                trailing: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () async {
                                                    await _preventivneMjereProvider
                                                        .delete(mj
                                                            .preventivneMjereId);
                                                    Navigator.of(context)
                                                        .pop(); 
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  if (selectedMeasure != null) {
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreventivneMjereDetailsScreen(
                                          preventivneMjere: selectedMeasure,
                                          pacijent: e,
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(result)),
                                      );
                                      _fetchInitialData();
                                    }
                                  }
                                }
                              },
                              child: Text(
                                'Preventive measure: ${preventiveMjereText}',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 63, 125, 137),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            if (preventiveMjere != null &&
                                preventiveMjere.isNotEmpty)
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      const Color.fromARGB(255, 63, 125, 137),
                                ),
                                onPressed: () async {
                                  var selectedMeasure =
                                      await showDialog<PreventivneMjere>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Select Preventive Measure to Edit"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: preventiveMjere.map((mj) {
                                              return ListTile(
                                                title: Text(
                                                    mj.stanje ?? "No state"),
                                                onTap: () {
                                                  Navigator.of(context).pop(mj);
                                                },
                                                trailing: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () async {
                                                    await _preventivneMjereProvider
                                                        .delete(mj
                                                            .preventivneMjereId);
                                                    _fetchInitialData();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  if (selectedMeasure != null) {
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreventivneMjereDetailsScreen(
                                          preventivneMjere: selectedMeasure,
                                          pacijent: e,
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(result)),
                                      );
                                      _fetchInitialData();
                                    }
                                  }
                                },
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PreventivneMjereDetailsScreen(
                                      pacijent: e,
                                    ),
                                  ),
                                );

                                if (result != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result.toString())),
                                  );
                                  _fetchInitialData();
                                }
                              },
                              child: Text(
                                "Add Measure",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 63, 125, 137),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.black45,
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
