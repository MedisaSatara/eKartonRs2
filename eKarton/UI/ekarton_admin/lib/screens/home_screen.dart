import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/screens/administrator_screen.dart';
import 'package:ekarton_admin/screens/doktor_list_scren.dart';
import 'package:ekarton_admin/screens/korisnik_screen.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/pacijent_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BolnicaProvider _bolnicaProvider;
  Bolnica? _bolnicaDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bolnicaProvider = context.read<BolnicaProvider>();
    _fetchBolnicaDetails();
  }

  Future<void> _fetchBolnicaDetails() async {
    var data = await _bolnicaProvider.get();
    setState(() {
      _bolnicaDetails = data.result?.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eKarton Admin Dashboard'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/ekarton1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Sloj za druge widgete koji će se nalaziti preko slike
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNavbar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildWelcomeCard(),
                      SizedBox(height: 16),
                      _bolnicaDetails != null
                          ? _buildHospitalInfoCard()
                          : Center(child: CircularProgressIndicator()),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 250.0),
          _buildNavButton(context, "Korisnik", KorisnikScreen(), Icons.person),
          SizedBox(width: 50.0),
          _buildNavButton(
              context, "Pacijenti", PacijentiScreen(), Icons.people),
          SizedBox(width: 50.0),
          _buildNavButton(
              context, "Doktori", DoktorScreen(), Icons.local_hospital),
          SizedBox(width: 50.0),
          _buildNavButton(
              context, "Odjel", PacijentiDetailsScreen(), Icons.business),
          SizedBox(width: 50.0),
          _buildNavButton(
              context, "Termini", PacijentiDetailsScreen(), Icons.schedule),
          Spacer(),
          _buildNavButton(context, "", AdministratorScreen(), Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, String title, Widget screen, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the eKarton Admin Home Page!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This is the central hub for managing the eKarton system. From here, you can access various sections like users, patients, doctors, and departments.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Text(
              'We aim to provide a seamless experience for managing medical records and ensuring the best care for patients.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalInfoCard() {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hospital Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildHospitalDetailRow('Name:', _bolnicaDetails!.naziv ?? 'N/A'),
            SizedBox(height: 8),
            _buildHospitalDetailRow(
                'Address:', _bolnicaDetails!.adresa ?? 'N/A'),
            SizedBox(height: 8),
            _buildHospitalDetailRow(
                'Phone:', _bolnicaDetails!.telefon ?? 'N/A'),
            SizedBox(height: 8),
            _buildHospitalDetailRow('Email:', _bolnicaDetails!.email ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalDetailRow(String label, String detail) {
    return Row(
      children: [
        Icon(Icons.info_outline, color: Colors.blueAccent, size: 24),
        SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
