import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

final String tunneldomain = "http://13.233.99.51:8000";

String userurl = tunneldomain + "/database/userDetails";
SharedPreferences localStorage;

getUserDetails() async {
  localStorage = await SharedPreferences.getInstance();
  String aadhaar = localStorage.getString('aadhaar');
  print("Aadhar Captured " + aadhaar);

  var data = {"aadhar": aadhaar};
  http.post(userurl, body: data).then((value) => {
        print(value.body),
      });
}
