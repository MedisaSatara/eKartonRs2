import 'package:ekarton_admin/models/osiguranje.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/pacijent_osiguranje.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class PacijentOsiguranjeScreen extends StatefulWidget {
  const PacijentOsiguranjeScreen({Key? key}) : super(key: key);

  @override
  State<PacijentOsiguranjeScreen> createState() =>
      _PacijentOsiguranjeScreenState();
}

class _PacijentOsiguranjeScreenState extends State<PacijentOsiguranjeScreen> {
  late PacijentOsiguranjeProvider _pacijentOsiguranjeProvider;
  late PacijentProvider _pacijentProvider;
  late OsiguranjeProvider _osiguranjeProvider;

  SearchResult<PacijentOsiguranje>? result;
  SearchResult<Pacijent>? pacijentResult;
  SearchResult<Osiguranje>? osiguranjeResult;

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _brojkartonaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentOsiguranjeProvider = context.read<PacijentOsiguranjeProvider>();
    _pacijentProvider = context.read<PacijentProvider>();
    _osiguranjeProvider = context.read<OsiguranjeProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentOsiguranjeProvider.get();
    var pacijentData = await _pacijentProvider.get();
    var osiguranjeData = await _osiguranjeProvider.get();

    setState(() {
      result = data;
      pacijentResult = pacijentData;
      osiguranjeResult = osiguranjeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text(
        "Patients Insurance",
        style: TextStyle(color: Colors.white),
      ),
      child: Stack(
        children: [
          _buildBackground(),
          Column(
            children: [
              _buildSearch(),
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 63, 125, 137),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search patients:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSearchField("First name", _imeController),
            const SizedBox(height: 8.0),
            _buildSearchField("Last name", _prezimeController),
            const SizedBox(height: 8.0),
            _buildSearchField("Carton number", _brojkartonaController),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                var data = await _pacijentOsiguranjeProvider.get(filter: {
                  'imePacijenta': _imeController.text.trim().toLowerCase(),
                  'prezimePacijenta':
                      _prezimeController.text.trim().toLowerCase(),
                  'brojKartona':
                      _brojkartonaController.text.trim().toLowerCase(),
                });
                setState(() {
                  result = data;
                });
              },
              child: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
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
        var pacijent = pacijentResult?.result.firstWhereOrNull(
          (p) => p.pacijentId == item.pacijentId,
        );
        var osiguranje = osiguranjeResult?.result.firstWhereOrNull(
          (o) => o.osiguranjeId == item.osiguranjeId,
        );

        return _buildCard(item, pacijent, osiguranje);
      },
    );
  }

  Widget _buildCard(
    PacijentOsiguranje item,
    Pacijent? pacijent,
    Osiguranje? osiguranje,
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
              "Patient: ${pacijent?.ime ?? 'N/A'} ${pacijent?.prezime ?? ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text("Insurance: ${osiguranje?.osiguranik ?? 'N/A'}"),
            const SizedBox(height: 8.0),
            Text("Date: ${item.datumOsiguranja ?? 'N/A'}"),
            const SizedBox(height: 8.0),
            Text("Valid: ${item.vazece! ? 'Yes' : 'No'}"),
          ],
        ),
      ),
    );
  }
}
