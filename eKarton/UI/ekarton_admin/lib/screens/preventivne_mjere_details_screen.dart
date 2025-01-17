import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PreventivneMjereDetailsScreen extends StatefulWidget {
  final PreventivneMjere? preventivneMjere;

  PreventivneMjereDetailsScreen({Key? key, this.preventivneMjere})
      : super(key: key);

  @override
  State<PreventivneMjereDetailsScreen> createState() =>
      _PreventivneMjereDetailsScreen();
}

class _PreventivneMjereDetailsScreen
    extends State<PreventivneMjereDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PreventivneMjereProvider _preventivneMjereProvider;
  late PacijentProvider _pacijentProvider;
  List<Pacijent>? _pacijenti;
  String? _selectedPacijentId;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'stanje': widget.preventivneMjere?.stanje,
      'pacijentId': widget.preventivneMjere?.pacijentId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preventivneMjereProvider = context.read<PreventivneMjereProvider>();
    _pacijentProvider = context.read<PacijentProvider>();

    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      var pacijentiData = await _pacijentProvider.get();
      setState(() {
        _pacijenti = pacijentiData.result;
      });
    } catch (e) {
      print('Error fetching patients: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['pacijentId'] != null) {
        mutableFormData['pacijentId'] =
            int.tryParse(mutableFormData['pacijentId'] as String) ?? 0;
      }

      try {
        if (widget.preventivneMjere == null) {
          await _preventivneMjereProvider
              .insert(PreventivneMjere.fromJson(mutableFormData));
          Navigator.of(context).pop('Preventivne mjere uspješno dodane.');
        } else {
          await _preventivneMjereProvider.update(
              widget.preventivneMjere!.preventivneMjereId!,
              PreventivneMjere.fromJson(mutableFormData));
          Navigator.of(context).pop('Preventine mjere uspjesno uredjene.');
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to save preventive measure. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.preventivneMjere == null
                    ? 'Add Patient\'s Preventive Measure'
                    : 'Edit Patient\'s Preventive Measure',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Condition",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                name: "stanje",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              FormBuilderDropdown<String>(
                name: 'pacijentId',
                decoration: InputDecoration(
                  labelText: 'Select Patient',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
                items: _pacijenti
                        ?.map((pacijent) => DropdownMenuItem<String>(
                              value: pacijent.pacijentId.toString(),
                              child: Text(pacijent.ime ?? ""),
                            ))
                        .toList() ??
                    [],
                initialValue: _initialValue['pacijentId']?.toString(),
                onChanged: (value) {
                  setState(() {
                    _selectedPacijentId = value;
                  });
                  print("Selected Patient ID: $_selectedPacijentId");
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 125, 137),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  widget.preventivneMjere == null ? 'Add' : 'Edit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      title: widget.preventivneMjere != null
          ? "Update Preventive Measure"
          : "Details about Patient's Preventive Measure",
    );
  }
}
