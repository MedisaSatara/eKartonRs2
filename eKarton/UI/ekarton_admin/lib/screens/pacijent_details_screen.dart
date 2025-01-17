import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
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
  List<PreventivneMjere> preventiveMjereForPacijent = [];
  Future<void> testDeserialization() async {
    Map<String, dynamic> sampleJson = {
      'datumRodjenja': '1990-08-15T00:00:00.000Z'
    };

    Pacijent pacijent = Pacijent.fromJson(sampleJson);
    print('Parsed Date of Birth: ${pacijent.datumRodjenja}');
  }

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
    _preventivneMjereProvider = context.read<PreventivneMjereProvider>();
    _pacijentProvider = context.read<PacijentProvider>();

    if (widget.pacijent != null) {
      _loadPreventivneMjere();
    }
  }

  Future<void> _loadPreventivneMjere() async {
    try {
      final result = await _preventivneMjereProvider.get();
      if (result != null && result.result.isNotEmpty) {
        setState(() {
          preventiveMjereForPacijent = result.result
              .where((mj) => mj.pacijentId == widget.pacijent!.pacijentId)
              .toList();
        });
      }
    } catch (e) {
      print('Greška pri dohvaćanju preventivnih mjera: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      try {
        String successMessage;
        if (widget.pacijent == null) {
          await _pacijentProvider.insert(Pacijent.fromJson(formData));
          successMessage = 'Patient successufully added.';
        } else {
          if (widget.pacijent!.pacijentId == null) {
            throw Exception('Patient ID is null');
          }
          await _pacijentProvider.update(
            widget.pacijent!.pacijentId!,
            Pacijent.fromJson(formData),
          );
          successMessage = 'Patient successufully updated.';
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

  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete confirmation'),
              content: Text(
                  'Are you sure you want to delete patients preventive measure?'),
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

  Widget _buildPreventivneMjereList() {
    if (preventiveMjereForPacijent.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: preventiveMjereForPacijent.map((mj) {
          return Row(
            children: [
              Expanded(
                child: Text('Preventive measure: ${mj.stanje}'),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool confirmDelete = await _showConfirmationDialog();
                  if (confirmDelete) {
                    await _preventivneMjereProvider
                        .delete(mj.preventivneMjereId);
                    _loadPreventivneMjere();
                  }
                },
              ),
            ],
          );
        }).toList(),
      );
    } else {
      return Text('This patient does not have any preventive measure!');
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
                  'Patient deatiled list of informations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                    name: 'ime',
                    decoration: InputDecoration(
                      labelText: 'First name',
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
                      labelText: 'Last name',
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
                    name: 'brojKartona',
                    decoration: InputDecoration(
                      labelText: 'Carton number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 16),
                FormBuilderDateTimePicker(
                  name: 'datumRodjenja',
                  decoration: InputDecoration(
                    labelText: 'Date of birth',
                    border: OutlineInputBorder(),
                  ),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                  validator: (value) {
                    if (value == null) return 'Molimo odaberite datum';
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderRadioGroup<String>(
                  name: 'spol',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  options: [
                    FormBuilderFieldOption(value: 'M', child: Text('Male')),
                    FormBuilderFieldOption(value: 'Z', child: Text('Female')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Odaberite spol.';
                    }
                  },
                ),
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
                      labelText: 'Birth city',
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
                      labelText: 'Residence',
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
                      labelText: 'Phone number',
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
                FormBuilderDropdown<String>(
                  name: 'krvnaGrupa',
                  decoration: InputDecoration(
                    labelText: 'Blood type',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'A', child: Text('A')),
                    DropdownMenuItem(value: 'B', child: Text('B')),
                    DropdownMenuItem(value: 'AB', child: Text('AB')),
                    DropdownMenuItem(value: 'O', child: Text('O')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Odaberite krvnu grupu.';
                    }
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'rhFaktor',
                  decoration: InputDecoration(
                    labelText: 'Rh factor',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: '+', child: Text('Rh+')),
                    DropdownMenuItem(value: '-', child: Text('Rh-')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Odaberite Rh faktor.';
                    }
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                    name: 'hronicneBolesti',
                    decoration: InputDecoration(
                      labelText: 'Chronic diseases',
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
                      labelText: 'Allergy',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                    }),
                SizedBox(height: 24),
                _buildPreventivneMjereList(),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.pacijent == null ? 'Add' : 'Edit data'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.pacijent != null
          ? "Patient: ${widget.pacijent?.ime}"
          : "Patient details",
    );
  }
}
