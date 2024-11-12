import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class KorisniciDetailsScreen extends StatefulWidget {
  final Korisnik? korisnik;
  KorisniciDetailsScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<KorisniciDetailsScreen> createState() => _KorisniciDetailsScreenState();
}

class _KorisniciDetailsScreenState extends State<KorisniciDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.korisnik?.ime,
      'prezime': widget.korisnik?.prezime,
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'email': widget.korisnik?.email,
      'telefon': widget.korisnik?.telefon,
      'datumRodjenja': widget.korisnik?.datumRodjenja,
      'spol': widget.korisnik?.spol,
      'lozinka': widget.korisnik?.password,
      'potvrdaPassworda': widget.korisnik?.potvrdaPassworda,
      'korisnikUlogas': widget.korisnik?.korisnikUlogas ?? [],
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      try {
        if (widget.korisnik == null) {
          await _korisnikProvider.insert(Korisnik.fromJson(formData));
          Navigator.of(context).pop('success');
        } else {
          await _korisnikProvider.update(
              widget.korisnik!.korisnikId!, Korisnik.fromJson(formData));
          Navigator.of(context).pop('updated');
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Error"),
            content:
                Text("Failed to save user. Please try again: ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
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
                  'Detaljni prikaz podataka korisnika',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Ime",
                    border: OutlineInputBorder(),
                  ),
                  name: "ime",
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
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Prezime",
                    border: OutlineInputBorder(),
                  ),
                  name: "prezime",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    } else if (!RegExp(r'^[a-zA-ZšđčćžŠĐČĆŽ\s]+$')
                        .hasMatch(value)) {
                      return 'Prezime može sadržavati samo slova.';
                    } else if (value.length < 3) {
                      return 'Morate unijeti najmanje 3 karaktera.';
                    } else if (value.length > 50) {
                      return 'Premašili ste maksimalan broj karaktera (50).';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Korisnicko ime",
                    border: OutlineInputBorder(),
                  ),
                  name: "korisnickoIme",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  name: "email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Lozinka",
                    border: OutlineInputBorder(),
                  ),
                  name: "password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Potvrda lozinke",
                    border: OutlineInputBorder(),
                  ),
                  name: "potvrdaPassworda",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Telefon",
                    border: OutlineInputBorder(),
                  ),
                  name: "telefon",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Spol",
                    border: OutlineInputBorder(),
                  ),
                  name: "spol",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Datum rodjenja",
                    border: OutlineInputBorder(),
                  ),
                  name: "datumRodjenja",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Datum u formatu yyyy-mm-dd';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child:
                      Text(widget.korisnik == null ? 'Dodaj' : 'Uredi podatke'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.korisnik != null
          ? "Korisnik: ${widget.korisnik?.ime}"
          : "Korisnik details",
    );
  }
}
