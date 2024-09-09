import 'package:ekarton_admin/providers/administrator_provider.dart';
import 'package:ekarton_admin/providers/bolesti_po_godistu.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/doktor_provider.dart';
import 'package:ekarton_admin/providers/doktori_pregled.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/providers/top3_doktora.dart';
import 'package:ekarton_admin/providers/uloga_provider.dart';
import 'package:ekarton_admin/screens/bolnica_list_screen.dart';
import 'package:ekarton_admin/screens/korisnik_profile_screen.dart';
import 'package:ekarton_admin/screens/home_screen.dart';
import 'package:ekarton_admin/screens/korisnik_screen.dart';
import 'package:ekarton_admin/screens/pacijent_list_screen.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AdministratorProvider()),
      ChangeNotifierProvider(create: (_) => BolnicaProvider()),
      ChangeNotifierProvider(create: (_) => PacijentProvider()),
      ChangeNotifierProvider(create: (_) => OdjelProvider()),
      ChangeNotifierProvider(create: (_) => DoktorProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => PreventivneMjereProvider()),
      ChangeNotifierProvider(create: (_) => OsiguranjeProvider()),
      ChangeNotifierProvider(create: (_) => PacijentOsiguranjeProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => Top3Doktora()),
      ChangeNotifierProvider(create: (_) => DoktoriPregled()),
      ChangeNotifierProvider(create: (_) => BolestiPoGodistu()),
    ],
    child: MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyMaterialApp(),
    );
  }
}

class MyAppBar extends StatelessWidget {
  String? title;
  MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!);
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

/*class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
          child: Card(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 200,
                  width: 300,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  obscureText: true, // Hide password input
                ),
                ElevatedButton(
                  onPressed: () async {
                    KorisnikProvider korisnikProvider =
                        context.read<KorisnikProvider>();

                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    try {
                      Authorization.username = username;
                      Authorization.password = password;

                      var korisnici = await korisnikProvider.get(filter: {
                        'korisnickoIme': username,
                        'password': password,
                      });

                      if (korisnici.result.isNotEmpty) {
                        var korisnik = korisnici.result.first;

                        if (korisnik.ulogaId == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => KorisnikProfileScreen()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Access Denied"),
                                    content:
                                        Text("You do not have admin rights."),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"))
                                    ],
                                  ));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Login Failed"),
                                  content:
                                      Text("Invalid username or password."),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"))
                                  ],
                                ));
                      }
                    } on Exception catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"))
                                ],
                              ));
                    }
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

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
              .any((role) => role.uloga?.naziv == "Admin") ==
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
        title: Text("Login admin!"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.jpg",
                    height: 200,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(41, 207, 200, 200),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Korisničko ime",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon:
                            Icon(Icons.account_circle, color: Colors.black),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      ),
                      controller: _usernameController,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(41, 188, 184, 192),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.password, color: Colors.black),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                      : ElevatedButton(
                          onPressed: _login,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
