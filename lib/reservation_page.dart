import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            color: Colors.amber.shade50, // Light caution background
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align with top for long text
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 24), // Caution Icon
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reservation Cancellation Policy",
                        style: TextStyle(color: Colors.amber.shade900, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "You have a maximum of 1–2 hours to cancel or decline after booking. Failure to do so will result in automatic confirmation.",
                        style: TextStyle(color: Colors.amber.shade900, fontSize: 12, height: 1.4),
                      ),
                    ],
                  ),
                ),
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


                  const Text("Contact Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildTextField(_nameController, "Full Name", Icons.person_outline),
                  const SizedBox(height: 15),

                  _buildTextField(_phoneController, "Phone Number", Icons.phone_android_outlined, isPhone: true),

                  const SizedBox(height: 35),


                  const Text("Pick Date & Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildDatePicker(),
                  const SizedBox(height: 15),
                  _buildTimePicker(),

                  const SizedBox(height: 35),


                  const Text("Guests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
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
      // This line rejects all letters and special characters, allowing only numbers
      inputFormatters: isPhone ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.redAccent, width: 2)),
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
            Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year} (${_getDayName(selectedDate)})",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Icon(Icons.calendar_month, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: availableTimeSlots.map((time) {
        bool active = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: active,
          onSelected: (val) => setState(() => selectedTime = time),
          selectedColor: Colors.black,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(color: active ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _buildGuestCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () => setState(() => guests > 1 ? guests-- : null), icon: const Icon(Icons.remove_circle, size: 30, color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text("$guests", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        IconButton(onPressed: () => setState(() => guests++), icon: const Icon(Icons.add_circle, size: 30, color: Colors.redAccent)),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
        ),
        onPressed: () {
          if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please fill in your name and phone number"), backgroundColor: Colors.redAccent)
            );
          } else {
            _showSuccess();
          }
        },
        child: const Text("SEND REQUEST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const SizedBox(height: 20),
            const Text("Request Received!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 12),
            const Text(
              "Thank you! Your reservation request has been sent to the restaurant. They will contact you shortly to confirm availability",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("DONE", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}