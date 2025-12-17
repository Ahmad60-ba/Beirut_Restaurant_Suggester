import 'package:flutter/material.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';

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
          // BACK ARROW
          Positioned(
            top: 50, left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
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
                      _buildInput("Full Name", Icons.account_circle),
                      const SizedBox(height: 15),
                      _buildInput("Email", Icons.email_outlined),
                      const SizedBox(height: 15),
                      _buildInput("Phone", Icons.phone_outlined),
                      const SizedBox(height: 15),
                      _buildInput("Password", Icons.lock_outline, isPass: true),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(username: username)));
                          }
                        },
                        child: const Text("SIGN UP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildInput(String hint, IconData icon, {bool isPass = false}) {
    return TextFormField(
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon, color: Colors.orangeAccent),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      onSaved: (val) => username = val ?? '',
    );
  }
}