import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ekarton_mobile/models/pregled.dart';
import 'package:ekarton_mobile/models/preventivne_mjere.dart';
import 'package:ekarton_mobile/models/terapija.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pregled_provider.dart';
import 'package:ekarton_mobile/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_mobile/providers/terapija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekarton_mobile/models/nalaz.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/providers/nalaz_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'preventivne_mjere_screen.dart';
import 'pregled_screen.dart';

class EkartonScreen extends StatefulWidget {
  final Pacijent? pacijent;

  EkartonScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<EkartonScreen> createState() => _EkartonScreen();
}

class _EkartonScreen extends State<EkartonScreen> {
  bool showOboljenjeScreen = false;
  bool showNalazScreen = false;
  bool showPeriodicniPregledScreen = false;
  bool showPreventivneMjereScreen = false;
  bool showPregledScreen = false;
  bool showLicniPodaci = false;

  late NalazProvider _nalazProvider;
  late PreventivneMjereProvider _preventivneMjereProvider;
  late PregledProvider _pregledProvider;
  late DoktorProvider _doktorProvider;
  late TerapijaProvider _terapijaProvider;
  List<Nalaz>? filteredNalazi;
  List<PreventivneMjere>? filteredMjere;
  List<Pregled>? filteredPregled;
  List<Terapija>? fliteredTerapija;
  Map<int?, String?> _doktorMap = {};
  Map<int?, String?> _terapijaMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nalazProvider = context.read<NalazProvider>();
    _preventivneMjereProvider = context.read<PreventivneMjereProvider>();
    _pregledProvider = context.read<PregledProvider>();
    _doktorProvider = context.read<DoktorProvider>();
    _terapijaProvider = context.read<TerapijaProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _nalazProvider.get();
    var mjereData = await _preventivneMjereProvider.get();
    var pregledData = await _pregledProvider.get();
    var doktorData = await _doktorProvider.get();
    var terapijaData = await _terapijaProvider.get();

