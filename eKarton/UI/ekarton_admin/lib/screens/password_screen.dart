import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int korisnikId;
  ChangePasswordScreen({Key? key, required this.korisnikId}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordFormKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  Future<void> _changePassword() async {
    if (_passwordFormKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formData =
          Map.from(_passwordFormKey.currentState!.value);

      try {
        String oldPassword = formData['oldPassword'] ?? '';
        String newPassword = formData['password'] ?? '';

        bool success = await _korisnikProvider.promeniLozinku(
            widget.korisnikId, oldPassword, newPassword);

        if (success) {
          _showSuccessDialog('Password changed successfully');
        } else {
          _showErrorDialog('You enter old password!');
        }
      } catch (e) {
        print('Error changing password: $e');
        _showErrorDialog('You enter old password!');
      }
    }
  }

  void _showSuccessDialog(String message) {
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _passwordFormKey,
          child: Column(
            children: [
              _buildFormField("Old Password", "oldPassword", Icons.lock,
                  obscureText: true),
              SizedBox(height: 16),
              _buildFormField("New Password", "password", Icons.lock,
                  obscureText: true),
              SizedBox(height: 16),
              _buildFormField(
                  "Confirm New Password", "confirmPassword", Icons.lock_outline,
                  obscureText: true),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('Save Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String name, IconData icon,
      {bool obscureText = false}) {
    return FormBuilderTextField(
      name: name,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon, color: Colors.blueGrey),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
