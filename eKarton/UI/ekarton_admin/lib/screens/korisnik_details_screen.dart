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
      'korisnikUlogas': widget.korisnik?.korisnikUlogas,
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

      // Convert odjelId to integer if it's not null
      if (formData['odjelId'] != null) {
        formData['odjelId'] = int.parse(formData['odjelId']);
      }

      try {
        if (widget.korisnik == null) {
          await _korisnikProvider.insert(Korisnik.fromJson(formData));
        } else {
          await _korisnikProvider.update(
              widget.korisnik!.korisnikId!, Korisnik.fromJson(formData));
        }
        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Prezime",
                  border: OutlineInputBorder(),
                ),
                name: "prezime",
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Korisnicko ime",
                  border: OutlineInputBorder(),
                ),
                name: "korisnickoIme",
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                name: "email",
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Telefon",
                  border: OutlineInputBorder(),
                ),
                name: "telefon",
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                decoration: InputDecoration(
                  labelText: "Datum rodjenja",
                  border: OutlineInputBorder(),
                ),
                name: "datumRodjenja",
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
      title: widget.korisnik != null
          ? "Korisnik: ${widget.korisnik?.ime}"
          : "Korisnik details",
    );
  }
}
