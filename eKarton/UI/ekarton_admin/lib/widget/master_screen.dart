import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

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
  late BolnicaProvider _bolnicaProvider;
  Bolnica? _bolnica;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bolnicaProvider = context.read<BolnicaProvider>();
    _fetchBolnicaDetails();
  }

  Future<void> _fetchBolnicaDetails() async {
    var data = await _bolnicaProvider.get();
    setState(() {
      _bolnica = data.result?.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 125, 137),
        automaticallyImplyLeading: false,
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        actions: [
          _buildNavBarItems(context),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: widget.child!),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.local_hospital,
                  color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "eKarton Hospital ${_bolnica?.naziv}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.phone, color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_bolnica?.telefon}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.email, color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_bolnica?.email}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.location_on,
                  color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_bolnica?.adresa}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavText(context, "Home", HomeScreen()),
        _buildNavText(context, "Users", KorisnikScreen()),
        _buildNavText(context, "Patients", PacijentiScreen()),
        _buildNavText(context, "Doctors", DoktorScreen()),
        _buildNavText(context, "Department", OdjelScreen()),
        // _buildNavText(context, "Insurance", OsiguranjeScreen()),
        _buildNavText(context, "Patient Insurance", PacijentOsiguranjeScreen()),
        _buildNavText(context, "Reports", ReportScreen()),
        _buildNavText(context, "Profile", KorisnikProfileScreen()),
      ],
    );
  }

  Widget _buildNavText(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        onHover: (isHovered) {
          setState(() {});
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {});
          },
          onExit: (_) {
            setState(() {});
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
