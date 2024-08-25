import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/nalaz.dart';

class NalazScreen extends StatelessWidget {
  final List<Nalaz> filteredNalazi;

  NalazScreen({required this.filteredNalazi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nalazi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildNalazList(),
      ),
    );
  }

  Widget _buildNalazList() {
    if (filteredNalazi.isEmpty) {
      return Center(child: Text("Nema nalaza za ovog pacijenta."));
    }

    return ListView.builder(
      itemCount: filteredNalazi.length,
      itemBuilder: (context, index) {
        final nalaz = filteredNalazi[index];
        return ListTile(
          title: Text("Nalaz ID: ${nalaz.nalazId}"),
          subtitle: Text("Opis: ${nalaz.datum ?? 'N/A'}"),
          // Add more details about the 'Nalaz' as needed
        );
      },
    );
  }
}
