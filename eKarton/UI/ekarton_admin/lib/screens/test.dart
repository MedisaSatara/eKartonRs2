import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/search_result.dart';
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
  SearchResult<Pacijent>? pacijentResult;
  late PacijentProvider _pacijentProvider;
  late Map<String, dynamic> _initialValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.pacijent?.ime,
      'brojKartona': widget.pacijent?.brojKartona,
      'prezime': widget.pacijent?.prezime,
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
    final formState = _formKey.currentState;

    if (formState == null) {
      print('Form state is null');
      return;
    }

    if (formState.saveAndValidate()) {
      final formData = formState.value;
      print('Form data: $formData');

      try {
        if (widget.pacijent == null) {
          // Insert new patient
          await _pacijentProvider.insert(Pacijent.fromJson(formData));
        } else {
          // Update existing patient
          final patientId = widget.pacijent?.pacijentId;
          if (patientId == null) {
            throw Exception('Patient ID is null');
          }
          await _pacijentProvider.update(
            patientId,
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
      final validationErrors = formState.errors;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 2),
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPersonalInfoCard(),
                    SizedBox(height: 16),
                    _buildAdditionalInfoCard(),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                          widget.pacijent == null ? 'Dodaj' : 'Uredi podatke'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      title: widget.pacijent != null
          ? "Pacijent: ${widget.pacijent?.ime} ${widget.pacijent?.prezime}"
          : "Pacijent details",
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Ime pacijenta",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                name: "ime",
                initialValue: _initialValue['ime'],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Prezime pacijenta",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                name: "prezime",
                initialValue: _initialValue['prezime'],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Broj kartona",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                name: "brojKartona",
                initialValue: _initialValue['brojKartona'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Card(
      elevation: 5,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Osobni podaci"),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Spol",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "spol",
              initialValue: _initialValue['spol'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Datum rodjenja",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "datumRodjenja",
              initialValue: _initialValue['datumRodjenja'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "JMBG",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "jmbg",
              initialValue: _initialValue['jmbg'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Telefon",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "telefon",
              initialValue: _initialValue['telefon'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Card(
      elevation: 5,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dodatni podaci"),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Prebivaliste",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "prebivaliste",
              initialValue: _initialValue['prebivaliste'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Mjesto rodjenja",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "mjestoRodjenja",
              initialValue: _initialValue['mjestoRodjenja'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Krvna grupa",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "krvnaGrupa",
              initialValue: _initialValue['krvnaGrupa'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Rh faktor",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "rhFaktor",
              initialValue: _initialValue['rhFaktor'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Alergican",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "alergican",
              initialValue: _initialValue['alergican'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "Hronicne bolesti",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "hronicneBolesti",
              initialValue: _initialValue['hronicneBolesti'],
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: "koagulopatija",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              name: "koagulopatija",
              initialValue: _initialValue['koagulopatija'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
