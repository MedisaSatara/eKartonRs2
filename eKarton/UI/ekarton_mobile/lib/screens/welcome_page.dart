import 'package:ekarton_mobile/main.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/pacijent_list_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/ekarton3.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeCard(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Center(
      child: SizedBox(
        width: 400,
        height: 350,
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
                  'Welcome to eKarton Mobile app!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'If you are using eKarton, lets login to check details about your health.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Let\'s start the journey!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
