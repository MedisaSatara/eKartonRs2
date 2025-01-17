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
                "assets/images/welcome.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCardsSection(),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWelcomeCard(),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildBrojKorisnikaCard(),
                  SizedBox(height: 16),
                  _buildTotalRegistratedUserCard(),
                ],
              ),
            ),
            SizedBox(width: 56),
            Expanded(
              flex: 1,
              child: _buildTehnickaPodrskaCard(),
            ),
          ],
        ),
      ],
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
                  'You have full control over all aspects of the eKarton platform. With just a few clicks, you can easily navigate to different sections, update information, and ensure the system is functioning smoothly.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Feel free to explore and make the most of the features available in the admin panel. Everything you need is right here at your fingertips.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRegistratedUserCard() {
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
                  'Total Users registrated on the App:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '$_brojKorisnika',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
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
                  'Number of App Users:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '$_brojKorisnika',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                SizedBox(height: 16),
                if (_tehnickaPodrskaData != null)
                  Column(
                    children: _tehnickaPodrskaData!.result.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Most common problems: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('${e.najcesciProblemi ?? 'N/A'}'),
                            SizedBox(height: 8),
                            Text('Number of requests processed:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('${e.brojPozivaDoSada ?? 'N/A'}'),
                          ],
                        ),
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
}
