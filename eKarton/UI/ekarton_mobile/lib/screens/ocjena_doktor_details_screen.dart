import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
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

    var currentUser = _korisnikProvider.currentUser;
    print(currentUser);

    if (currentUser != null) {
      _initialValue['korisnikId'] = currentUser.korisnikId.toString();
    }

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
        mutableFormData['ocjena'] = mutableFormData['ocjena'] is int
            ? mutableFormData['ocjena']
            : int.tryParse(mutableFormData['ocjena'].toString()) ?? 0;
      }

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] = mutableFormData['korisnikId'] is int
            ? mutableFormData['korisnikId']
            : int.tryParse(mutableFormData['korisnikId'].toString()) ?? 0;
      }

      if (mutableFormData['doktorId'] != null) {
        mutableFormData['doktorId'] = mutableFormData['doktorId'] is int
            ? mutableFormData['doktorId']
            : int.tryParse(mutableFormData['doktorId'].toString()) ?? 0;
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

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecommendedDoctorsScreen(),
                    ),
                  );
                },
                child: Text('Recommended doctors'),
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
                  'Add doctors rating',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '${_korisnikProvider.currentUser?.ime ?? 'Nepoznat korisnik'}, welcome to the section for adding Your rate for doctors.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    'Think good, and keep on your mind that on your rate depends future of doctors and patients opinion.'),
                Offstage(
                  offstage: true,
                  child: FormBuilderTextField(
                    name: 'korisnikId',
                    initialValue:
                        _korisnikProvider.currentUser?.korisnikId.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Korisnik (ID)',
                      border: OutlineInputBorder(),
                      hintText: "Nepoznat korisnik",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderDropdown<int>(
                  name: 'ocjena',
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(5, (index) {
                    int rating = index + 1;
                    return DropdownMenuItem<int>(
                      value: rating,
                      child: Text(rating.toString()),
                    );
                  }),
                  initialValue: _initialValue['ocjena'],
                  onChanged: (value) {
                    setState(() {
                      _selectedDoktorId = value?.toString();
                    });
                    print("Odabrana ocjena: $value");
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Reason",
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
                    labelText: 'Doctor',
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
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
