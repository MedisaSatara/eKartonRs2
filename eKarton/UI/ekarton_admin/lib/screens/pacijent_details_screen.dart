import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PacijentiDetailsScreen extends StatefulWidget {
  final Pacijent? pacijent;
  PacijentiDetailsScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<PacijentiDetailsScreen> createState() => _PacijentiDetailsScreenState();
}

class _PacijentiDetailsScreenState extends State<PacijentiDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late Map<String, dynamic> _initialValue;

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
      'korisnickoIme': widget.pacijent?.korisnickoIme,
      'krvnaGrupa': widget.pacijent?.krvnaGrupa,
    };
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
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ),
      title: widget.pacijent?.ime ?? "Pacijent details",
    );
  }

  Widget _buildHeader() {
    return Row(
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
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              labelText: "Korisnicko ime",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            name: "korisnickoIme",
            initialValue: _initialValue['korisnickoIme'],
          ),
        ],
      ),
    );
  }
}
