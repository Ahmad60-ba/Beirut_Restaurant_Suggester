library restaurand_guide.globals;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// --- API CONFIG ---
const String apiURL = "http://beiruteats.atwebpages.com/make_reservation.php";

// --- Persistent Data ---
String registeredName = "";
String registeredPassword = "";
String registeredPhone = "";
bool isLoggedIn = false;
String currentUserName = "";

// 1. SAVE USER (Signup)
Future<void> saveUser(String name, String pass, String phone) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('reg_name', name);
  await prefs.setString('reg_pass', pass);
  await prefs.setString('reg_phone', phone);
  registeredName = name;
  registeredPassword = pass;
  registeredPhone = phone;

  try {
    await http.post(Uri.parse(apiURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "type": "signup",
        "username": name,
        "password": pass,
        "phone": phone
      }),
    );
  } catch (e) { print("Signup Error: $e"); }
}

// 2. VERIFY LOGIN (Updated to save session)
Future<bool> verifyLogin(String username, String password) async {
  try {
    final response = await http.post(Uri.parse(apiURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "type": "login",
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // --- SAVE SESSION TO DISK ---
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUserName', username);

        isLoggedIn = true;
        currentUserName = username;
        return true;
      }
    }
  } catch (e) { print("Login Error: $e"); }
  return false;
}

// 3. LOGOUT (The missing function that caused your error)
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  await prefs.remove('currentUserName');

  isLoggedIn = false;
  currentUserName = "";
}

// 4. SAVE REVIEW
Future<void> saveReview(Map<String, dynamic> review) async {
  try {
    await http.post(Uri.parse(apiURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "type": "review",
        "restaurant": review["restaurant"],
        "username": review["user"],
        "comment": review["comment"],
        "rating": review["rating"]
      }),
    );
  } catch (e) { print("Review Error: $e"); }
}

// 5. FETCH REMOTE REVIEWS
Future<List<Map<String, dynamic>>> fetchRemoteReviews(String resName) async {
  try {
    final response = await http.get(Uri.parse("$apiURL?fetch_reviews=${Uri.encodeComponent(resName)}"));
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((item) {
        return {
          "user": item["user"],
          "comment": item["comment"],
          "rating": int.tryParse(item["rating"].toString()) ?? 5,
        };
      }).toList();
    }
  } catch (e) { print("Fetch Error: $e"); }
  return [];
}

// 6. SAVE RESERVATION
Future<bool> saveReservation(Map<String, dynamic> resData) async {
  try {
    final response = await http.post(Uri.parse(apiURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "type": "reservation",
        "restaurant_name": resData['restaurant_name'],
        "full_name": resData['full_name'],
        "phone": resData['phone'],
        "res_date": resData['res_date'],
        "res_time": resData['res_time'],
        "guests": resData['guests'],
      }),
    );
    return response.statusCode == 200;
  } catch (e) { return false; }
}

// 7. LOAD DATA (Updated to check login status)
Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  registeredName = prefs.getString('reg_name') ?? "";
  registeredPassword = prefs.getString('reg_pass') ?? "";
  registeredPhone = prefs.getString('reg_phone') ?? "";

  // Load login state
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  currentUserName = prefs.getString('currentUserName') ?? "";
}