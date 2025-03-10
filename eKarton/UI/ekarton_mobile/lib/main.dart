import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/providers/bolnica_provider.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/nalaz_provider.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
import 'package:ekarton_mobile/providers/odjel_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_oboljenja_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/pregled_provider.dart';
import 'package:ekarton_mobile/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_mobile/providers/terapija_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/providers/uloga_provider.dart';
import 'package:ekarton_mobile/screens/ekarton_screen.dart';
import 'package:ekarton_mobile/screens/home_screen.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/screens/online_pay_screen.dart';
import 'package:ekarton_mobile/screens/welcome_page.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as sp;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    sp.Stripe.publishableKey = const String.fromEnvironment(
      'STRIPE_PUBLISHABLE_KEY',
      defaultValue: stripePublishableKey);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BolnicaProvider()),
      ChangeNotifierProvider(create: (_) => PacijentProvider()),
      ChangeNotifierProvider(create: (_) => PacijentOboljenjaProvider()),
      ChangeNotifierProvider(create: (_) => NalazProvider()),
      ChangeNotifierProvider(create: (_) => PreventivneMjereProvider()),
      ChangeNotifierProvider(create: (_) => PregledProvider()),
      ChangeNotifierProvider(create: (_) => DoktorProvider()),
      ChangeNotifierProvider(create: (_) => TerapijaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => OcjenaDoktorProvider()),
      ChangeNotifierProvider(create: (_) => OdjelProvider()),
    ],
    child: MyApp(),
  ));
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
 // Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late KorisnikProvider _korisnikProvider;
  int? loggedInUserID;
  bool _isLoading = false;
  bool _isHover = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    var username = _usernameController.text;
    var password = _passwordController.text;

    Authorization.username = username;
    Authorization.password = password;

    try {
      Authorization.korisnik = await _korisnikProvider.Authenticate();

      if (Authorization.korisnik?.korisnikUlogas
              .any((role) => role.uloga?.naziv == "Korisnik") ==
          true) {
        setState(() {
          loggedInUserID = Authorization.korisnik?.korisnikId;
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
                "Vaš korisnički račun nema permisije za pristup admin panelu!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Pogrešno korisničko ime ili lozinka!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = context.read<KorisnikProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text("User login!"),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                "assets/images/welcomepage.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
              child: Container(
                color:
                    const Color.fromARGB(255, 202, 202, 202).withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Opacity(
                          opacity: 0.7,
                          child: Image.asset(
                            "assets/images/logo.jpg",
                            fit: BoxFit.cover,
                            width: 370,
                            height: 150,
                          )),
                      SizedBox(
                        height: 66,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon:
                                Icon(Icons.account_circle, color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _usernameController,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon:
                                Icon(Icons.password, color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: 370,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 34, 78, 57)),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
