import 'dart:convert';

import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OdjelDetailsScreen extends StatefulWidget {
  final Odjel? odjel;
  final Function? onDataChanged;
  OdjelDetailsScreen({Key? key, this.odjel, this.onDataChanged})
      : super(key: key);

  @override
  State<OdjelDetailsScreen> createState() => _OdjelDetailsScreen();
}

class _OdjelDetailsScreen extends State<OdjelDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late OdjelProvider _odjelProvider;
  late BolnicaProvider _bolnicaProvider;

  List<Odjel>? _odjel;
  List<Bolnica>? _bolnica;

  String? _selectedBolnicaId;
  String? _bolnicaIme;

  late Map<String, dynamic> _initialValue;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'naziv': widget.odjel?.naziv,
      'telefon': widget.odjel?.telefon,
      'bolnicaId': widget.odjel?.bolnicaId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _odjelProvider = context.read<OdjelProvider>();
    _bolnicaProvider = context.read<BolnicaProvider>();

    _fetchBolnica();
  }

  Future<void> _fetchBolnica() async {
    try {
      var bolnicaData = await _bolnicaProvider.get();
      setState(() {
        _bolnica = bolnicaData.result;
        if (_bolnica != null && _bolnica!.isNotEmpty) {
          var bolnica = _bolnica![0];
          _bolnicaIme = bolnica.naziv;
          _selectedBolnicaId = bolnica.bolnicaId.toString();

          _initialValue['bolnicaId'] = _selectedBolnicaId;
        }
      });
    } catch (e) {
      print('Error fetching bolnica: $e');
    }
  }

  Future<void> _fetchOdjeli() async {
    try {
      var odjelData = await _odjelProvider.get();
      setState(() {
        _odjel = odjelData.result;
      });
    } catch (e) {
      print('Error fetching odjeli: $e');
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

      if (_selectedBolnicaId != null) {
        mutableFormData['bolnicaId'] =
            int.tryParse(_selectedBolnicaId ?? '') ?? 0;
      }

      if (mutableFormData['naziv'] != null) {
        mutableFormData['naziv'] = mutableFormData['naziv'] as String;
      }

      try {
        if (widget.odjel == null) {
          await _odjelProvider.insert(Odjel.fromJson(mutableFormData));
          _showSuccessMessage('Odjel successfully added!');
        } else {
          await _odjelProvider.update(
              widget.odjel!.odjelId!, Odjel.fromJson(mutableFormData));
          _showSuccessMessage('Odjel successfully updated!');
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the term. Please try again.')),
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
                  widget.odjel == null
                      ? 'Adding a new department'
                      : 'Updating department',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Department name",
                      border: OutlineInputBorder(),
                    ),
                    name: "naziv",
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
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Ovo polje može sadržavati samo brojeve.';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                Text(
                  'Hosipital: $_bolnicaIme',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.odjel == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.odjel != null ? "Department:" : "Department details",
    );
  }
}
