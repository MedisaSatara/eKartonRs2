import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/doktor.dart';
import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/doktor_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class DoktorScreen extends StatefulWidget {
  Doktor? doktor;
  DoktorScreen({Key? key, this.doktor}) : super(key: key);

  @override
  State<DoktorScreen> createState() => _DoktorScreenState();
}

class _DoktorScreenState extends State<DoktorScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late DoktorProvider _doktorProvider;
  late OdjelProvider _odjelProvider;
  SearchResult<Doktor>? doktorResult;
  SearchResult<Odjel>? odjelResult;
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  String? _selectedOdjelId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _doktorProvider = context.read<DoktorProvider>();
    _odjelProvider = context.read<OdjelProvider>();
    initForm();
  }

  Future initForm() async {
    odjelResult = await _odjelProvider.get();
    if (odjelResult == null || odjelResult!.result == null) {
      print('Odjel je prazan');
    }
    setState(() {
      isLoading = false;
    });

    _searchData();
  }

  Future<void> _searchData() async {
    var filter = {
      'imeDoktora': _imeController.text,
      'prezimeDoktora': _prezimeController.text,
    };

    if (_selectedOdjelId != null && _selectedOdjelId!.isNotEmpty) {
      filter['odjelId'] = _selectedOdjelId!;
    }

    var data = await _doktorProvider.get(filter: filter);

    setState(() {
      doktorResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        "Doctors",
        style: TextStyle(color: Colors.white),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: const Color.fromARGB(255, 63, 125, 137),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 400,
                      height: 280,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _imeController,
                            decoration:
                                InputDecoration(labelText: 'First Name'),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: _prezimeController,
                            decoration: InputDecoration(labelText: 'Last Name'),
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
                  SizedBox(width: 16),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 200,
                      height: 280,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Department",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Radio<String>(
                                value: "",
                                groupValue: _selectedOdjelId,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOdjelId = value;
                                  });
                                  _searchData();
                                },
                              ),
                              Text("No Department"),
                            ],
                          ),
                          ...?odjelResult?.result.map((item) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: item.odjelId.toString(),
                                  groupValue: _selectedOdjelId,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOdjelId = value;
                                    });
                                    _searchData();
                                  },
                                ),
                                Text(item.naziv ?? "N/A"),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: doktorResult == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: doktorResult?.result.length ?? 0,
                      itemBuilder: (context, index) {
                        final doktor = doktorResult!.result[index];
                        final odjel = odjelResult?.result.firstWhere(
                          (odjel) => odjel.odjelId == doktor.odjelId,
                          orElse: () => Odjel(odjelId: 0, naziv: "N/A"),
                        );

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${doktor.ime ?? ''} ${doktor.prezime ?? ''}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                    "Date of Birth: ${doktor.datumRodjenja ?? 'N/A'}"),
                                Text("Gender: ${doktor.spol ?? 'N/A'}"),
                                Text("Department: ${odjel?.naziv ?? 'N/A'}"),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
