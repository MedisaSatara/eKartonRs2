import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
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
      'alergican': widget.pacijent?.alergican,
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
        if (widget.pacijent == null) {
          // Insert new patient
          await _pacijentProvider.insert(Pacijent.fromJson(formData));
        } else {
          // Update existing patient
          if (widget.pacijent!.pacijentId == null) {
            throw Exception('Patient ID is null');
          }
          await _pacijentProvider.update(
            widget.pacijent!.pacijentId!,
            Pacijent.fromJson(formData),
          );
        }
        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save patient. Please try again.')),
        );
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      print('Validation errors: $validationErrors');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Form validation failed. Please correct the errors and try again.')),
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
                    fontSize: 24, // Adjusted size for better readability
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'ime',
                  decoration: InputDecoration(
                    labelText: 'Ime',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'prezime',
                  decoration: InputDecoration(
                    labelText: 'Prezime',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'brojKartona',
                  decoration: InputDecoration(
                    labelText: 'Broj kartona',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'datumRodjenja',
                  decoration: InputDecoration(
                    labelText: 'Datum rodjenja',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'spol',
                  decoration: InputDecoration(
                    labelText: 'Spol',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'jmbg',
                  decoration: InputDecoration(
                    labelText: 'JMBG',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'mjestoRodjenja',
                  decoration: InputDecoration(
                    labelText: 'Mjesto rodjenja',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'prebivaliste',
                  decoration: InputDecoration(
                    labelText: 'Prebivaliste',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'telefon',
                  decoration: InputDecoration(
                    labelText: 'Telefon',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'krvnaGrupa',
                  decoration: InputDecoration(
                    labelText: 'Krva grupa',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'rhFaktor',
                  decoration: InputDecoration(
                    labelText: 'Rh faktor',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'hronicneBolesti',
                  decoration: InputDecoration(
                    labelText: 'Hronicne bolesti',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'alergican',
                  decoration: InputDecoration(
                    labelText: 'Alergican',
                    border: OutlineInputBorder(),
                  ),
                ),
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
