import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  getCountries(urlLink) async {
    var url = Uri.parse(urlLink);
    var server = await http.get(
      url,
    );
    return jsonDecode(server.body);
  }

  getCountryByCode() async {
    var url = Uri.parse('https://countriesnow.space/api/v0.1/countries/flag/unicode');
    var server = await http.post(
      url,
      body: {
        "iso2": "NG",
      },
    );
    return jsonDecode(server.body);
  }
}