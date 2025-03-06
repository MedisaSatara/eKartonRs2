import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/pregled.dart';
import 'package:ekarton_mobile/models/preventivne_mjere.dart';
import 'package:ekarton_mobile/models/terapija.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_oboljenja_provider.dart';
import 'package:ekarton_mobile/providers/pregled_provider.dart';
import 'package:ekarton_mobile/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_mobile/providers/terapija_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late PacijentOboljenjaProvider _pacijentOboljenjaProvider;

  List<Nalaz>? filteredNalazi;
  List<PreventivneMjere>? filteredMjere;
  List<PacijentOboljenja>? pacijentOboljenja;
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
    _pacijentOboljenjaProvider = context.read<PacijentOboljenjaProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _nalazProvider.get();
    var mjereData = await _preventivneMjereProvider.get();
    var pregledData = await _pregledProvider.get();
    var doktorData = await _doktorProvider.get();
    var terapijaData = await _terapijaProvider.get();
    var pacijentOboljenjaData = await _pacijentOboljenjaProvider.get();

    setState(() {
      filteredNalazi = data.result
          ?.where((nalaz) => nalaz.pacijentId == widget.pacijent?.pacijentId)
          .toList();

      filteredMjere = mjereData.result
          ?.where((mjere) => mjere.pacijentId == widget.pacijent?.pacijentId)
          .toList();

      pacijentOboljenja = pacijentOboljenjaData.result
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
                        ? "Patients first and last name: ${widget.pacijent!.ime} ${widget.pacijent!.prezime}"
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
                      _buildButton("Personal data", Icons.person, () {
                        setState(() {
                          showLicniPodaci = true;
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                        });
                      }),
                      _buildButton("Diseases", Icons.history, () {
                        setState(() {
                          showOboljenjeScreen = true;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("Results", Icons.history, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = true;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("Periodic inspection", Icons.healing, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = true;
                          showPreventivneMjereScreen = false;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("Preventive measure", Icons.healing, () {
                        setState(() {
                          showOboljenjeScreen = false;
                          showNalazScreen = false;
                          showPeriodicniPregledScreen = false;
                          showPreventivneMjereScreen = true;
                          showPregledScreen = false;
                          showLicniPodaci = false;
                        });
                      }),
                      _buildButton("Appointment date", Icons.healing, () {
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
                      child: _buildOboljenjeTable(),
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
                      child: _buildPeriodicnaTable(),
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
                        DataColumn(label: Text('Results')),
                        DataColumn(label: Text('Date')),
                      ],
                      rows: filteredNalazi!.map((nalaz) {
                        return DataRow(
                          cells: [
                            DataCell(Text(nalaz.licnaAnamneza.toString())),
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
                      DataColumn(label: Text('Condition')),
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
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Reason for visit')),
                      DataColumn(label: Text('Diagnosis')),
                      DataColumn(label: Text('Therapy')),
                      DataColumn(label: Text('Doctors name')),
                    ],
                    rows: filteredPregled!.map((pregled) {
                      return DataRow(
                        cells: [
                          DataCell(Text(pregled.datum != null
                              ? DateFormat('yyyy-MM-dd').format(pregled.datum!)
                              : '')),
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
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 78, 57),
        borderRadius: BorderRadius.circular(10),
      ),
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
                      DataColumn(label: Text('Parameter')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text('First name')),
                          DataCell(Text(widget.pacijent!.ime ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Last name')),
                          DataCell(Text(widget.pacijent!.prezime ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Gender')),
                          DataCell(Text(widget.pacijent!.spol ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Date of birth')),
                          DataCell(Text(
                            widget.pacijent!.datumRodjenja != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(widget.pacijent!.datumRodjenja!)
                                : '',
                          )),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('JMBG')),
                          DataCell(Text(widget.pacijent!.jmbg ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Birthplace')),
                          DataCell(
                              Text(widget.pacijent!.mjestoRodjenja ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Residence')),
                          DataCell(
                              Text(widget.pacijent!.prebivaliste ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Phone number')),
                          DataCell(Text(widget.pacijent!.telefon ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Blood type')),
                          DataCell(Text(widget.pacijent!.krvnaGrupa ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Rh Factor')),
                          DataCell(Text(widget.pacijent!.rhFaktor ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Chronic diseases')),
                          DataCell(
                              Text(widget.pacijent!.hronicneBolesti ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Allergy')),
                          DataCell(Text(widget.pacijent!.alergija ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Carton number')),
                          DataCell(Text(
                              widget.pacijent!.brojKartona?.toString() ??
                                  'N/A')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      constraints: BoxConstraints(maxWidth: 130),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 34, 78, 57),
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
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

  Widget _buildOboljenjeTable() {
    if (pacijentOboljenja == null || pacijentOboljenja!.isEmpty) {
      return Center(child: Text("Nema oboljenja za ovog pacijenta."));
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
                      DataColumn(label: Text('Nesposoban za rad')),
                      DataColumn(label: Text('Nesposoban za rad od')),
                      DataColumn(label: Text('Nesposoban za rad do')),
                    ],
                    rows: pacijentOboljenja!.map((mjere) {
                      return DataRow(
                        cells: [
                          DataCell(Text(mjere.nesposobanZaRad.toString())),
                          DataCell(Text(mjere.nesposobanZaRadOd.toString())),
                          DataCell(Text(mjere.nesposobanZaRadDo.toString())),
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

  Widget _buildPeriodicnaTable() {
    if (filteredMjere == null || filteredMjere!.isEmpty) {
      return Center(
          child: Text("Nema periodicnih pregleda za ovog pacijenta."));
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
