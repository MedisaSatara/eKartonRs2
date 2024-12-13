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

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              _buildNavbar(),
              Expanded(
                child: Center(
                  child: _buildWelcomeCard(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavButton(context, "Welcome page", WelcomeScreen(), Icons.home),
          Spacer(),
          _buildNavButton(context, "Login", LoginPage(), Icons.person),
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
        height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
          color: const Color.fromARGB(255, 202, 202, 202).withOpacity(0.4),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to the eKarton Admin Welcome Page!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'This is the central hub for managing the eKarton system. From here, you can access various sections like users, patients, doctors, and departments.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'For every other information or action that you are going to do, you need to login with your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Make sure that your credentials are right, so you can enjoy through our app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'We made an effort to build the app. It is not the final version by design, but it is full of my inovations, and proud for now on it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Welcome! Let\'s login!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
