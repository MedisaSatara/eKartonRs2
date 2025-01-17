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
            image: AssetImage('assets/images/welcomepage.jpg'),
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
                  child: _buildCardView(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardView() {
    Bolnica bolnica = result!.result.first;
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Image.asset('assets/images/bolnica.jpg',
                height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 36.0),

            _buildInfoRow(Icons.location_on, bolnica.adresa ?? "Nepoznato"),
            const SizedBox(height: 12.0),
            const Divider(
                color: const Color.fromARGB(255, 34, 78, 57), thickness: 1.0),
            const SizedBox(height: 12.0),

            _buildInfoRow(Icons.phone, bolnica.telefon ?? "Nepoznato"),
            const SizedBox(height: 12.0),
            const Divider(
                color: const Color.fromARGB(255, 34, 78, 57), thickness: 1.0),
            const SizedBox(height: 12.0),
            _buildInfoRow(Icons.email, bolnica.email ?? "Nepoznato"),
            const SizedBox(height: 12.0),
            const Divider(
                color: const Color.fromARGB(255, 34, 78, 57), thickness: 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color.fromARGB(255, 34, 78, 57)),
        const SizedBox(width: 26.0),
        Expanded(child: Text(text)),
      ],
    );
  }
}
