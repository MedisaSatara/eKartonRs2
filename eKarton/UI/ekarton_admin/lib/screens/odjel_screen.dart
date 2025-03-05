import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'odjel_details_screen.dart';

class OdjelScreen extends StatefulWidget {
  const OdjelScreen({Key? key}) : super(key: key);

  @override
  State<OdjelScreen> createState() => _OdjelScreenState();
}

class _OdjelScreenState extends State<OdjelScreen> {
  late OdjelProvider _odjelProvider;
  SearchResult<Odjel>? odjelResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _odjelProvider = context.read<OdjelProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _odjelProvider.get();
    setState(() {
      odjelResult = data;
    });
  }

  void _navigateToAddOdjel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OdjelDetailsScreen(
          odjel: null,
          onDataChanged: _fetchInitialData,
        ),
      ),
    );
  }

  void _navigateToOdjelDetails(Odjel odjel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OdjelDetailsScreen(
          odjel: odjel,
          onDataChanged: _fetchInitialData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Departments"),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: odjelResult?.result.length ?? 0,
                    itemBuilder: (context, index) {
                      final odjel = odjelResult!.result[index];
                      return GestureDetector(
                        onTap: () => _navigateToOdjelDetails(odjel),
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      odjel.naziv ?? "N/A",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Phone: ${odjel.telefon ?? 'N/A'}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Delete Department'),
                                          content: Text(
                                              'Are you sure you want to delete this department?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await _odjelProvider
                                                    .delete(odjel.odjelId!);
                                                Navigator.of(context).pop();
                                                _fetchInitialData();
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _navigateToAddOdjel,
                  child: Text("Add New Odjel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
