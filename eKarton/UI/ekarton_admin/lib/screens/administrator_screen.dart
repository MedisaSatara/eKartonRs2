import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/administrator.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/administrator_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdministratorScreen extends StatefulWidget {
  const AdministratorScreen({Key? key}) : super(key: key);

  @override
  State<AdministratorScreen> createState() => _AdministratorScreenState();
}

class _AdministratorScreenState extends State<AdministratorScreen> {
  late AdministratorProvider _administratorProvider;
  SearchResult<Administrator>? administratorResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _administratorProvider = context.read<AdministratorProvider>();
    _fetchKorisnici(); // Fetch data on initialization
  }

  Future<void> _fetchKorisnici() async {
    var data = await _administratorProvider.get();
    setState(() {
      administratorResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final administrator = administratorResult?.result.first;

    return MasterScreenWidget(
      title_widget: Text(
        "Hello, Admin! Welcome to your profile!",
        style: TextStyle(
          color: Colors.white, // Set the color of the title text
        ),
      ),
      child: administrator != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                administrator.ime?[0] ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                ),
                              ),
                            ),
                            SizedBox(width: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${administrator.ime ?? ''} ${administrator.prezime ?? ''}",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  administrator.email ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  administrator.telefon ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Divider(),
                        SizedBox(height: 16),
                        _buildProfileDetail("Date of Birth",
                            administrator.datumRodjenja ?? "", Icons.cake),
                        _buildProfileDetail("Address",
                            administrator.prebivaliste ?? "", Icons.home),
                        _buildProfileDetail(
                            "Phone", administrator.telefon ?? "", Icons.phone),
                        _buildProfileDetail(
                            "Email", administrator.email ?? "", Icons.email),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Pozadinska boja
          borderRadius: BorderRadius.circular(10.0), // Zaobljeni uglovi
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4), // Senka ispod
            ),
          ],
        ),
        padding: EdgeInsets.all(12.0), // Unutrašnji padding
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 28),
            SizedBox(width: 16),
            Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