    setState(() {
      filteredNalazi = data.result
          ?.where((nalaz) => nalaz.pacijentId == widget.pacijent?.pacijentId)
          .toList();

      filteredMjere = mjereData.result
          ?.where((mjere) => mjere.pacijentId == widget.pacijent?.pacijentId)
          .toList();

      filteredPregled = pregledData.result
          ?.where(
              (pregled) => pregled.pacijentId == widget.pacijent?.pacijentId)
          .toList();

      _doktorMap = {for (var d in doktorData.result!) d.doktorId: d.ime};
      _terapijaMap = {
        for (var t in terapijaData.result!) t.terapijaId: t.nazivLijeka
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'eKarton',
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/ekarton1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.pacijent != null
                        ? "Ime i prezime pacijenta: ${widget.pacijent!.ime} ${widget.pacijent!.prezime}"
                        : "eKarton",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildButton("LICNI PODACI", Icons.person, () {
                        setState(() {
                          showLicniPodaci = true;
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                        });
                      }),
                      _buildButton("OBOLJENJA", Icons.history, () {
                        setState(() {
                          showOboljenjeScreen = true;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("NALAZI", Icons.history, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = true;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("PERIODICNI PREGLED", Icons.healing, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = true;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("PREVENTIVNE MJERE", Icons.healing, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = true;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("DATUM PREGLEDA", Icons.healing, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = true;
                          showLicniPodaci = false;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 24),
                  Visibility(
                    visible: showOboljenjeScreen,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      //child: _buildNalazTable(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Visibility(
                    visible: showNalazScreen,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: _buildNalazTable(),
                    ),
                  ),
                  Visibility(
                    visible: showPeriodicniPregledScreen,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      // child: _buildMjereTable(),
                    ),
                  ),
                  Visibility(
                    visible: showPreventivneMjereScreen,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: _buildMjereTable(),
                    ),
                  ),
                  Visibility(
                    visible: showPregledScreen,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: _buildPregledTable(),
                    ),
                  ),
                  Visibility(
                    visible: showLicniPodaci,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: _buildLicniPodaciTable(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNalazTable() {
    if (filteredNalazi == null || filteredNalazi!.isEmpty) {
      return Center(child: Text("Nema nalaza za ovog pacijenta."));
    }
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Container(
      child: Card(
        child: AdaptiveScrollbar(
          underColor: Colors.blueGrey.withOpacity(0.3),
          sliderDefaultColor: Colors.grey.withOpacity(0.7),
          sliderActiveColor: Colors.grey,
          controller: _verticalScrollController,
          child: AdaptiveScrollbar(
            controller: _horizontalScrollController,
            position: ScrollbarPosition.bottom,
            underColor: Colors.blueGrey.withOpacity(0.3),
            sliderDefaultColor: Colors.grey.withOpacity(0.7),
            sliderActiveColor: Colors.grey,
            child: SingleChildScrollView(
                controller: _verticalScrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nalaz ID')),
                        DataColumn(label: Text('Datum')),
                      ],
                      rows: filteredNalazi!.map((nalaz) {
                        return DataRow(
                          cells: [
                            DataCell(Text(nalaz.nalazId.toString())),
                            DataCell(Text(nalaz.datum ?? 'N/A')),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildMjereTable() {
    if (filteredMjere == null || filteredMjere!.isEmpty) {
      return Center(child: Text("Nema preventivnih mjera za ovog pacijenta."));
    }

    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    return Container(
      child: Card(
        child: AdaptiveScrollbar(
          underColor: Colors.blueGrey.withOpacity(0.3),
          sliderDefaultColor: Colors.grey.withOpacity(0.7),
          sliderActiveColor: Colors.grey,
          controller: _verticalScrollController,
          child: AdaptiveScrollbar(
            controller: _horizontalScrollController,
            position: ScrollbarPosition.bottom,
            underColor: Colors.blueGrey.withOpacity(0.3),
            sliderDefaultColor: Colors.grey.withOpacity(0.7),
            sliderActiveColor: Colors.grey,
            child: SingleChildScrollView(
              controller: _verticalScrollController,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Stanje')),
                    ],
                    rows: filteredMjere!.map((mjere) {
                      return DataRow(
                        cells: [
                          DataCell(Text(mjere.stanje.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPregledTable() {
    if (filteredPregled == null || filteredPregled!.isEmpty) {
      return Center(child: Text("Nema pregleda za ovog pacijenta."));
    }
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    return Container(
      child: Card(
        child: AdaptiveScrollbar(
          underColor: Colors.blueGrey.withOpacity(0.3),
          sliderDefaultColor: Colors.grey.withOpacity(0.7),
          sliderActiveColor: Colors.grey,
          controller: _verticalScrollController,
          child: AdaptiveScrollbar(
            controller: _horizontalScrollController,
            position: ScrollbarPosition.bottom,
            underColor: Colors.blueGrey.withOpacity(0.3),
            sliderDefaultColor: Colors.grey.withOpacity(0.7),
            sliderActiveColor: Colors.grey,
            child: SingleChildScrollView(
              controller: _verticalScrollController,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Datum')),
                      DataColumn(label: Text('Razlog posjete')),
                      DataColumn(label: Text('Dijagnoza')),
                      DataColumn(label: Text('Terapija')),
                      DataColumn(label: Text('Ime doktora')),
                    ],
                    rows: filteredPregled!.map((pregled) {
                      return DataRow(
                        cells: [
                          DataCell(Text(pregled.datum.toString())),
                          DataCell(Text(pregled.razlogPosjete.toString())),
                          DataCell(Text(pregled.dijagnoza.toString())),
                          DataCell(
                              Text(_terapijaMap[pregled.terapijaId] ?? 'N/A')),
                          DataCell(Text(_doktorMap[pregled.doktorId] ?? 'N/A')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLicniPodaciTable() {
    if (widget.pacijent == null) {
      return Center(child: Text("Nema ličnih podataka za ovog pacijenta."));
    }
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    return Container(
      child: Card(
          child: AdaptiveScrollbar(
        underColor: Colors.blueGrey.withOpacity(0.3),
        sliderDefaultColor: Colors.grey.withOpacity(0.7),
        sliderActiveColor: Colors.grey,
        controller: _verticalScrollController,
        child: AdaptiveScrollbar(
          controller: _horizontalScrollController,
          position: ScrollbarPosition.bottom,
          underColor: Colors.blueGrey.withOpacity(0.3),
          sliderDefaultColor: Colors.grey.withOpacity(0.7),
          sliderActiveColor: Colors.grey,
          child: SingleChildScrollView(
            controller: _verticalScrollController,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Ime')),
                    DataColumn(label: Text('Prezime')),
                    DataColumn(label: Text('Spol')),
                    DataColumn(label: Text('Datum rodjenja')),
                    DataColumn(label: Text('JMBG')),
                    DataColumn(label: Text('Mjesto rodjenja')),
                    DataColumn(label: Text('Prebivaliste')),
                    DataColumn(label: Text('Telefon')),
                    DataColumn(label: Text('Krvna grupa')),
                    DataColumn(label: Text('Rh Faktor')),
                    DataColumn(label: Text('Hronicne bolesti')),
                    DataColumn(label: Text('Alergija')),
                    DataColumn(label: Text('Broj kartona')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(widget.pacijent!.ime ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.prezime ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.spol ?? 'N/A')),
                        DataCell(Text(
                            widget.pacijent!.datumRodjenja?.toString() ??
                                'N/A')),
                        DataCell(Text(widget.pacijent!.jmbg ?? 'N/A')),
                        DataCell(
                            Text(widget.pacijent!.mjestoRodjenja ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.prebivaliste ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.telefon ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.krvnaGrupa ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.rhFaktor ?? 'N/A')),
                        DataCell(
                            Text(widget.pacijent!.hronicneBolesti ?? 'N/A')),
                        DataCell(Text(widget.pacijent!.alergija ?? 'N/A')),
                        DataCell(Text(
                            widget.pacijent!.brojKartona?.toString() ?? 'N/A')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
