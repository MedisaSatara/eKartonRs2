import 'dart:convert';

import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/kategorijatranskacije.dart';
import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/models/transakcija25062025.dart';
import 'package:ekarton_mobile/models/transkacijeLog25062025.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/kategorija_transkcija_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/stripe_service.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/providers/transkacije_provider.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/screens/list_preporuceni_doktori.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as sp;
import 'package:http/http.dart' as http;

class Frmtranskacije25062025new extends StatefulWidget {
  final Transakcija25062025? transakcija25062025;
  final Function? onDataChanged;
  Frmtranskacije25062025new(
      {Key? key, this.transakcija25062025, this.onDataChanged})
      : super(key: key);

  @override
  State<Frmtranskacije25062025new> createState() =>
      _Frmtranskacije25062025new();
}

class _Frmtranskacije25062025new extends State<Frmtranskacije25062025new> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TranskacijeProvider _transkacijeProvider;
  late KorisnikProvider _korisnikProvider;
  late KategorijaTranskcijaProvider _kategorijaTranskcijaProvider;

  List<Korisnik>? _korisnici;
  List<Kategorijatranskacije>? _kategorrijaTransakcfije;
  List<Transakcija25062025>? _transakcije;

  String? _selectedKorisnikId;
  String? _selectedKategorijaId;
  String? _korisnikkIme;
  int? _selectedCijena;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  List<Map<String, String>> stateOptions = [
    {"display": "Planirano", "value": "Planirano"},
    {"display": "Realizovano", "value": "Realizovano"},
    {"display": "Otkazano", "value": "Otkazano"},
  ];

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'datumTransakcije': widget.transakcija25062025?.datumTransakcije,
      'opis': widget.transakcija25062025?.opis,
      'status': widget.transakcija25062025?.status,
      'korisnikId': widget.transakcija25062025?.korisnikId,
      'kategorijaTransakcijaId':
          widget.transakcija25062025?.kategorijaTransakcijaId,
      'iznos': widget.transakcija25062025?.iznos,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transkacijeProvider = context.read<TranskacijeProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _kategorijaTranskcijaProvider =
        context.read<KategorijaTranskcijaProvider>();

    _fetchKorisnici();
    _fetchKategorije();
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisniciData = await _korisnikProvider.get();
      setState(() {
        _korisnici = korisniciData.result;
        if (widget.transakcija25062025?.korisnikId != null) {
          var korisnik = _korisnici?.firstWhere(
            (p) => p.korisnikId == widget.transakcija25062025?.korisnikId,
          );
          _korisnikkIme = korisnik?.ime;
        }
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> _fetchKategorije() async {
    try {
      var kategorijaData = await _kategorijaTranskcijaProvider.get();
      setState(() {
        _kategorrijaTransakcfije = kategorijaData.result;
      });
    } catch (e) {
      print('Error fetching categries: $e');
    }
  }

  Future<void> _fetchTranskacije() async {
    try {
      var transkacijeData = await _transkacijeProvider.get();
      setState(() {
        _transakcije = transkacijeData.result;
      });
    } catch (e) {
      print('Error fetching transakcije: $e');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[400],
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] =
            int.tryParse(mutableFormData['korisnikId'] as String) ?? 0;
      }
      if (mutableFormData['kategorijaTransakcijaId'] != null) {
        mutableFormData['kategorijaTransakcijaId'] = int.tryParse(
                mutableFormData['kategorijaTransakcijaId'] as String) ??
            0;
      }
      if (mutableFormData['opis'] != null) {
        mutableFormData['opis'] = mutableFormData['opis'] as String;
      }
      if (mutableFormData['status'] != null) {
        mutableFormData['status'] = mutableFormData['status'] as String;
      }

      if (mutableFormData['iznos'] != null) {
        mutableFormData['iznos'] =
            int.tryParse(mutableFormData['iznos'] as String);
      }
      mutableFormData['iznos'] = _selectedCijena;

      try {
        if (widget.transakcija25062025 == null) {
          await _transkacijeProvider
              .insert(Transakcija25062025.fromJson(mutableFormData));
          _showSuccessMessage('Trasaction successfully added!');
        } else {
          await _transkacijeProvider.update(
              widget.transakcija25062025!.transkacijeId!,
              Transakcija25062025.fromJson(mutableFormData));
          _showSuccessMessage('Transaction successfully updated!');
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to save the transaction. Please try again.')),
        );
      }
    }
  }

  void _successDialogADD(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.transakcija25062025 == null
                      ? 'Adding a new transaction'
                      : 'Updating transaction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  name: "datumTransakcije",
                  readOnly: true,
                  initialValue: _initialValue['datumTransakcije'],
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      String formattedDate =
                          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

                      _formKey.currentState?.fields['datumTransakcije']
                          ?.didChange(formattedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Datum u formatu yyyy-MM-dd';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Iznos",
                      border: OutlineInputBorder(),
                    ),
                    name: "iznos",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Opis",
                      border: OutlineInputBorder(),
                    ),
                    name: "opis",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'status',
                  decoration: InputDecoration(
                    labelText: 'Status',
                  ),
                  items: stateOptions
                      .map((option) => DropdownMenuItem<String>(
                            value: option['value'],
                            child: Text(option['display'] ?? ''),
                          ))
                      .toList(),
                  initialValue: _initialValue['status'],
                  onChanged: (value) {
                    setState(() {
                      _initialValue['status'] = value;
                    });
                    print("Odabrani status: $value");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'korisnikId',
                    decoration: InputDecoration(
                      labelText: 'Korisnik',
                    ),
                    items: _korisnici
                            ?.map((korisnik) => DropdownMenuItem<String>(
                                  value: korisnik.korisnikId.toString(),
                                  child: Text(korisnik.ime ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['korisnikId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedKorisnikId = value;
                      });
                      print("Odabrani korisnikID: $_selectedKorisnikId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'kategorijaTransakcijaId',
                    decoration: InputDecoration(
                      labelText: 'Kategorija',
                    ),
                    items: _kategorrijaTransakcfije
                            ?.map((katgorija) => DropdownMenuItem<String>(
                                  value: katgorija.kategorijaTransakcijaId
                                      .toString(),
                                  child: Text(katgorija.nazivKategorije ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue:
                        _initialValue['kategorijaTransakcijaId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedKategorijaId = value;
                      });
                      print("Odabrani kategorijaId: $_selectedKategorijaId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child:
                      Text(widget.transakcija25062025 == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.transakcija25062025 != null
          ? "Transaction: ${_korisnikkIme}"
          : "Transaction details",
    );
  }
}
