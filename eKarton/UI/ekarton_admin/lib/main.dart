import 'package:ekarton_admin/providers/administrator_provider.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/doktor_provider.dart';
import 'package:ekarton_admin/providers/korisnik_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/providers/osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_osiguranje_provider.dart';
import 'package:ekarton_admin/providers/pacijent_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/providers/uloga_provider.dart';
import 'package:ekarton_admin/screens/bolnica_list_screen.dart';
import 'package:ekarton_admin/screens/korisnik_profile_screen.dart';
import 'package:ekarton_admin/screens/home_screen.dart';
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

      /*  
      ChangeNotifierProvider(create: (_) => PacijentiProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => DoktorProvider()),
      ChangeNotifierProvider(create: (_) => OdjelProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
      ChangeNotifierProvider(create: (_) => BolnicaProvider()),*/
    ],
    child: MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

class LoginPage extends StatelessWidget {
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
                      // Set the credentials for authorization
                      Authorization.username = username;
                      Authorization.password = password;

                      // Fetch the user by the username and password
                      var korisnici = await korisnikProvider.get(filter: {
                        'korisnickoIme': username,
                        'password': password,
                      });

                      if (korisnici.result.isNotEmpty) {
                        var korisnik = korisnici.result.first;

                        // Check if the user has the admin role
                        if (korisnik.ulogaId == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => KorisnikProfileScreen()));
                        } else {
                          // Show an error message if the user is not an admin
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
                        // Show an error message if no user is found
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
}
