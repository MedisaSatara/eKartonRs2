import 'package:ekarton_mobile/main.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PreventivneMjereScreen extends StatefulWidget {
  @override
  State<PreventivneMjereScreen> createState() => _PreventivneMjereScreen();
}

class _PreventivneMjereScreen extends State<PreventivneMjereScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Stanje',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: [],
        ),
      ),
    );
  }
}
