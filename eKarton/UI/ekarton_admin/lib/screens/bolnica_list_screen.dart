import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/screens/bolnica_screen.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BolnicaListScreen extends StatefulWidget {
  const BolnicaListScreen({Key? key}) : super(key: key);

  @override
  State<BolnicaListScreen> createState() => _BolnicaListScreenState();
}

class _BolnicaListScreenState extends State<BolnicaListScreen> {
  late BolnicaProvider _bolnicaProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bolnicaProvider = context.read<BolnicaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Contact informations"),
      child: Container(
        child: Column(
          children: [
            Text("Test"),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () async {
                  print("login proceed");
                  var data = await _bolnicaProvider.get(filter: {});
                  print("Data:$data");

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BolnicaScreen()));
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
