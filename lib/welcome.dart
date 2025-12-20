import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'globals.dart' as globals;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/beirut.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.forest, color: Colors.green, size: 80),
                    const SizedBox(height: 20),
                    const Text(
                      "BEIRUT",
                      style: TextStyle(
                        fontSize: 42, color: Colors.white,
                        fontWeight: FontWeight.w900, letterSpacing: 8,
                      ),
                    ),
                    const Text(
                      "RESTAURANT GUIDE",
                      style: TextStyle(
                        color: Colors.white70, fontSize: 12,
                        letterSpacing: 4, fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 80),
                    _buildCompactButton(
                      context,
                      "LOGIN",
                      Colors.redAccent,
                          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                    ),
                    const SizedBox(height: 15),
                    _buildCompactButton(
                      context,
                      "SIGN UP",
                      Colors.green,
                          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage())),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          globals.isLoggedIn = false;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                        },
                        child: const Text("GUEST ACCESS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactButton(BuildContext context, String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 200, height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
    );
  }
}