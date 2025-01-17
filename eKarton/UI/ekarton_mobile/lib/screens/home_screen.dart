import 'package:ekarton_mobile/models/bolnica.dart';
import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/bolnica_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/pacijent_list_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late KorisnikProvider _korisnikProvider;
  List<Korisnik>? korisnikResult;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);
    _fetchKorisnici();
  }

  Future<void> _fetchKorisnici() async {
    try {
      var data = await _korisnikProvider.get();
      setState(() {
        korisnikResult = data.result.where((korisnik) {
          return korisnik.korisnikUlogas.any((uloga) => uloga.ulogaId == 2);
        }).toList();
      });
    } catch (e) {
      print('Error fetching korisnici: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Home Page',
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/welcomepage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHomePage(),
                SizedBox(height: 18),
                _buildWelcomeCard(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    final korisnik = korisnikResult?.first;
    print(korisnik);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome, ${korisnik?.ime}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PacijentListScreen(pacijent: null),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ),
              label: Text(
                "Find your health record",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color.fromARGB(255, 34, 78, 57),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final korisnik = korisnikResult?.first;
    print(korisnik);

    return Center(
      child: SizedBox(
        width: 400,
        height: 500,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Access your health records anytime, anywhere with our eKarton system.',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Stay informed about your medical history, lab results, and prescriptions all in one secure place.',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Simplify your healthcare journey with instant access to vital information and seamless communication with healthcare providers.',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your health, your control!',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(-0.3),
                      child: Image.asset('assets/images/ekarton1.jpg'),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(0.3),
                      child: Image.asset('assets/images/ekarton2.jpg'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
