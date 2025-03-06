import 'dart:convert';

import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/korisnik_uloga.dart';
import 'package:ekarton_admin/models/uloga.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/korisnik_uloga_provider.dart';
import 'package:ekarton_admin/providers/uloga_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class KorisnikUlogaScreen extends StatefulWidget {
  final KorisnikUloga? korisnikUloga;
  final Korisnik? korisnik;
  final Function? onDataChanged;
  KorisnikUlogaScreen(
      {Key? key, this.korisnikUloga, this.korisnik, this.onDataChanged})
      : super(key: key);

  @override
  State<KorisnikUlogaScreen> createState() => _KorisnikUlogaScreen();
}

class _KorisnikUlogaScreen extends State<KorisnikUlogaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late UlogaProvider _ulogaProvider;
  late KorisnikUlogaProvider _korisnikUlogaProvider;

  List<Korisnik>? _korisnik;
  List<Uloga>? _uloga;
  List<KorisnikUloga>? _korisnikUloga;

  String? _selectedKorisnikId;
  String? _selectedUlogaId;
  String? _korisnikIme;

  late Map<String, dynamic> _initialValue;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'korisnikUlogaId': widget.korisnikUloga?.korisnikUlogaId,
      'korisnikId': null,
      'ulogaId': widget.korisnikUloga?.uloga,
      'datumIzmjene': widget.korisnikUloga?.datumIzmjene,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _ulogaProvider = context.read<UlogaProvider>();
    _korisnikUlogaProvider = context.read<KorisnikUlogaProvider>();

    _fetchKorisnik();
    _fetchUloga();
  }

  Future<void> _fetchKorisnik() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnik = korisnikData.result;

        if (_korisnik != null && _korisnik!.isNotEmpty) {
          _selectedKorisnikId = _korisnik!.last.korisnikId.toString();
          _korisnikIme = _korisnik!.last.ime;
          _initialValue['korisnikId'] = _selectedKorisnikId;
        }
      });
    } catch (e) {
      print('Error fetching korisnik: $e');
    }
  }

  Future<void> _fetchUloga() async {
    try {
      var ulogaData = await _ulogaProvider.get();
      setState(() {
        _uloga = ulogaData.result;
      });
    } catch (e) {
      print('Error fetching uloga: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] =
            int.tryParse(mutableFormData['korisnikId'] as String) ?? 0;
      }
      if (mutableFormData['ulogaId'] != null) {
        mutableFormData['ulogaId'] =
            int.tryParse(mutableFormData['ulogaId'] as String) ?? 0;
      }

      try {
        if (widget.korisnikUloga == null) {
          await _korisnikUlogaProvider
              .insert(KorisnikUloga.fromJson(mutableFormData));
          _showSuccessMessage('User role successfully added!');
        } else {
          await _korisnikUlogaProvider.update(
              widget.korisnikUloga!.korisnikUlogaId!,
              KorisnikUloga.fromJson(mutableFormData));
          _showSuccessMessage('User role successfully updated!');
        }
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the role. Please try again.')),
        );
      }
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
                  widget.korisnikUloga == null
                      ? 'Adding a new role for user'
                      : 'Updating user role',
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
                  name: "datumIzmjene",
                  readOnly: true,
                  initialValue: _initialValue['datumIzmjene'],
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
                      _formKey.currentState?.fields['datumIzmjene']
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
                FormBuilderDropdown<String>(
                    name: 'korisnikId',
                    decoration: InputDecoration(
                      labelText: 'Korisnik',
                    ),
                    items: _korisnik
                            ?.map((korisnik) => DropdownMenuItem<String>(
                                value: korisnik.korisnikId.toString(),
                                child: Text(korisnik.ime ?? "")))
                            .toList() ??
                        [],
                    initialValue: _selectedKorisnikId,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'ulogaId',
                    decoration: InputDecoration(
                      labelText: 'Uloga',
                    ),
                    items: _uloga
                            ?.map((uloga) => DropdownMenuItem<String>(
                                  value: uloga.ulogaId.toString(),
                                  child: Text(uloga.naziv ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['ulogaId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUlogaId = value;
                      });
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
                  child: Text(widget.korisnikUloga == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.korisnikUloga != null ? "User Role:" : "User Role Details",
    );
  }
}
