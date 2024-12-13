import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/screens/home_screen.dart';
import 'package:ekarton_admin/screens/korisnik_profile_screen.dart';
import 'package:ekarton_admin/screens/bolnica_screen.dart';
import 'package:ekarton_admin/screens/doktor_list_scren.dart';
import 'package:ekarton_admin/screens/korisnik_screen.dart';
import 'package:ekarton_admin/screens/odjel_screen.dart';
import 'package:ekarton_admin/screens/osiguranje_screen.dart';
import 'package:ekarton_admin/screens/pacijent_details_screen.dart';
import 'package:ekarton_admin/screens/pacijent_list_screen.dart';
import 'package:ekarton_admin/screens/pacijent_osiguranje_screen.dart';
import 'package:ekarton_admin/screens/report_screen.dart';
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
                color: Colors.white,
              ),
            ),
      ),
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
        _buildNavButton(context, "", HomeScreen(), Icons.home),
        SizedBox(width: 30.0),
        _buildNavButton(context, "Users", KorisnikScreen(), Icons.person),
        SizedBox(width: 10.0),
        _buildNavButton(context, "Patients", PacijentiScreen(), Icons.people),
        SizedBox(width: 10.0),
        _buildNavButton(
            context, "Doctors", DoktorScreen(), Icons.local_hospital),
        SizedBox(width: 10.0),
        _buildNavButton(context, "Department", OdjelScreen(), Icons.business),
        SizedBox(width: 10.0),
        /* _buildNavButton(
            context, "Termini", PacijentiDetailsScreen(), Icons.schedule),*/
        _buildNavButton(
            context, "Insurance", OsiguranjeScreen(), Icons.security),
        SizedBox(width: 10.0),
        _buildNavButton(context, "Patient insurance",
            PacijentOsiguranjeScreen(), Icons.person),
        SizedBox(width: 10.0),
        _buildNavButton(context, "Reports", ReportScreen(), Icons.person),
        SizedBox(width: 20.0),
        _buildNavButton(context, "", KorisnikProfileScreen(), Icons.person),
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
