import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                Text(
                  "Departments",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: odjelResult?.result.length ?? 0,
                    itemBuilder: (context, index) {
                      final odjel = odjelResult!.result[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
