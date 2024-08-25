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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _fetchKorisnici(); 
  }

  Future<void> _fetchKorisnici() async {
    var data = await _korisnikProvider.get(filter: {
      'ime': _imeController.text,
      'prezime': _prezimeController.text,
      'korisnickoIme': _korisnickoImeController.text,
    });
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Lista korisnika"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              decoration: InputDecoration(labelText: "Ime"),
              controller: _imeController,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Prezime korisnika"),
              controller: _prezimeController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _fetchKorisnici();
            },
            child: Text("Pretraga"),
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
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => KorisniciDetailsScreen()),
            );
          },
          child: Text("Dodaj novi korisnik"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 236, 233, 233), 
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
