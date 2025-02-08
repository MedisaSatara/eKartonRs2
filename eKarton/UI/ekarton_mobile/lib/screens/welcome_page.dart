import 'package:ekarton_mobile/main.dart';
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
        title: Text('eKarton'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCircularImage(),
            SizedBox(height: 16),
            _buildWelcomeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularImage() {
    return Center(
      child: CircleAvatar(
        radius: 150,
        backgroundColor: Colors.grey[200],
        backgroundImage: AssetImage("assets/images/welcomepage.jpg"),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to eKarton Mobile app!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Let\'s start the journey!',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 70),
          Text(
            'Connect with username and password',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 350,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
