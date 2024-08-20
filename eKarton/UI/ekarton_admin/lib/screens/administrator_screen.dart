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
  State<AdministratorScreen> createState() => _AdministratorScreen();
}

class _AdministratorScreen extends State<AdministratorScreen> {
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
    return MasterScreenWidget(
      title_widget: Text("Profil administratora"),
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDataListView(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Prezime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Datum rodjenja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Prebivaliste',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Telefon',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Email',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: administratorResult?.result
                  .map((Administrator e) => DataRow(
                        cells: [
                          DataCell(Text(e.ime ?? "")),
                          DataCell(Text(e.prezime ?? "")),
                          DataCell(Text(e.datumRodjenja ?? "")),
                          DataCell(Text(e.prebivaliste ?? "")),
                          DataCell(Text(e.telefon ?? "")),
                          DataCell(Text(e.email ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
