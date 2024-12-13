import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/models/tehnicka_podrska.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/tehnicka_podrska_provider.dart';
import 'package:ekarton_admin/screens/korisnik_profile_screen.dart';
import 'package:ekarton_admin/screens/doktor_list_scren.dart';
import 'package:ekarton_admin/screens/korisnik_screen.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/pacijent_list_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BolnicaProvider _bolnicaProvider;
  late KorisnikProvider _korisnikProvider;
  late TehnickaPodrskaProvider _tehnickaPodrskaProvider;

  Bolnica? _bolnicaDetails;
  int? _brojKorisnika;
  SearchResult<Korisnik>? _korisnici;
  SearchResult<TehnickaPodrska>? _tehnickaPodrskaData;
  int? _brojPoziva;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bolnicaProvider = context.read<BolnicaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _tehnickaPodrskaProvider = context.read<TehnickaPodrskaProvider>();

    _fetchBolnicaDetails();
    _fetchKorisnici();
    _fetchTehnickaPodrska();
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisniciData = await _korisnikProvider.get();
      setState(() {
        _korisnici = korisniciData;
        _brojKorisnika = korisniciData.count;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> _fetchBolnicaDetails() async {
    var data = await _bolnicaProvider.get();
    setState(() {
      _bolnicaDetails = data.result?.first;
    });
  }

  Future<void> _fetchTehnickaPodrska() async {
    try {
      var tehnickaPodrskaData = await _tehnickaPodrskaProvider.get();
      setState(() {
        _tehnickaPodrskaData = tehnickaPodrskaData;
        _brojPoziva = tehnickaPodrskaData.count;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: MasterScreenWidget(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/welcomepage.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                        _buildBrojKorisnikaCard(),
                        SizedBox(height: 16),
                        _buildTehnickaPodrskaCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          _buildNavButton(context, "", HomeScreen(), Icons.home),
          SizedBox(width: 200.0),
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
          _buildNavButton(context, "", KorisnikProfileScreen(), Icons.person),
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
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the eKarton Admin Home Page!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This is the central hub for managing the eKarton system. From here, you can access various sections like users, patients, doctors, and departments.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Registered Users: $_brojKorisnika',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalInfoCard() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hospital Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _buildHospitalDetailRow(
                    'Name:', _bolnicaDetails!.naziv ?? 'N/A'),
                SizedBox(height: 8),
                _buildHospitalDetailRow(
                    'Address:', _bolnicaDetails!.adresa ?? 'N/A'),
                SizedBox(height: 8),
                _buildHospitalDetailRow(
                    'Phone:', _bolnicaDetails!.telefon ?? 'N/A'),
                SizedBox(height: 8),
                _buildHospitalDetailRow(
                    'Email:', _bolnicaDetails!.email ?? 'N/A'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrojKorisnikaCard() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Number of users app:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '$_brojKorisnika',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTehnickaPodrskaCard() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Requests and calls to technical support:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                if (_tehnickaPodrskaData != null)
                  Column(
                    children: _tehnickaPodrskaData!.result.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Number of requests processed: ${e.brojPozivaDoSada ?? 'N/A'}'),
                          SizedBox(height: 8),
                          Text(
                              'Most common problems: ${e.najcesciProblemi ?? 'N/A'}'),
                        ],
                      );
                    }).toList(),
                  )
                else
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
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
