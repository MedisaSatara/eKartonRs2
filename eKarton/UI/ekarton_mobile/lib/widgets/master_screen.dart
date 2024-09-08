import 'package:ekarton_mobile/screens/bolnica_screen.dart';
import 'package:ekarton_mobile/screens/ekarton_screen.dart';
import 'package:ekarton_mobile/screens/home_screen.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/online_pay_screen.dart';
import 'package:ekarton_mobile/screens/pacijent_list_screen.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/screens/test.dart';
import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? title_widget;

  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.black, // Promijenjena boja teksta na crnu
              ),
            ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => KorisnikProfileScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("<-"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text("eKarton"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EkartonScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Contact"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BolnicaScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Termin"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TerminScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Preporuceni doktori"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => RecommendedDoctorsScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Online payment"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnlinePayScreen()),
                );
              },
            ),
            // Dodajte druge opcije navigacije ovdje
          ],
        ),
      ),
      body: widget.child!,
      drawerEnableOpenDragGesture:
          true, // Omogućava otvaranje Drawer povlačenjem
    );
  }
}
