import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/screens/administrator_screen.dart';
import 'package:ekarton_admin/screens/bolnica_screen.dart';
import 'package:ekarton_admin/screens/doktor_list_scren.dart';
import 'package:ekarton_admin/screens/odjel_screen.dart';
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
        title: widget.title_widget ?? Text(widget.title ?? ""),
      ),
      drawer: Drawer(
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
                /*  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => KorisnikScreen()),
                );*/
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
      body: widget.child!,
    );
  }
}
