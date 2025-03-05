import 'dart:convert';

import 'package:ekarton_admin/models/doktor.dart';
import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/providers/doktor_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DoktorDetailsScreen extends StatefulWidget {
  final Doktor? doktor;
  final Function? onDataChanged;
  DoktorDetailsScreen({Key? key, this.doktor, this.onDataChanged})
      : super(key: key);

  @override
  State<DoktorDetailsScreen> createState() => _DoktorDetailsScreen();
}

class _DoktorDetailsScreen extends State<DoktorDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late DoktorProvider _doktorProvider;
  late OdjelProvider _odjelProvider;

  List<Odjel>? _odjeli;
  List<Doktor>? _doktori;

  String? _selectedOdjelId;
  String? _selectedDoktorId;
  String? _odjelNaziv;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  List<Map<String, String>> stateOptions = [
    {"display": "active", "value": "active"},
    {"display": "draft", "value": "draft"},
    {"display": "cancelled", "value": "cancelled"},
  ];

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.doktor?.ime,
      'prezime': widget.doktor?.prezime,
      'jmbg': widget.doktor?.jmbg,
      'email': widget.doktor?.email,
      'datumRodjenja': widget.doktor?.datumRodjenja,
      'grad': widget.doktor?.grad,
      'telefon': widget.doktor?.telefon,
      'spol': widget.doktor?.spol,
      'odjelId': widget.doktor?.odjelId,
      'stateMachine': widget.doktor?.stateMachine,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _doktorProvider = context.read<DoktorProvider>();
    _odjelProvider = context.read<OdjelProvider>();

    _fetchPatients();
    _fetchDoktori();
  }

  Future<void> _fetchPatients() async {
    try {
      var odjelData = await _odjelProvider.get();
      setState(() {
        _odjeli = odjelData.result;
        if (widget.doktor?.odjelId != null) {
          var odjel = _odjeli?.firstWhere(
            (p) => p.odjelId == widget.doktor?.odjelId,
          );
          _odjelNaziv = odjel?.naziv;
        }
      });
    } catch (e) {
      print('Error fetching odjel: $e');
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

      if (mutableFormData['odjelId'] != null) {
        mutableFormData['odjelId'] =
            int.tryParse(mutableFormData['odjelId'] as String) ?? 0;
      }
      if (mutableFormData['doktorId'] != null) {
        mutableFormData['doktorId'] =
            int.tryParse(mutableFormData['doktorId'] as String) ?? 0;
      }
      if (mutableFormData['stateMachine'] != null) {
        mutableFormData['stateMachine'] =
            mutableFormData['stateMachine'] as String;
      }

      try {
        if (widget.doktor == null) {
          await _doktorProvider.insert(Doktor.fromJson(mutableFormData));
          _showSuccessMessage('Doctor successfully added!');
        } else {
          await _doktorProvider.update(
              widget.doktor!.doktorId!, Doktor.fromJson(mutableFormData));
          _showSuccessMessage('Doctor successfully updated!');
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save doctor. Please try again.')),
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
                  widget.doktor == null
                      ? 'Adding a new doctor'
                      : 'Updating doctor',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Birth date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  name: "datumRodjenja",
                  readOnly: true,
                  initialValue: _initialValue['datumRodjenja'],
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

                      _formKey.currentState?.fields['datumRodjenja']
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
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    name: "ime",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    name: "prezime",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                    name: "telefon",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
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
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "City",
                      border: OutlineInputBorder(),
                    ),
                    name: "grad",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "JMBG",
                      border: OutlineInputBorder(),
                    ),
                    name: "jmbg",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
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
                FormBuilderDropdown<String>(
                    name: 'odjelId',
                    decoration: InputDecoration(
                      labelText: 'Department',
                    ),
                    items: _odjeli
                            ?.map((odjel) => DropdownMenuItem<String>(
                                  value: odjel.odjelId.toString(),
                                  child: Text(odjel.naziv ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['odjelId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedOdjelId = value;
                      });
                      print("Odabrani odjelId: $_selectedOdjelId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.doktor == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.doktor != null ? "Doctor: " : "Doctor details",
    );
  }
}
