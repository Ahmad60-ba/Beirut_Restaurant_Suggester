import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationPage extends StatefulWidget {
  final String restaurantName;
  const ReservationPage({super.key, required this.restaurantName});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String selectedTime = "19:00";
  int guests = 2;
  bool isSending = false;

  final Map<String, List<String>> dynamicSchedule = {
    "Monday": ["12:00", "13:00", "14:00"],
    "Friday": ["18:00", "19:00", "20:00", "21:00", "22:00"],
    "Saturday": ["12:00", "15:00", "18:00", "21:00", "23:00"],
    "Sunday": ["11:00", "12:30", "14:00", "16:00"],
  };

  List<String> availableTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _updateAvailableTimes(selectedDate);
  }

  void _updateAvailableTimes(DateTime date) {
    String dayName = _getDayName(date);
    setState(() {
      availableTimeSlots = dynamicSchedule[dayName] ?? ["17:00", "18:00", "19:00", "20:00"];
      selectedTime = availableTimeSlots.first;
    });
  }

  String _getDayName(DateTime date) {
    List<String> weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    return weekdays[date.weekday - 1];
  }

  Future<void> _submitToDatabase() async {
    setState(() => isSending = true);

    final url = Uri.parse("http://beiruteats.atwebpages.com/make_reservation.php");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "restaurant_name": widget.restaurantName,
          "full_name": _nameController.text.trim(),
          "phone": _phoneController.text.trim(),
          "res_date": "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          "res_time": selectedTime,
          "guests": guests,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          _showSuccess();
        } else {
          _showError("Server Error: ${result['message']}");
        }
      } else {
        _showError("Server Status: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Check internet or AwardSpace URL.");
    } finally {
      setState(() => isSending = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Finalize Reservation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: Colors.amber.shade50,
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                const SizedBox(width: 12),
                Expanded(child: Text("Maximum 1-2 hours to cancel after booking.", style: TextStyle(color: Colors.amber.shade900, fontSize: 12))),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.restaurantName, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 30),
                  _buildTextField(_nameController, "Full Name", Icons.person_outline),
                  const SizedBox(height: 15),
                  _buildTextField(_phoneController, "Phone Number", Icons.phone_android_outlined, isPhone: true),
                  const SizedBox(height: 35),
                  _buildDatePicker(),
                  const SizedBox(height: 15),
                  _buildTimePicker(),
                  const SizedBox(height: 35),
                  _buildGuestCounter(),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPhone = false}) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30))
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
          _updateAvailableTimes(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.calendar_month, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Wrap(
      spacing: 10,
      children: availableTimeSlots.map((time) {
        bool active = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: active,
          onSelected: (val) => setState(() => selectedTime = time),
          selectedColor: Colors.black,
          labelStyle: TextStyle(color: active ? Colors.white : Colors.black),
        );
      }).toList(),
    );
  }

  Widget _buildGuestCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () => setState(() => guests > 1 ? guests-- : null), icon: const Icon(Icons.remove_circle, size: 30)),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 25), child: Text("$guests", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
        IconButton(onPressed: () => setState(() => guests++), icon: const Icon(Icons.add_circle, size: 30, color: Colors.redAccent)),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size(double.infinity, 60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        onPressed: isSending ? null : () {
          if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
            _showError("Please fill in your details");
          } else {
            _submitToDatabase();
          }
        },
        child: isSending ? const CircularProgressIndicator(color: Colors.white) : const Text("SEND REQUEST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const Text("Thank you! Your reservation request has been sent to the restaurant. They will contact you shortly to confirm availability.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("DONE"))
          ],
        ),
      ),
    );
  }
}