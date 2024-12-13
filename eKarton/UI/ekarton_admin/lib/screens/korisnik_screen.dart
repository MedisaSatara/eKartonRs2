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
    } else if (result == 'updated') {
      _showSnackbar('Korisnik uspješno ažuriran!');
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(child: _buildDataListView()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: _imeController,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Last name"),
              controller: _prezimeController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _fetchKorisnici();
            },
            child: Text("Search"),
          ),
        ],
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => KorisniciDetailsScreen(
                  korisnik: korisnik,
                ),
              ));
            },
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: ElevatedButton(
          onPressed: _navigateToAddUser,
          child: Text("Add new user"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 236, 233, 233),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
