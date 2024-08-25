import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Future<Korisnik?> login(String username, String password) async {
    try {
      var response =
          await get(filter: {'username': username, 'password': password});

      if (response.result.isNotEmpty) {
        return response.result.first;
      }
    } catch (e) {
      print("Error during login: $e");
    }
    return null; // Return null if no user is found or on error
  }
}
