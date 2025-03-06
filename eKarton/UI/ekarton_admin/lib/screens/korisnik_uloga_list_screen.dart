import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/korisnik_uloga.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/models/uloga.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/korisnik_uloga_provider.dart';
import 'package:ekarton_admin/providers/uloga_provider.dart';
import 'package:ekarton_admin/screens/korisnik_uloga_edit_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class KorisnikUlogaListScreen extends StatefulWidget {
  const KorisnikUlogaListScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikUlogaListScreen> createState() =>
      _KorisnikUlogaListScreenState();
}

class _KorisnikUlogaListScreenState extends State<KorisnikUlogaListScreen> {
  late KorisnikUlogaProvider _korisnikUlogaProvider;
  late KorisnikProvider _korisnikProvider;
  late UlogaProvider _ulogaProvider;

  SearchResult<KorisnikUloga>? result;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Uloga>? ulogaResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikUlogaProvider = context.read<KorisnikUlogaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _ulogaProvider = context.read<UlogaProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _korisnikUlogaProvider.get();
    var korisnikData = await _korisnikProvider.get();
    var ulogaData = await _ulogaProvider.get();

    setState(() {
      result = data;
      korisnikResult = korisnikData;
      ulogaResult = ulogaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text(
        "User roles",
        style: TextStyle(color: Colors.white),
      ),
      child: Stack(
        children: [
          _buildBackground(),
          Column(
            children: [
              Expanded(child: _buildDataCards()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSearchField(String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      controller: controller,
    );
  }

  Widget _buildDataCards() {
    if (result == null || result!.result.isEmpty) {
      return const Center(
        child: Text(
          "No data available.",
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: result!.result.length,
      itemBuilder: (context, index) {
        var item = result!.result[index];
        var korisnik = korisnikResult?.result.firstWhereOrNull(
          (p) => p.korisnikId == item.korisnikId,
        );
        var uloga = ulogaResult?.result.firstWhereOrNull(
          (o) => o.ulogaId == item.ulogaId,
        );

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => KorisnikUlogaEditScreen(
                  korisnikUloga: item,
                  onDataChanged: _fetchInitialData,
                ),
              ),
            );
          },
          child: _buildCard(item, korisnik, uloga),
        );
      },
    );
  }

  Widget _buildCard(
    KorisnikUloga item,
    Korisnik? korisnik,
    Uloga? uloga,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User: ${korisnik?.ime ?? 'N/A'} ${korisnik?.prezime ?? ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text("Role: ${uloga?.naziv ?? 'N/A'}"),
            const SizedBox(height: 8.0),
            Text("Last Modified: ${item.datumIzmjene ?? 'N/A'}"),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
