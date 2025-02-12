import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/screens/korisnik_details_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KorisnikScreen extends StatefulWidget {
  const KorisnikScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikScreen> createState() => _KorisnikScreen();
}

class _KorisnikScreen extends State<KorisnikScreen> {
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? result;
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  String? _successMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _fetchKorisnici();
  }

  Future<void> _fetchKorisnici() async {
    var data = await _korisnikProvider.get(filter: {
      'ime': _imeController.text.trim().toLowerCase(),
      'prezime': _prezimeController.text.trim().toLowerCase(),
      'korisnickoIme': _korisnickoImeController.text.trim().toLowerCase(),
    });
    print('Fetched korisnici: ${data.result.length}');
    setState(() {
      result = data;
    });
  }

  Future<void> _navigateToAddUser() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => KorisniciDetailsScreen()),
    );

    if (result == 'success') {
      _showSnackbar('Korisnik uspješno dodan!');
      await _fetchKorisnici();
    } else if (result == 'updated') {
      _showSnackbar('Korisnik uspješno ažuriran!');
      await _fetchKorisnici();
    }

    await _fetchKorisnici();
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("User list"),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: const Color.fromARGB(255, 63, 125, 137),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                if (_successMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _successMessage!,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                _buildSearch(),
                _buildButton(),
                const SizedBox(height: 12),
                Expanded(child: _buildDataListView()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Spacer(),
          ElevatedButton(
            onPressed: _navigateToAddUser,
            child: Text(
              "Add New User",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 63, 125, 137),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 246, 246),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                controller: _imeController,
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Last name",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 246, 246),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                controller: _prezimeController,
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 246, 246),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                controller: _korisnickoImeController,
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _fetchKorisnici();
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 63, 125, 137),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    return ListView.builder(
      itemCount: result?.result.length ?? 0,
      itemBuilder: (context, index) {
        var korisnik = result!.result[index];
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('${korisnik.ime} ${korisnik.prezime}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(korisnik.korisnickoIme ?? ""),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[900],
              child: Text(korisnik.ime?[0] ?? '',
                  style: TextStyle(color: Colors.white)),
            ),
            onTap: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => KorisniciDetailsScreen(
                  korisnik: korisnik,
                ),
              ));
              if (result != null) {
                _fetchKorisnici();
              }
            },
          ),
        );
      },
    );
  }
}
