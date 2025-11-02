import 'dart:async';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/kategorijatranskacije.dart';
import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/models/transakcija25062025.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/kategorija_transkcija_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/providers/transkacije_provider.dart';
import 'package:ekarton_mobile/screens/frmTranskacije25062025New.dart';
import 'package:ekarton_mobile/screens/termin_details_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class Frmtransakcije25062025 extends StatefulWidget {
  Transakcija25062025? transakcija25062025;
  Frmtransakcije25062025({Key? key, this.transakcija25062025})
      : super(key: key);

  @override
  State<Frmtransakcije25062025> createState() => _Frmtransakcije25062025();
}

class _Frmtransakcije25062025 extends State<Frmtransakcije25062025> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KategorijaTranskcijaProvider _kategorijaTranskcijaProvider;
  late TranskacijeProvider _transkacijeProvider;
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Kategorijatranskacije>? kategorijaTransakcijeResult;
  SearchResult<Transakcija25062025>? transakcijeResult;
  TextEditingController _nazivKategorijeController = TextEditingController();
  TextEditingController _datumKategorijeController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transkacijeProvider = context.read<TranskacijeProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _kategorijaTranskcijaProvider =
        context.read<KategorijaTranskcijaProvider>();
    _fetchTransakcije();
  }

  Future<void> _fetchTransakcije() async {
    var transkacijeData = await _transkacijeProvider.get();
    var korisnikData = await _korisnikProvider.get();
    var kategorijaTransakcijeData = await _kategorijaTranskcijaProvider.get();

    setState(() {
      transakcijeResult = transkacijeData;
      korisnikResult = korisnikData;
      kategorijaTransakcijeResult = kategorijaTransakcijeData;
    });
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

  Future<void> _searchData() async {
    var filter = {
      'nazivKategorije': _nazivKategorijeController.text,
      'datumTransakcije': _datumKategorijeController.text,
    };

    var data = await _transkacijeProvider.get(filter: filter);

    setState(() {
      transakcijeResult = data;
      searchExecuted = true;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _transkacijeProvider.get(filter: {
        'nazivKategorije': _nazivKategorijeController.text.trim(),
        'datumTransakcije': _datumKategorijeController.text.trim(),
      });
      setState(() {
        transakcijeResult = data;
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
                        labelText: "Naziv kategorije",
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
                      controller: _nazivKategorijeController,
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
                        labelText: "Datum Kategorije",
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
                      controller: _datumKategorijeController,
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

  Map<String, int> _statistika() {
    final Map<String, int> statusi = {};
    kategorijaTransakcijeResult?.result.forEach((kategorija) {
      final status = kategorija.tipKategorije ?? "Nepoznato";
      statusi[status] = (statusi[status] ?? 0) + 1;
    });
    return statusi;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("See the list of scheduled appointments"),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Frmtranskacije25062025new(
                      onDataChanged: _fetchTransakcije,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchTransakcije();
                }
              },
              child: Text("Add new tranaction!"),
            ),
            SizedBox(height: 16),
            Expanded(child: _buildDataListView()),
             Builder(builder: (context){
              final status=_statistika();
              return Column(children: status.entries.map((entry){
                return Padding(padding: const EdgeInsets.symmetric(vertical: 2.0), child: Text("${entry.key}: ${entry.value}"),);
              }).toList(),);
            }),

          ],
        ),
      ),
    );
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
                          'Ime korisnika',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Datum Transakcije',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Iznos',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Naziv Kategorije',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Status',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Tip',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                   
                  ],
                  rows: transakcijeResult?.result.map((Transakcija25062025 e) {
                        var kategorijaNaziv = kategorijaTransakcijeResult
                            ?.result
                            .firstWhere((p) =>
                                p.kategorijaTransakcijaId ==
                                e.kategorijaTransakcijaId);

                        var tipKategorije = kategorijaTransakcijeResult?.result
                            .firstWhere((d) =>
                                d.kategorijaTransakcijaId ==
                                e.kategorijaTransakcijaId);

                        var korisnikIme = korisnikResult?.result
                            .firstWhere((p) => p.korisnikId == e.korisnikId);

                        return DataRow(
                          cells: [
                            DataCell(Text(korisnikIme?.ime ?? "")),
                            DataCell(Text(e.datumTransakcije.toString() ?? "")),
                            DataCell(Text(e.iznos.toString() ?? "")),
                            DataCell(
                                Text(kategorijaNaziv?.nazivKategorije ?? "")),
                            DataCell(Text(e.status ?? "")),
                            DataCell(Text(tipKategorije?.tipKategorije ?? "")),
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
