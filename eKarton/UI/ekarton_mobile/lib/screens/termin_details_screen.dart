import 'dart:convert';

import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/stripe_service.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/preporuceni_doktori.dart';
import 'package:ekarton_mobile/screens/list_preporuceni_doktori.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as sp;
import 'package:http/http.dart' as http;

class TerminDetailsScreen extends StatefulWidget {
  final Termin? termin;
  final String? paymentIntentId;
  final Function? onDataChanged;
  TerminDetailsScreen({Key? key, this.termin, this.paymentIntentId, this.onDataChanged})
      : super(key: key);

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
  List<Termin>? _termin;

  String? _selectedPacijentId;
  String? _selectedDoktorId;
  String? _pacijentIme;

  late Map<String, dynamic> _initialValue;
  double? _selectedCijena;

  Map<String, dynamic>? paymentIntent;
  String? transactionId;

  bool _showRecommendedDoctors = false;
  bool isLoading = false;

  List<Map<String, String>> stateOptions = [
    {"display": "active", "value": "active"},
    {"display": "draft", "value": "draft"},
    {"display": "cancelled", "value": "cancelled"},
  ];

  List<Map<String, String>> razloziPregleda = [
    {"display": "Opšti pregled", "value": "Opšti pregled"},
    {"display": "Rutinska kontrola", "value": "Rutinska kontrola"},
    {"display": "Specijalistički pregled", "value": "Specijalistički pregled"},
    {"display": "Laboratorijska analiza", "value": "Laboratorijska analiza"},
    {"display": "Hitni pregled", "value": "Hitni pregled"},
  ];

  Map<String, double> pregledCijene = {
    "Opšti pregled": 50.0,
    "Rutinska kontrola": 10.0,
    "Specijalistički pregled": 100.0,
    "Laboratorijska analiza": 30.0,
    "Hitni pregled": 150.0,
  };

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'datum': widget.termin?.datum,
      'vrijeme': widget.termin?.vrijeme,
      'razlog': widget.termin?.razlog,
      'pacijentId': widget.termin?.pacijentId,
      'doktorId': widget.termin?.doktorId,
      'stateMachine': widget.termin?.stateMachine,
      'brojTransakcije': widget.paymentIntentId ?? '',
      'cijenaPregleda': widget.termin?.cijenaPregleda,
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
        if (widget.termin?.pacijentId != null) {
          var pacijent = _pacijenti?.firstWhere(
            (p) => p.pacijentId == widget.termin?.pacijentId,
          );
          _pacijentIme = pacijent?.ime;
        }
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

  Future<void> _fetchTermini() async {
    try {
      var terminData = await _terminProvider.get();
      setState(() {
        _termin = terminData.result;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
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
      if (mutableFormData['stateMachine'] != null) {
        mutableFormData['stateMachine'] =
            mutableFormData['stateMachine'] as String;
      }
      if (mutableFormData['razlog'] != null) {
        mutableFormData['razlog'] = mutableFormData['razlog'] as String;
      }

      mutableFormData['cijenaPregleda'] = _selectedCijena;
      mutableFormData['brojTransakcije'] = paymentIntent?['id'];

      try {
        if (widget.termin == null) {
          await _terminProvider.insert(Termin.fromJson(mutableFormData));
        } else {
          await _terminProvider.update(
              widget.termin!.terminId!, Termin.fromJson(mutableFormData));
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the term. Please try again.')),
        );
      }
    }
  }

  void _toggleRecommendedDoctors() {
    setState(() {
      _showRecommendedDoctors = !_showRecommendedDoctors;
    });
  }

  Future<Map<String, dynamic>> makePaymentIntent() async {
    String secretKey = const String.fromEnvironment("STRIPE_SECRET_KEY",
        defaultValue: stripeSecretKey);

    final body = {
      'amount': calculateAmount().toString(),
      'currency': 'BAM',
      'payment_method_types[]': 'card',
    };

    final headers = {
      'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      headers: headers,
      body: body,
    );

    return jsonDecode(response.body);
  }

  Future<void> displayPaymentSheet() async {
    try {
      await sp.Stripe.instance.presentPaymentSheet();
      await _submitForm();
      _showSuccessDialog('Payment Successful!');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        padding: const EdgeInsets.all(15),
        content: const Text(
          "Transaction cancelled",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await makePaymentIntent();
      await sp.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: sp.SetupPaymentSheetParameters(
          merchantDisplayName: 'Kreiranje termina pregleda',
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
        ),
      );
      await displayPaymentSheet();
    } catch (e) {
      throw Exception(e);
    }
  }

  int calculateAmount() {
    double amount = _selectedCijena ?? 0.0;
    return (amount * 100).toInt();
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              SizedBox(height: 10),
              Text("Broj transakcije: ${paymentIntent?['id']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _formKey.currentState?.fields['brojTransakcije']
                    ?.didChange(paymentIntent?['id']);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _successDialogADD(String message) {
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
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
                  widget.termin == null
                      ? 'Adding a new appointment'
                      : 'Updating appointment',
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
                FormBuilderDropdown<String>(
                  name: 'razlog',
                  decoration: InputDecoration(
                    labelText: 'Reasone',
                  ),
                  items: razloziPregleda
                      .map((option) => DropdownMenuItem<String>(
                            value: option['value'],
                            child: Text(option['display'] ?? ''),
                          ))
                      .toList(),
                  initialValue: _initialValue['razlog'],
                  onChanged: (value) {
                    setState(() {
                      _initialValue['razlog'] = value;
                      _selectedCijena = pregledCijene[value];
                    });
                    print("Odabrani razlog: $value");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                if (_selectedCijena != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: $_selectedCijena',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await makePayment();
                        },
                        child: Text("Pay"),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Transaction Number",
                    border: OutlineInputBorder(),
                  ),
                  name: "brojTransakcije",
                  initialValue: paymentIntent?['id'],
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'stateMachine',
                  decoration: InputDecoration(
                    labelText: 'State machine',
                  ),
                  items: stateOptions
                      .map((option) => DropdownMenuItem<String>(
                            value: option['value'],
                            child: Text(option['display'] ?? ''),
                          ))
                      .toList(),
                  initialValue: _initialValue['stateMachine'],
                  onChanged: (value) {
                    setState(() {
                      _initialValue['stateMachine'] = value;
                    });
                    print("Odabrani stateMachine: $value");
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
                  child: Text(widget.termin == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.termin != null
          ? "Appoitment: ${_pacijentIme}"
          : "Appoitment details",
    );
  }
}
