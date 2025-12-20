import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'globals.dart' as globals;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset("assets/beirut.jpg", fit: BoxFit.cover),
          ),

          // Back Arrow
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
              height: MediaQuery.of(context).size.height * 0.75, // Taller to fit more buttons
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                      const Text("Join Us", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const Text("Create an account to explore more", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                      _buildInput("Full Name", Icons.account_circle, (val) => username = val!),
                      const SizedBox(height: 15),
                      _buildInput("Phone", Icons.phone_outlined, (val) => phone = val!),
                      const SizedBox(height: 15),
                      _buildInput("Password", Icons.lock_outline, (val) => password = val!, isPass: true),
                      const SizedBox(height: 30),

                      // SIGN UP BUTTON
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await globals.saveUser(username, password, phone);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Account Created! Please Login."))
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                          }
                        },
                        child: const Text("SIGN UP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),

                      const SizedBox(height: 15),

                      // GUEST BUTTON
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          side: const BorderSide(color: Colors.orangeAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          globals.isLoggedIn = false;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomePage(username: null))
                          );
                        },
                        child: const Text("BROWSE AS GUEST", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                      ),

                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Already have an account? Login", style: TextStyle(color: Colors.black54)),
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

  Widget _buildInput(String hint, IconData icon, Function(String?) onSave, {bool isPass = false}) {
    return TextFormField(
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon, color: Colors.orangeAccent),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      onSaved: onSave,
      validator: (val) => val == null || val.isEmpty ? "Required" : null,
    );
  }
}