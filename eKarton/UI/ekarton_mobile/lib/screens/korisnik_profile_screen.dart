import 'package:ekarton_mobile/models/korisnik.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KorisnikProfileScreen extends StatefulWidget {
  const KorisnikProfileScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikProfileScreen> createState() => _KorisnikProfileScreen();
}

class _KorisnikProfileScreen extends State<KorisnikProfileScreen> {
  late KorisnikProvider _korisnikProvider;
  List<Korisnik>? korisnikResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _fetchKorisnici(); // Fetch data on initialization
  }

  Future<void> _fetchKorisnici() async {
    var data = await _korisnikProvider.get();
    setState(() {
      // Filter users where ulogaId = 1
      korisnikResult =
          data.result.where((korisnik) => korisnik.ulogaId == 2).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final korisnik = korisnikResult?.first;

    return MasterScreenWidget(
      title_widget: Text(
        "Hello, Admin! Welcome to your profile!",
        style: TextStyle(
          color: Colors.white, // Set the color of the title text
        ),
      ),
      child: korisnik != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.blueAccent,
                                child: Text(
                                  korisnik.ime?[0] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 16), // Space between avatar and text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${korisnik.ime ?? ''} ${korisnik.prezime ?? ''}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    korisnik.email ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 16),
                          _buildProfileDetail("Korisnicko ime",
                              korisnik.korisnickoIme ?? "", Icons.person),
                          _buildProfileDetail("Datum rodjenja",
                              korisnik.datumRodjenja ?? "", Icons.cake),
                          _buildProfileDetail(
                              "Telefon", korisnik.telefon ?? "", Icons.phone),
                          _buildProfileDetail(
                              "Spol", korisnik.spol ?? "", Icons.person),
                          _buildProfileDetail(
                              "Uloga", korisnik.ulogaId.toString(), Icons.work),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4), // Shadow below
            ),
          ],
        ),
        padding: EdgeInsets.all(12.0), // Inner padding
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 28),
            SizedBox(width: 16),
            Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
