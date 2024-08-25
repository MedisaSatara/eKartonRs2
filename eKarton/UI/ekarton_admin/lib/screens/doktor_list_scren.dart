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
  TextEditingController _nazivOdjelaController = TextEditingController();

  String? _selectedOdjelId;
  Map<String, dynamic> _initialValue = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'doktorId': widget.doktor?.doktorId,
      'ime': widget.doktor?.ime,
      'prezime': widget.doktor?.prezime,
      'spol': widget.doktor?.spol,
      'datumRodjenja': widget.doktor?.datumRodjenja,
      'grad': widget.doktor?.grad,
      'jmbg': widget.doktor?.jmbg,
      'telefon': widget.doktor?.telefon,
      'email': widget.doktor?.email,
      'odjelId': widget.doktor?.odjelId?.toString(),
    };
    _doktorProvider = context.read<DoktorProvider>();
    _odjelProvider = context.read<OdjelProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _doktorProvider = context.read<DoktorProvider>();
    _odjelProvider = context.read<OdjelProvider>();
  }

  Future initForm() async {
    odjelResult = await _odjelProvider.get();
    if (odjelResult == null || odjelResult!.result == null) {
      print('odjel je prazan');
    }
    for (var item in odjelResult!.result) {
      print('Dropdown item: ${item.odjelId} - ${item.naziv}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Doktori"),
      child: Container(
        child: Column(children: [
          _buildSearch(),
          _buildDataListView(),
        ]),
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
              decoration: InputDecoration(labelText: "Prezime"),
              controller: _prezimeController,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: FormBuilderDropdown<String>(
              name: 'odjelId',
              decoration: InputDecoration(
                labelText: 'Odjel',
              ),
              items: [
                DropdownMenuItem(
                    value: null,
                    child: Text("Svi odjeli")), // Opcija za sve odjele
                ...?odjelResult?.result
                    .map((item) => DropdownMenuItem<String>(
                          value: item.odjelId.toString(),
                          child: Text(item.naziv ?? ""),
                        ))
                    .toList(),
              ],
              initialValue: _initialValue['odjelId'] ?? null,
              onChanged: (value) {
                setState(() {
                  _selectedOdjelId = value;
                });
                print(
                    "Odabrani odjelId: $_selectedOdjelId"); 
              },
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DoktorDetailsScreen(doktor: null),
                ),
              );*/
            },
            child: Text("Dodaj"),
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
      'imeDoktora': _imeController.text,
      'prezimeDoktora': _prezimeController.text,
      'nazivOdjela': _nazivOdjelaController.text,
    };

    if (_selectedOdjelId != null && _selectedOdjelId!.isNotEmpty) {
      filter['odjelId'] = _selectedOdjelId!;
    }

    print("Filter: $filter"); 

    var data = await _doktorProvider.get(filter: filter);

    print("Data: ${data.result}");

    setState(() {
      doktorResult = data;
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
                  'Spol',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Odjel',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: doktorResult?.result
                  .map((Doktor e) => DataRow(
                        /* onSelectChanged: (selected) {
                          if (selected == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoktorDetailsScreen(doktor: e),
                              ),
                            );
                          }
                        },*/
                        cells: [
                          DataCell(Text(e.ime ?? "")),
                          DataCell(Text(e.prezime ?? "")),
                          DataCell(Text(e.datumRodjenja ?? "")),
                          DataCell(Text(e.spol ?? "")),
                          DataCell(Text(odjelResult?.result
                                  .firstWhere(
                                      (odjel) => odjel.odjelId == e.odjelId,
                                      orElse: () =>
                                          Odjel(odjelId: 0, naziv: "N/A"))
                                  .naziv ??
                              "")), 
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
