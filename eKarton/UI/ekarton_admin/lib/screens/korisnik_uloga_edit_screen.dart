import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/korisnik_uloga.dart';
import 'package:ekarton_admin/models/uloga.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/korisnik_uloga_provider.dart';
import 'package:ekarton_admin/providers/uloga_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KorisnikUlogaEditScreen extends StatefulWidget {
  final KorisnikUloga korisnikUloga;
  final VoidCallback onDataChanged;

  const KorisnikUlogaEditScreen({
    Key? key,
    required this.korisnikUloga,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<KorisnikUlogaEditScreen> createState() =>
      _KorisnikUlogaEditScreenState();
}

class _KorisnikUlogaEditScreenState extends State<KorisnikUlogaEditScreen> {
  late TextEditingController _datumIzmjeneController;

  List<Uloga> uloge = [];
  Uloga? selectedUloga;
  Korisnik? korisnik;

  @override
  void initState() {
    super.initState();

    _datumIzmjeneController =
        TextEditingController(text: widget.korisnikUloga.datumIzmjene);

    _fetchUloge();
    _fetchKorisnik();
  }

  Future<void> _fetchUloge() async {
    var ulogaData = await context.read<UlogaProvider>().get();
    setState(() {
      uloge = ulogaData.result;
      selectedUloga = uloge.firstWhere(
        (uloga) => uloga.ulogaId == widget.korisnikUloga.ulogaId,
        orElse: () => uloge.first,
      );
    });
  }

  Future<void> _fetchKorisnik() async {
    var korisnikData = await context.read<KorisnikProvider>().get();
    setState(() {
      korisnik = korisnikData.result.firstWhere(
        (k) => k.korisnikId == widget.korisnikUloga.korisnikId,
        orElse: () => Korisnik(),
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.korisnikUloga.datumIzmjene!) ??
          DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _datumIzmjeneController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Role"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User: ${korisnik?.ime ?? 'N/A'} ${korisnik?.prezime ?? 'N/A'}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Edit User Role:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              DropdownButton<Uloga>(
                value: selectedUloga,
                onChanged: (Uloga? newValue) {
                  setState(() {
                    selectedUloga = newValue;
                  });
                },
                isExpanded: true,
                items: uloge.map<DropdownMenuItem<Uloga>>((Uloga value) {
                  return DropdownMenuItem<Uloga>(
                    value: value,
                    child: Text(
                      value.naziv ?? 'Unknown Role',
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _datumIzmjeneController,
                decoration: const InputDecoration(
                  labelText: 'Last Modified',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: _saveData,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    if (selectedUloga != null) {
      widget.korisnikUloga.ulogaId = selectedUloga?.ulogaId;
      widget.korisnikUloga.datumIzmjene = _datumIzmjeneController.text;

      try {
        DateTime datumIzmjene =
            DateFormat('dd/MM/yyyy').parse(widget.korisnikUloga.datumIzmjene!);

        await context.read<KorisnikUlogaProvider>().update(
          widget.korisnikUloga.korisnikUlogaId!,
          {
            'korisnikId': widget.korisnikUloga.korisnikId,
            'ulogaId': widget.korisnikUloga.ulogaId,
            'datumIzmjene': datumIzmjene.toIso8601String(),
          },
        );

        widget.onDataChanged();

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User role updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user role: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
    }
  }
}
