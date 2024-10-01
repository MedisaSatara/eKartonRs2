import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OcjenaDoktorDetailsScreen extends StatefulWidget {
  final OcjeneDoktor? ocjeneDoktor;
  OcjenaDoktorDetailsScreen({Key? key, this.ocjeneDoktor}) : super(key: key);

  @override
  State<OcjenaDoktorDetailsScreen> createState() =>
      _OcjenaDoktorDetailsScreen();
}

class _OcjenaDoktorDetailsScreen extends State<OcjenaDoktorDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late OcjenaDoktorProvider _ocjenaDoktorProvider;
  late DoktorProvider _doktorProvider;

  List<Korisnik>? _korisnik;
  List<Doktor>? _doktori;
  List<OcjeneDoktor>? _ocjeneDoktor;

  String? _selectedKorisnikId;
  String? _selectedDoktorId;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ocjena': widget.ocjeneDoktor?.ocjena,
      'razlog': widget.ocjeneDoktor?.razlog,
      'korisnikId': widget.ocjeneDoktor?.korisnikId,
      'doktorId': widget.ocjeneDoktor?.doktorId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ocjenaDoktorProvider = context.read<OcjenaDoktorProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _doktorProvider = context.read<DoktorProvider>();

    _fetchOcjene();
    _fetchKorisnici();
    _fetchDoktori();
  }

  Future<void> _fetchOcjene() async {
    try {
      var ocjeneDoktordata = await _ocjenaDoktorProvider.get();
      setState(() {
        _ocjeneDoktor = ocjeneDoktordata.result;
      });
    } catch (e) {
      print('Error fetching ocjene: $e');
    }
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnik = korisnikData.result;
      });
    } catch (e) {
      print('Error fetching korisnici: $e');
    }
  }

  Future<void> _fetchDoktori() async {
    try {
      var doktoriData = await _doktorProvider.get();
      setState(() {
        _doktori = doktoriData.result;
      });
    } catch (e) {
      print('Error fetching doktori: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['ocjena'] != null) {
        mutableFormData['ocjena'] =
            int.tryParse(mutableFormData['ocjena'] as String) ?? 0;
      }

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] =
            int.tryParse(mutableFormData['korisnikId'] as String) ?? 0;
      }
      if (mutableFormData['doktorId'] != null) {
        mutableFormData['doktorId'] =
            int.tryParse(mutableFormData['doktorId'] as String) ?? 0;
      }
      try {
        String successMessage;

        if (widget.ocjeneDoktor == null) {
          await _ocjenaDoktorProvider
              .insert(OcjeneDoktor.fromJson(mutableFormData));
          successMessage = 'Ocjena uspješno dodana.';
        } else {
          if (widget.ocjeneDoktor!.ocjenaId == null) {
            throw Exception('Ocjena ID is null');
          }
          await _ocjenaDoktorProvider.update(
            widget.ocjeneDoktor!.ocjenaId!,
            OcjeneDoktor.fromJson(mutableFormData),
          );
          successMessage = 'Ocjena uspješno uređena.';
        }

        // Prikaz popup-a
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Uspjeh'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                  Navigator.of(context)
                      .pop(); // Returns to the previous screen with all doctor reviews
                },
                child: Text('Uredu'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecommendedDoctorsScreen(),
                    ),
                  );
                },
                child: Text('Preporučeni doktori'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save the evaluation. Please try again.'),
          ),
        );
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      print('Validation errors: $validationErrors');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Form validation failed. Please correct the errors and try again.',
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
                  'Dodaj ocjenu doktoru',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Ocjena",
                    border: OutlineInputBorder(),
                  ),
                  name: "ocjena",
                  keyboardType:
                      TextInputType.number, // Set keyboard type to number
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
                    labelText: "Razlog",
                    border: OutlineInputBorder(),
                  ),
                  name: "razlog",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'doktorId',
                  decoration: InputDecoration(
                    labelText: 'Doktor',
                  ),
                  items: _doktori
                          ?.map((doktor) => DropdownMenuItem<String>(
                                value: doktor.doktorId.toString(),
                                child: Text(doktor.ime ?? ""),
                              ))
                          .toList() ??
                      [],
                  initialValue: _initialValue['doktorId']?.toString(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDoktorId = value;
                    });
                    print("Odabrani doktorId: $_selectedDoktorId");
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
                  items: _korisnik
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
                    print("Odabrani korisnikId: $_selectedKorisnikId");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Spremi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
