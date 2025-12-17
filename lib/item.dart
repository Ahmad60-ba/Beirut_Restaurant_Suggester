import 'package:flutter/material.dart';
import 'reservation_page.dart';

class ItemPage extends StatelessWidget {
  final Map restaurant;
  const ItemPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final List menu = restaurant["menu"] ?? [];
    final List reviews = restaurant["reviews"] ?? [];

    const accentColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade100, Colors.white],
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: restaurant["name"],
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          restaurant["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(restaurant["name"],
                            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: accentColor, size: 24),
                          Text(" ${restaurant["rate"]}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Text(restaurant["category"].toUpperCase(),
                      style: const TextStyle(color: accentColor, fontWeight: FontWeight.bold, letterSpacing: 2)),

                  const SizedBox(height: 30),

                  // Contact
                  _contactRow(Icons.phone_iphone, "Phone", restaurant["phone"] ?? "N/A"),
                  _contactRow(Icons.location_on, "Address", restaurant["address"]),

                  const Divider(height: 40),

                  // About
                  const Text("The Experience", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(restaurant["desc"],
                      style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey.shade800)),

                  const Divider(height: 40),

                  // MENU
                  const Text("Best Sellers", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  ...menu.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item["name"], style: const TextStyle(fontSize: 18)),
                        Text("\$${item["price"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
                      ],
                    ),
                  )).toList(),

                  const Divider(height: 40),

                  // REVIEWS
                  const Text("What Guests Say", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  ...reviews.map((rev) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(rev["user"], style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            ...List.generate(5, (index) => Icon(
                                Icons.star,
                                size: 14,
                                color: index < (rev["rating"] ?? 5) ? accentColor : Colors.grey[300]
                            )),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text("${rev["comment"]}", style: const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  )).toList(),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),


      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 35),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("AVG COST", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(restaurant["avgCost"] ?? "N/A",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ReservationPage(restaurantName: restaurant["name"])));
              },
              child: const Text("RESERVE NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 24),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}