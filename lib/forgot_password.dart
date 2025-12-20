import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isProcessing = false;

  void showTopNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160,
          left: 20,
          right: 20,
        ),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.green[600], // Changed to green for a "nice" successful feeling
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.sentiment_satisfied_alt, color: Colors.white), // Happy icon
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.asset("assets/beirut.jpg", fit: BoxFit.cover),
          ),
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
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Account Help", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text(
                      "To keep your account  secure, our team handles all password resets personally.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 30),

                    // Instruction Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.phone_android, color: Colors.redAccent),
                            title: Text("Contact via WhatsApp"),
                            subtitle: Text("+961 81 641 944"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.email_outlined, color: Colors.redAccent),
                            title: Text("Email Support"),
                            subtitle: Text("ahmed.baghdadi.ahmed@gmail.com"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: isProcessing ? null : () {
                        setState(() => isProcessing = true);

                        // 1. Show the nice message
                        showTopNotification(context, "Thank you! We're waiting for your message to help you out.");

                        // 2. Wait 2.5 seconds then redirect
                        Future.delayed(const Duration(milliseconds: 2500), () {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: isProcessing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "I UNDERSTAND",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
}