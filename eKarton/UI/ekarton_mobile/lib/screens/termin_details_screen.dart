import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/screens/list_preporuceni_doktori.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TerminDetailsScreen extends StatefulWidget {
  final Termin? termin;
  TerminDetailsScreen({Key? key, this.termin}) : super(key: key);

  @override
  State<TerminDetailsScreen> createState() => _TerminDetailsScreen();
}

class _TerminDetailsScreen extends State<TerminDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TerminProvider _terminProvider;
  late PacijentProvider _pacijentProvider;
  late DoktorProvider _doktorProvider;

  List<Pacijent>? _pacijenti;
  List<Doktor>? _doktori;

  String? _selectedPacijentId;
  String? _selectedDoktorId;

  late Map<String, dynamic> _initialValue;

  List<Map<String, String>> stateOptions = [
    {"display": "Active", "value": "Active"},
    {"display": "Draft", "value": "Draft"},
    {"display": "Cancelled", "value": "Cancelled"},

  ];

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'datum': widget.termin?.datum,
      'vrijeme': widget.termin?.vrijeme,
      'razlog': widget.termin?.razlog,
      'pacijentId': widget.termin?.pacijentId,
      'doktorId': widget.termin?.doktorId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminProvider>();
    _pacijentProvider = context.read<PacijentProvider>();
    _doktorProvider = context.read<DoktorProvider>();

    _fetchPatients();
    _fetchDoktori();
  }

  Future<void> _fetchPatients() async {
    try {
      var pacijentiData = await _pacijentProvider.get();
      setState(() {
        _pacijenti = pacijentiData.result;
      });
    } catch (e) {
      print('Error fetching patients: $e');
    }
  }

  Future<void> _fetchDoktori() async {
    try {
      var doktoriData = await _doktorProvider.get();
      setState(() {
        _doktori = doktoriData.result;
      });
    } catch (e) {
      print('Error fetching doktori: $e');
    }
  }

  Future<void> _fetchRecommendedDoctors() async {
    try {
      _doktori = await _doktorProvider.fetchRecommendedDoctors();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
    setState(() {});
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['pacijentId'] != null) {
        mutableFormData['pacijentId'] =
            int.tryParse(mutableFormData['pacijentId'] as String) ?? 0;
      }
      if (mutableFormData['doktorId'] != null) {
        mutableFormData['doktorId'] =
            int.tryParse(mutableFormData['doktorId'] as String) ?? 0;
      }

      try {
        if (widget.termin == null) {
          await _terminProvider.insert(Termin.fromJson(mutableFormData));
          Navigator.of(context).pop();

          _showSuccessDialog('Appoitment successufully added.');
        } else {
          await _terminProvider.update(
              widget.termin!.terminId!, Termin.fromJson(mutableFormData));
          Navigator.of(context).pop();

          _showSuccessDialog('Apoitment successufully updated.');
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the term. Please try again.')),
        );
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _showRecommendedDoctors = false;

  void _toggleRecommendedDoctors() {
    setState(() {
      _showRecommendedDoctors = !_showRecommendedDoctors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adding a new appointment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  name: "datum",
                  readOnly: true,
                  initialValue: _initialValue['datum'],
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      String formattedDate =
                          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

                      _formKey.currentState?.fields['datum']
                          ?.didChange(formattedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Datum u formatu yyyy-MM-dd';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Time",
                      border: OutlineInputBorder(),
                    ),
                    name: "vrijeme",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Reason",
                      border: OutlineInputBorder(),
                    ),
                    name: "razlog",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'stateMachine',
                  decoration: InputDecoration(
                    labelText: 'State Machine',
                  ),
                  items: stateOptions
                      .map((state) => DropdownMenuItem<String>(
                            value: state['value'],
                            child: Text(state['display']!),
                          ))
                      .toList(),
                  initialValue: _initialValue['stateMachine'],
                  onChanged: (value) {
                    print("Odabrano stanje: $value");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'pacijentId',
                    decoration: InputDecoration(
                      labelText: 'Patient',
                    ),
                    items: _pacijenti
                            ?.map((pacijent) => DropdownMenuItem<String>(
                                  value: pacijent.pacijentId.toString(),
                                  child: Text(pacijent.ime ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['pacijentId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPacijentId = value;
                      });
                      print("Odabrani pacijentId: $_selectedPacijentId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'doktorId',
                    decoration: InputDecoration(
                      labelText: 'Doctor',
                    ),
                    items: _doktori
                            ?.map((doktor) => DropdownMenuItem<String>(
                                  value: doktor.doktorId.toString(),
                                  child: Text(doktor.ime ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['doktorId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDoktorId = value;
                      });
                      print("Odabrani doktorId: $_selectedDoktorId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                Text(
                  'View a list of recommended doctors, based on the ratings they have received from patients.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _toggleRecommendedDoctors,
                  child: Text(_showRecommendedDoctors
                      ? 'Hide recommended doctors'
                      : 'Show recommended doctors'),
                ),
                if (_showRecommendedDoctors)
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: RecommendedDoctorScreen(),
                  ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.termin == null ? 'Add' : 'Edit data'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.termin != null
          ? "Appoitment: ${widget.termin?.pacijentId}"
          : "Appoitment details",
    );
  }
}
