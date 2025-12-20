import 'package:flutter/material.dart';
import 'reservation_page.dart';
import 'login.dart';
import 'globals.dart' as globals;

class ItemPage extends StatefulWidget {
  final Map restaurant;
  const ItemPage({super.key, required this.restaurant});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late Future<List<Map<String, dynamic>>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _refreshReviews();
  }

  void _refreshReviews() {
    setState(() {
      _reviewsFuture = globals.fetchRemoteReviews(widget.restaurant["name"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List menu = widget.restaurant["menu"] ?? [];
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
                    tag: widget.restaurant["name"],
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(widget.restaurant["image"], fit: BoxFit.cover),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(widget.restaurant["name"],
                            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: accentColor, size: 24),
                          Text(" ${widget.restaurant["rate"]}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Text(widget.restaurant["category"].toUpperCase(),
                      style: const TextStyle(color: accentColor, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 30),
                  _contactRow(Icons.phone_iphone, "Phone", widget.restaurant["phone"] ?? "N/A"),
                  _contactRow(Icons.location_on, "Address", widget.restaurant["address"]),
                  const Divider(height: 40),
                  const Text("The Experience", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(widget.restaurant["desc"],
                      style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey.shade800)),
                  const Divider(height: 40),
                  const Text("Best Sellers", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  ...menu.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item["name"], style: const TextStyle(fontSize: 18)),
                        Text("\$${item["price"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
                      ],
                    ),
                  )).toList(),
                  const Divider(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("What Guests Say", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      TextButton.icon(
                        onPressed: _showReviewDialog,
                        icon: const Icon(Icons.add_comment, color: accentColor, size: 20),
                        label: const Text("Write Review", style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // --- LIVE REVIEWS SECTION ---
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: _reviewsFuture,
                      builder: (context, snapshot) {
                        final List hardcoded = widget.restaurant["reviews"] ?? [];
                        final List databaseReviews = snapshot.data ?? [];
                        final List allReviews = [...hardcoded, ...databaseReviews];

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                          ));
                        }

                        return Column(
                          children: allReviews.reversed.map((rev) {
                            // SAFETY: Parse rating to int to avoid type errors
                            int rating = int.tryParse(rev["rating"].toString()) ?? 5;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(rev["user"] ?? "Guest", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      ...List.generate(5, (index) => Icon(
                                          Icons.star,
                                          size: 14,
                                          color: index < rating ? accentColor : Colors.grey[300]
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text("${rev["comment"]}", style: const TextStyle(fontStyle: FontStyle.italic)),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(accentColor),
    );
  }

  void _showReviewDialog() {
    if (!globals.isLoggedIn) {
      _showLoginAlert(context);
      return;
    }
    final controller = TextEditingController();
    int selectedStars = 5;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Rate your Visit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => setDialogState(() => selectedStars = index + 1),
                    icon: Icon(index < selectedStars ? Icons.star : Icons.star_border, color: const Color(0xFFD4AF37), size: 32),
                  );
                }),
              ),
              TextField(controller: controller, maxLines: 3, decoration: const InputDecoration(hintText: "Comment...", border: OutlineInputBorder())),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  await globals.saveReview({
                    "restaurant": widget.restaurant["name"],
                    "user": globals.currentUserName,
                    "comment": controller.text,
                    "rating": selectedStars
                  });
                  _refreshReviews(); // Reload list
                  if(mounted) Navigator.pop(context);
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(Color accentColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 35),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("AVG COST", style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(widget.restaurant["avgCost"] ?? "N/A", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accentColor, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              if (globals.isLoggedIn) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ReservationPage(restaurantName: widget.restaurant["name"])));
              } else { _showLoginAlert(context); }
            },
            child: const Text("RESERVE NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showLoginAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Required"),
        content: const Text("Sign in to book or review."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())); }, child: const Text("Login")),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(children: [
        Icon(icon, color: const Color(0xFFD4AF37), size: 24),
        const SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}