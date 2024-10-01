import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PacijentiDetailsScreen extends StatefulWidget {
  final Pacijent? pacijent;
  PacijentiDetailsScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<PacijentiDetailsScreen> createState() => _PacijentiDetailsScreenState();
}

class _PacijentiDetailsScreenState extends State<PacijentiDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PacijentProvider _pacijentProvider;
  late Map<String, dynamic> _initialValue;
  late PreventivneMjereProvider _preventivneMjereProvider;
  SearchResult<PreventivneMjere>? preventivneMjereResult;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.pacijent?.ime,
      'prezime': widget.pacijent?.prezime,
      'brojKartona': widget.pacijent?.brojKartona,
      'datumRodjenja': widget.pacijent?.datumRodjenja,
      'spol': widget.pacijent?.spol,
      'prebivaliste': widget.pacijent?.prebivaliste,
      'mjestoRodjenja': widget.pacijent?.mjestoRodjenja,
      'jmbg': widget.pacijent?.jmbg,
      'alergija': widget.pacijent?.alergija,
      'hronicneBolesti': widget.pacijent?.hronicneBolesti,
      'rhFaktor': widget.pacijent?.rhFaktor,
      'telefon': widget.pacijent?.telefon,
      'krvnaGrupa': widget.pacijent?.krvnaGrupa,
      'koagulopatija': widget.pacijent?.koagulopatija,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentProvider = context.read<PacijentProvider>();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      try {
        String successMessage;
        if (widget.pacijent == null) {
          await _pacijentProvider.insert(Pacijent.fromJson(formData));
          successMessage = 'Pacijent uspješno dodan.';
        } else {
          if (widget.pacijent!.pacijentId == null) {
            throw Exception('Patient ID is null');
          }
          await _pacijentProvider.update(
            widget.pacijent!.pacijentId!,
            Pacijent.fromJson(formData),
          );
          successMessage = 'Pacijent uspješno uređen.';
        }

        Navigator.of(context).pop(successMessage);
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Došlo je do greške. Pokušajte ponovo.')),
        );
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      print('Validation errors: $validationErrors');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Validacija obrasca nije uspjela. Molimo ispravite greške i pokušajte ponovo.',
          ),
        ),
      );
    }
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
                  'Detaljni prikaz podataka pacijenta',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                    name: 'ime',
                    decoration: InputDecoration(
                      labelText: 'Ime',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (!RegExp(r'^[a-zA-ZšđčćžŠĐČĆŽ\s]+$')
                          .hasMatch(value)) {
                        return 'Ime može sadržavati samo slova.';
                      } else if (value.length < 3) {
                        return 'Morate unijeti najmanje 3 karaktera.';
                      } else if (value.length > 50) {
                        return 'Premašili ste maksimalan broj karaktera (50).';
                      }

                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'prezime',
                    decoration: InputDecoration(
                      labelText: 'Prezime',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (!RegExp(r'^[a-zA-ZšđčćžŠĐČĆŽ\s]+$')
                          .hasMatch(value)) {
                        return 'Ime može sadržavati samo slova.';
                      } else if (value.length < 3) {
                        return 'Morate unijeti najmanje 3 karaktera.';
                      } else if (value.length > 50) {
                        return 'Premašili ste maksimalan broj karaktera (50).';
                      }

                      return null;
                    }),
                FormBuilderTextField(
                    name: 'brojKartona',
                    decoration: InputDecoration(
                      labelText: 'Broj kartona',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'datumRodjenja',
                    decoration: InputDecoration(
                      labelText: 'Datum rodjenja',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno! Datum u formatu yyyy-mm-dd';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'spol',
                    decoration: InputDecoration(
                      labelText: 'Spol',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno! Spol u formatu M/Z';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'jmbg',
                    decoration: InputDecoration(
                      labelText: 'JMBG',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (value.length > 13) {
                        return 'Premašili ste maksimalan broj karaktera (13).';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Ovo polje može sadržavati samo brojeve.';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'mjestoRodjenja',
                    decoration: InputDecoration(
                      labelText: 'Mjesto rodjenja',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'prebivaliste',
                    decoration: InputDecoration(
                      labelText: 'Prebivaliste',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'telefon',
                    decoration: InputDecoration(
                      labelText: 'Telefon',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Ovo polje može sadržavati samo brojeve.';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'krvnaGrupa',
                    decoration: InputDecoration(
                      labelText: 'Krva grupa',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'rhFaktor',
                    decoration: InputDecoration(
                      labelText: 'Rh faktor',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'hronicneBolesti',
                    decoration: InputDecoration(
                      labelText: 'Hronicne bolesti',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'alergija',
                    decoration: InputDecoration(
                      labelText: 'Alergija',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child:
                      Text(widget.pacijent == null ? 'Dodaj' : 'Uredi podatke'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.pacijent != null
          ? "Pacijent: ${widget.pacijent?.ime}"
          : "Pacijent details",
    );
  }
}
