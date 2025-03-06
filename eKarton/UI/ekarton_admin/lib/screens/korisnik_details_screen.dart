import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/korisnik_uloga_provider.dart';
import 'package:ekarton_admin/screens/korisnik_uloga_screen.dart';
import 'package:ekarton_admin/screens/password_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KorisniciDetailsScreen extends StatefulWidget {
  final Korisnik? korisnik;
  final Function? onDataChanged;

  KorisniciDetailsScreen({Key? key, this.korisnik, this.onDataChanged})
      : super(key: key);

  @override
  State<KorisniciDetailsScreen> createState() => _KorisniciDetailsScreenState();
}

class _KorisniciDetailsScreenState extends State<KorisniciDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late Map<String, dynamic> _initialValue;
  late KorisnikUlogaProvider _korisnikUlogaProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.korisnik?.ime,
      'prezime': widget.korisnik?.prezime,
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'email': widget.korisnik?.email,
      'telefon': widget.korisnik?.telefon,
      'datumRodjenja': widget.korisnik?.datumRodjenja != null
          ? DateTime.parse(widget.korisnik!.datumRodjenja!.replaceAll('/', '-'))
          : null,
      'spol': widget.korisnik?.spol,
      'korisnikUlogas': widget.korisnik?.korisnikUlogas ?? [],
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _korisnikUlogaProvider = context.read<KorisnikUlogaProvider>();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formData = Map.from(_formKey.currentState!.value);

      try {
        if (formData['datumRodjenja'] != null &&
            formData['datumRodjenja'] is DateTime) {
          formData['datumRodjenja'] =
              DateFormat('yyyy-MM-dd').format(formData['datumRodjenja']);
        }

        if (widget.korisnik == null) {
          await _korisnikProvider.insert(Korisnik.fromJson(formData));
          _showSuccessDialog('User added successfully', 'success');
        } else {
          await _korisnikProvider.update(
              widget.korisnik!.korisnikId!, Korisnik.fromJson(formData));
          if (widget.onDataChanged != null) {
            widget.onDataChanged!();
          }

          Navigator.pop(context);

          _showSnackbar('User updated successfully');
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Error"),
            content:
                Text("Failed to save user. Please try again: ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessDialog(String message, String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.korisnik == null) {
                  _showAddRoleDialog();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAddRoleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Role'),
          content: Text('Do you want to add a role to this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KorisnikUlogaScreen(korisnik: widget.korisnik),
                  ),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
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
                  widget.korisnik != null
                      ? 'Edit User Details'
                      : 'Add New User',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildFormField("First name", "ime", Icons.person),
                SizedBox(height: 16),
                _buildFormField("Last name", "prezime", Icons.person_outline),
                SizedBox(height: 16),
                _buildFormField(
                    "Username", "korisnickoIme", Icons.account_circle),
                SizedBox(height: 16),
                _buildFormField("Email", "email", Icons.email),
                SizedBox(height: 16),
                _buildFormField("Phone number", "telefon", Icons.phone),
                SizedBox(height: 16),
                _buildGenderDropdown(),
                SizedBox(height: 16),
                _buildDatePicker(),
                SizedBox(height: 24),
                if (widget.korisnik == null) ...[
                  _buildFormField("Password", "password", Icons.lock,
                      obscureText: true),
                  SizedBox(height: 16),
                  _buildFormField(
                      "Confirm password", "confirmPassword", Icons.lock_outline,
                      obscureText: true),
                  SizedBox(height: 16),
                ],
                if (widget.korisnik != null) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(
                                korisnikId: widget.korisnik!.korisnikId!),
                          ),
                        );
                      },
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _submitForm,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 63, 125, 137),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.korisnik == null ? 'Add' : 'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 63, 125, 137),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.korisnik != null
          ? "User: ${widget.korisnik?.ime}"
          : "User Details",
    );
  }

  Widget _buildFormField(String label, String name, IconData icon,
      {bool obscureText = false}) {
    return FormBuilderTextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 63, 125, 137)),
      ),
      name: name,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return FormBuilderDateTimePicker(
      name: "datumRodjenja",
      inputType: InputType.date,
      format: DateFormat('yyyy-MM-dd'),
      decoration: InputDecoration(
        labelText: "Date of Birth",
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.calendar_today,
            color: const Color.fromARGB(255, 63, 125, 137)),
      ),
      validator: (value) {
        if (value == null) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return FormBuilderDropdown(
      name: 'spol',
      decoration: InputDecoration(
        labelText: "Gender",
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.person_add_alt_1,
            color: const Color.fromARGB(255, 63, 125, 137)),
      ),
      items: [
        DropdownMenuItem(value: 'M', child: Text('Muški')),
        DropdownMenuItem(value: 'Ž', child: Text('Ženski')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
