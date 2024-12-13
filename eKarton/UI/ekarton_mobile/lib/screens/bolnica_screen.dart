import 'package:ekarton_mobile/main.dart';
import 'package:ekarton_mobile/models/bolnica.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/bolnica_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BolnicaScreen extends StatefulWidget {
  const BolnicaScreen({Key? key}) : super(key: key);

  @override
  State<BolnicaScreen> createState() => _BolnicaScreenState();
}

class _BolnicaScreenState extends State<BolnicaScreen> {
  late BolnicaProvider _bolnicaProvider;
  SearchResult<Bolnica>? result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bolnicaProvider = context.read<BolnicaProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _bolnicaProvider.get();
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Contact"),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ekarton3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (result == null)
                const CircularProgressIndicator()
              else if (result!.result.isEmpty)
                const Text("Nema dostupnih podataka.")
              else
                Expanded(
                  child: _buildCardListView(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardListView() {
    return ListView.builder(
      itemCount: result!.result.length,
      itemBuilder: (context, index) {
        Bolnica bolnica = result!.result[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bolnica.naziv ?? "Nepoznato",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(bolnica.adresa ?? "Nepoznato"),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey),
                    const SizedBox(width: 8.0),
                    Text(bolnica.telefon ?? "Nepoznato"),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.grey),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(bolnica.email ?? "Nepoznato"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
