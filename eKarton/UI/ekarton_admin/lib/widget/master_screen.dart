import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/screens/administrator_screen.dart';
import 'package:ekarton_admin/screens/bolnica_screen.dart';
import 'package:ekarton_admin/screens/doktor_list_scren.dart';
import 'package:ekarton_admin/screens/korisnik_screen.dart';
import 'package:ekarton_admin/screens/odjel_screen.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/pacijent_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
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
        backgroundColor: Colors.blueGrey[800],
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white, // Set the color of the title text
              ),
            ),
      ),
      /*drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("<-"),
              onTap: () {
                /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Login()),
                );*/
              },
            ),
            ListTile(
              title: Text("Administrator"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AdministratorScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Korisnik"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => KorisnikScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Pacijenti"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const PacijentiScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Doktori"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DoktorScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Odjel"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OdjelScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Termini"),
              onTap: () {
                /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TerminiScreen()),
                );*/
              },
            ),
            ListTile(
              title: Text("Bolnica"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BolnicaScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: widget.child!,*/
      body: Column(
        children: [
          _buildNavbar(context),
          Expanded(child: widget.child!),
        ],
      ),
    );
  }
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
        _buildNavButton(context, "Pacijenti", PacijentiScreen(), Icons.people),
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
