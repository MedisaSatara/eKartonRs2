import 'package:ekarton_mobile/screens/bolnica_screen.dart';
import 'package:ekarton_mobile/screens/home_screen.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/ocjena_doktor_screen.dart';
import 'package:ekarton_mobile/screens/odjel_screen.dart';
import 'package:ekarton_mobile/screens/online_pay_screen.dart';
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
              style: TextStyle(color: Colors.black),
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
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerItem(context, "Home", HomeScreen()),
            _buildDrawerItem(context, "Departments", OdjelScreen()),
            _buildDrawerItem(context, "Examination", TerminScreen()),
            _buildDrawerItem(
                context, "Recommended doctors", RecommendedDoctorsScreen()),
            _buildDrawerItem(context, "Doctor's ratings", OcjenaDoktorScreen()),
            _buildDrawerItem(context, "Contact", BolnicaScreen()),
            _buildDrawerItem(context, "Online payment", OnlinePayScreen()),
          ],
        ),
      ),
      body: widget.child!,
      drawerEnableOpenDragGesture: true,
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, Widget screen) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
