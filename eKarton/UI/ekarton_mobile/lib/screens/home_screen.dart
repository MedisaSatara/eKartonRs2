import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/pacijent_list_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Home Page', // Set the title for the AppBar
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/ekarton1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            // Use Center here to vertically and horizontally align the content
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Stretch to the width of the parent
              children: [
                _buildWelcomeCard(), // The welcome card is now centered
                SizedBox(height: 16),
                // Add more content here if needed
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
        width: 400, // Specify the width
        height: 300, // Specify the height
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
                  'eKarton!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Everything you want to know from your Health record, You can find here!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Let\'s start the journey!',
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PacijentListScreen(pacijent: null),
                      ),
                    );
                  },
                  child: Text("Pretraga"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
