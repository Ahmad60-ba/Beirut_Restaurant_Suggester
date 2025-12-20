import 'package:flutter/material.dart';
import 'home.dart';
import 'signup.dart';
import 'forgot_password.dart'; // Ensure this matches your file name
import 'globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset("assets/beirut.jpg", fit: BoxFit.cover),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Welcome", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const Text("Sign in to your account", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 35),
                      _buildTextField("Username", Icons.account_circle, false, (val) => username = val!),
                      const SizedBox(height: 20),
                      _buildTextField("Password", Icons.lock_outline, true, (val) => password = val!),

                      // FORGOT PASSWORD LINK
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())),
                          child: const Text("Forgot Password?", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () async {
                          _formKey.currentState!.save();
                          bool success = await globals.verifyLogin(username, password);
                          if (success) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(username: username)));
                          } else {
                            _showError("Invalid Username or Password");
                          }
                        },
                        child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 15),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          globals.isLoggedIn = false;
                          globals.currentUserName = "";
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage(username: null)));
                        },
                        child: const Text("CONTINUE AS GUEST", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage())),
                          child: const Text("New user? Sign Up", style: TextStyle(color: Colors.black54)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  Widget _buildTextField(String hint, IconData icon, bool isPass, Function(String?) onSave) {
    return TextFormField(
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon, color: Colors.redAccent),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      onSaved: onSave,
    );
  }
}