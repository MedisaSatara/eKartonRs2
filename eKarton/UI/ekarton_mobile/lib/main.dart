import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/providers/bolnica_provider.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/korisnik_provider.dart';
import 'package:ekarton_mobile/providers/nalaz_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_oboljenja_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/pregled_provider.dart';
import 'package:ekarton_mobile/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_mobile/providers/terapija_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/home_screen.dart';
import 'package:ekarton_mobile/screens/korisnik_profile_screen.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  await _setup;

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
    ],
    child: MyApp(),
  ));
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
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
      home: HomeScreen(),
    );
  }
}

class Login extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering the entire screen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Login form
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100), // Adjust space at the top if needed
                // Text logo
                Column(
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10), // Space between "Login" and "eKarton"
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "e",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.green, // Green color for "e"
                            ),
                          ),
                          TextSpan(
                            text: "Karton",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Black color for "Karton"
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        30), // Space between the text logo and username field
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 20), // Adjust space between elements if needed
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(174, 176, 214, 1),
                      Color.fromRGBO(198, 199, 233, 0.6)
                    ]),
                  ),
                  child: InkWell(
                    onTap: () async {
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

                          if (korisnik.ulogaId == 2) {
                            // If the user is a regular user (ulogaId = 2)
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => KorisnikProfileScreen(),
                              ),
                            );
                          } else {
                            // Show an error message if the user is not a regular user
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Access Denied"),
                                content: Text("You do not have user rights."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          // Show an error message if no user is found
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Login Failed"),
                              content: Text("Invalid username or password."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
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
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 20),
                Text("Forgot password?"),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
