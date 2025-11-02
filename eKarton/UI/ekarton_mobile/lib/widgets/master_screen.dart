import 'package:ekarton_mobile/models/odjel.dart';
import 'package:ekarton_mobile/screens/bolnica_screen.dart';
import 'package:ekarton_mobile/screens/frmTransakcije25062025.dart';
import 'package:ekarton_mobile/screens/home_screen.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/ocjena_doktor_screen.dart';
import 'package:ekarton_mobile/screens/odjel_screen.dart';
import 'package:ekarton_mobile/screens/online_pay_screen.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/screens/test.dart';
import 'package:ekarton_mobile/screens/test2.dart';
import 'package:flutter/material.dart';

/*class MasterScreenWidget extends StatefulWidget {
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
*/
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
  int _selectedIndex = 0;

  final List<Widget> _mainScreens = [
    HomeScreen(),
    OdjelScreen(),
    TerminScreen(),
    OcjenaDoktorScreen(),
  ];

  final Map<String, Widget> _moreOptions = {
    'Recommended doctors': RecommendedDoctorsScreen(),
    'Contact': BolnicaScreen(),
    //'Online paymant': PaymentDetailsScreen(paymentIntentId: "",),
    'Kategorije': Frmtransakcije25062025(),



  };

  void _onMainItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => _mainScreens[index]),
      );
    });
  }

  void _onMoreOptionSelected(String key) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => _moreOptions[key]!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 34, 78, 57),
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KorisnikProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: widget.child ?? _mainScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onMainItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Departments',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Appointment',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grade_sharp),
            label: 'Grades',
          ),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onMoreOptionSelected,
              itemBuilder: (BuildContext context) {
                return _moreOptions.keys
                    .map(
                      (String key) => PopupMenuItem<String>(
                        value: key,
                        child: Text(key),
                      ),
                    )
                    .toList();
              },
            ),
            label: 'More',
          ),
        ],
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
      ),
    );
  }
}
