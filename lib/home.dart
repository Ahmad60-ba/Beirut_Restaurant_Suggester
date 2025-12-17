import 'package:flutter/material.dart';
import 'package:restaurand_guide/welcome.dart';
import 'item.dart';
import 'login.dart';
import 'signup.dart';

class HomePage extends StatefulWidget {
  final String? username;
  const HomePage({super.key, this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  bool showHighRated = false;

  // My restaurants
  final List<Map> restaurants = [
    {
      "name": "Barbar", "category": "Lebanese", "rate": 4.6, "image": "assets/barbar.jpg", "address": "Hamra, Beirut", "phone": "+961 1 753 330",
      "desc": "Famous Lebanese fast-food restaurant known for shawarma, sandwiches, and grills.",
      "avgCost": "\$10 - \$20",
      "menu": [{"name": "Chicken Shawarma", "price": "6.50"}, {"name": "Meat Grills", "price": "14.00"}],
      "reviews": [{"user": "Sami", "rating": 5, "comment": "Best shawarma in Beirut!"}]
    },
    {
      "name": "Hawa Beirut", "category": "Lebanese", "rate": 4.0, "image": "assets/hawa.jpg", "address": "DownTown, Beirut", "phone": "+961 1 123 456",
      "desc": "Traditional Lebanese cuisine in a cozy atmosphere.",
      "avgCost": "\$25 - \$45",
      "menu": [{"name": "Mixed Mezze", "price": "18.00"}, {"name": "Kafta bil Sanieh", "price": "15.00"}],
      "reviews": [{"user": "Mona", "rating": 4, "comment": "Beautiful view of the clock tower."}]
    },
    {
      "name": "Al Beiruti", "category": "Lebanese", "rate": 4.3, "image": "assets/beiruti.jpg", "address": "DownTown, Beirut", "phone": "+961 1 234 567",
      "desc": "Authentic Lebanese flavors with family-friendly service.",
      "avgCost": "\$30 - \$50",
      "menu": [{"name": "Fattet Hummus", "price": "12.00"}, {"name": "Grilled Lamb", "price": "22.00"}],
      "reviews": [{"user": "Karim", "rating": 5, "comment": "The hummus is incredibly creamy."}]
    },
    {
      "name": "Beit Halab", "category": "Lebanese", "rate": 4.1, "image": "assets/halab.jpg", "address": "Ain-Mreiseh, Beirut", "phone": "+961 1 345 678",
      "desc": "Famous for traditional Levantine dishes and sweets.",
      "avgCost": "\$20 - \$35",
      "menu": [{"name": "Halabi Kabab", "price": "16.00"}, {"name": "Knefeh", "price": "7.50"}],
      "reviews": [{"user": "Omar", "rating": 4, "comment": "Authentic Aleppo taste."}]
    },
    {
      "name": "Loris", "category": "Lebanese", "rate": 3.5, "image": "assets/loris.jpg", "address": "Hamra, Beirut", "phone": "+961 1 456 789",
      "desc": "Casual Lebanese restaurant serving fresh shawarma and mezzes.",
      "avgCost": "\$15 - \$25",
      "menu": [{"name": "Loris Salad", "price": "8.50"}, {"name": "Beef Shawarma", "price": "7.00"}],
      "reviews": [{"user": "Lina", "rating": 3, "comment": "Food is good but service is a bit slow."}]
    },
    {
      "name": "Roadster Diner", "category": "American", "rate": 4.5, "image": "assets/roadster.jpg", "address": "ABC-Verdun, Beirut", "phone": "+961 1 791 111",
      "desc": "Popular diner offering burgers, fries, salads, and desserts.",
      "avgCost": "\$20 - \$35",
      "menu": [{"name": "Diner Burger", "price": "14.50"}, {"name": "BBQ Wings", "price": "9.50"}],
      "reviews": [{"user": "Mark", "rating": 5, "comment": "Consistent quality for years."}]
    },
    {
      "name": "The Goat", "category": "American", "rate": 2.4, "image": "assets/goat.jpg", "address": "Hamra, Beirut", "phone": "+961 1 567 890",
      "desc": "Modern American cuisine with gourmet burgers and sides.",
      "avgCost": "\$25 - \$40",
      "menu": [{"name": "Truffle Burger", "price": "18.00"}, {"name": "Loaded Fries", "price": "8.00"}],
      "reviews": [{"user": "Tarek", "rating": 2, "comment": "Too expensive for small portions."}]
    },
    {
      "name": "Cheese On Top", "category": "American", "rate": 4.6, "image": "assets/cheese.jpg", "address": "Bliss Street, Beirut", "phone": "+961 1 678 901",
      "desc": "Specializes in cheesy dishes and comfort food classics.",
      "avgCost": "\$12 - \$25",
      "menu": [{"name": "Mac n Cheese", "price": "11.00"}, {"name": "Cheese Injection Burger", "price": "15.00"}],
      "reviews": [{"user": "Jad", "rating": 5, "comment": "A cheese lover's paradise!"}]
    },
    {
      "name": "Mamma In Cucina", "category": "Italian", "rate": 4.5, "image": "assets/mama.jpg", "address": "Achrafieh, Beirut", "phone": "+961 1 789 012",
      "desc": "Homemade Italian pasta, pizza, and classic dishes.",
      "avgCost": "\$25 - \$45",
      "menu": [{"name": "Fettuccine Alfredo", "price": "17.00"}, {"name": "Margherita Pizza", "price": "14.50"}],
      "reviews": [{"user": "Giulia", "rating": 5, "comment": "Tastes exactly like Italy."}]
    },
    {
      "name": "Vicoli", "category": "Italian", "rate": 4.4, "image": "assets/vicoli.jpg", "address": "Hamra, Beirut", "phone": "+961 1 890 123",
      "desc": "Traditional Italian flavors with cozy ambiance.",
      "avgCost": "\$20 - \$40",
      "menu": [{"name": "Lasagna", "price": "16.50"}, {"name": "Tiramisu", "price": "8.50"}],
      "reviews": [{"user": "Maya", "rating": 4, "comment": "Very cozy spot for a date."}]
    },
    {
      "name": "Pertutti", "category": "Italian", "rate": 3.8, "image": "assets/pertutti.jpg", "address": "Mar-Takla, Beirut", "phone": "+961 1 901 234",
      "desc": "Authentic Italian cuisine with wood-fired pizza.",
      "avgCost": "\$25 - \$45",
      "menu": [{"name": "Quattro Formaggi", "price": "15.50"}, {"name": "Carbonara", "price": "16.00"}],
      "reviews": [{"user": "Elias", "rating": 4, "comment": "The crust is perfect."}]
    },
    {
      "name": "Squisito", "category": "Italian", "rate": 4.2, "image": "assets/squisto.jpg", "address": "Achrafieh, Beirut", "phone": "+961 1 012 345",
      "desc": "Fine Italian dining with pasta and dessert specialties.",
      "avgCost": "\$40 - \$80",
      "menu": [{"name": "Truffle Risotto", "price": "24.00"}, {"name": "Seafood Pasta", "price": "28.00"}],
      "reviews": [{"user": "Nour", "rating": 4, "comment": "High end and very tasty."}]
    },
    {
      "name": "Le Petit Gris", "category": "French", "rate": 4.5, "image": "assets/lepetit.jpg", "address": "Gemayze, Beirut", "phone": "+961 1 111 222",
      "desc": "Classic French bistro serving delicious French cuisine.",
      "avgCost": "\$50 - \$90",
      "menu": [{"name": "Steak Frites", "price": "34.00"}, {"name": "Escargot", "price": "18.00"}],
      "reviews": [{"user": "Jean", "rating": 5, "comment": "Best French bistro in town."}]
    },
    {
      "name": "Entre-Deux", "category": "French", "rate": 3.4, "image": "assets/entre.jpg", "address": "Mar-Mekhaiel, Beirut", "phone": "+961 1 222 333",
      "desc": "Charming French restaurant with fine dining experience.",
      "avgCost": "\$60 - \$110",
      "menu": [{"name": "Duck Confit", "price": "38.00"}, {"name": "Crème Brûlée", "price": "11.00"}],
      "reviews": [{"user": "Sara", "rating": 3, "comment": "Good food but very expensive."}]
    },
    {
      "name": "L'Autre Bistro", "category": "French", "rate": 3.5, "image": "assets/latu.jpg", "address": "Achrafieh, Beirut", "phone": "+961 1 333 444",
      "desc": "Cozy bistro serving classic French dishes.",
      "avgCost": "\$45 - \$75",
      "menu": [{"name": "Onion Soup", "price": "13.50"}, {"name": "Coq au Vin", "price": "29.00"}],
      "reviews": [{"user": "Nabil", "rating": 4, "comment": "The soup is legendary."}]
    },
    {
      "name": "Plume La Brasserie", "category": "French", "rate": 4.2, "image": "assets/plume.jpg", "address": "Hamra, Beirut", "phone": "+961 1 444 555",
      "desc": "Brasserie with authentic French meals and pastries.",
      "avgCost": "\$35 - \$60",
      "menu": [{"name": "Croque Monsieur", "price": "16.00"}, {"name": "Fruit Tart", "price": "9.50"}],
      "reviews": [{"user": "Lea", "rating": 4, "comment": "Perfect for a fancy lunch."}]
    },
    {
      "name": "Lezard Noir", "category": "French", "rate": 4.3, "image": "assets/lezard.jpg", "address": "Beirut-Souks, Beirut", "phone": "+961 1 555 666",
      "desc": "Upscale French dining with modern presentation.",
      "avgCost": "\$55 - \$100",
      "menu": [{"name": "Beef Tartare", "price": "26.00"}, {"name": "Chocolate Fondant", "price": "12.00"}],
      "reviews": [{"user": "Marc", "rating": 4, "comment": "Elegant and artistic."}]
    },
    {
      "name": "Eddys", "category": "Street Food", "rate": 4.5, "image": "assets/eddys.jpg", "address": "Abraj, Beirut", "phone": "+961 1 666 777",
      "desc": "Fast and tasty street food including sandwiches and wraps.",
      "avgCost": "\$5 - \$15",
      "menu": [{"name": "Fajita Sandwich", "price": "6.50"}, {"name": "Philly Steak", "price": "7.50"}],
      "reviews": [{"user": "Walid", "rating": 5, "comment": "Best sandwiches in Abraj."}]
    },
    {
      "name": "Sisters Wrap", "category": "Street Food", "rate": 4.5, "image": "assets/sister.jpg", "address": "Abraj, Beirut", "phone": "+961 1 777 888",
      "desc": "Specialized in fresh wraps and quick meals.",
      "avgCost": "\$4 - \$12",
      "menu": [{"name": "Halloumi Wrap", "price": "4.50"}, {"name": "Tuna Wrap", "price": "5.50"}],
      "reviews": [{"user": "Dina", "rating": 5, "comment": "Fresh and healthy."}]
    },
    {
      "name": "Bonless 28", "category": "Street Food", "rate": 3.2, "image": "assets/28.jpg", "address": "Bliss-Street, Beirut", "phone": "+961 1 888 999",
      "desc": "Street food with creative sandwiches and snacks.",
      "avgCost": "\$6 - \$15",
      "menu": [{"name": "Chicken Box", "price": "9.50"}, {"name": "Curly Fries", "price": "4.00"}],
      "reviews": [{"user": "Samer", "rating": 3, "comment": "Good for late night snacks."}]
    },
    {
      "name": "Timmy", "category": "Street Food", "rate": 3.3, "image": "assets/timmy.jpg", "address": "Gemayze, Beirut", "phone": "+961 1 999 000",
      "desc": "Quick bites and street-style meals popular among students.",
      "avgCost": "\$5 - \$12",
      "menu": [{"name": "Student Burger", "price": "6.00"}, {"name": "Hot Dog", "price": "5.00"}],
      "reviews": [{"user": "Joe", "rating": 3, "comment": "Cheap and cheerful."}]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map> filtered = restaurants.where((rest) {
      if (selectedCategory != "All" && rest["category"] != selectedCategory) return false;
      if (showHighRated && rest["rate"] < 4.0) return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Colors.cyan,
            leading: widget.username != null
                ? IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                );
              },
            )
                : null,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Beirut Restaurants",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset("assets/beirut.jpg", fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.5)),
                ],
              ),
            ),
            actions: [
              if (widget.username == null) ...[
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WelcomePage())),
                  child: const Text("Take Me Back", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                  child: const Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ] else Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Center(child: Text("Hi, ${widget.username}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              )
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("What are you craving today?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["All", "Lebanese", "American", "Italian", "French", "Street Food"]
                          .map((cat) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected: (selected) => setState(() => selectedCategory = cat),
                          selectedColor: Colors.cyan,
                          labelStyle: TextStyle(color: selectedCategory == cat ? Colors.white : Colors.black),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: showHighRated,
                        activeColor: Colors.cyan,
                        onChanged: (val) => setState(() => showHighRated = val!),
                      ),
                      const Text("Show only high rated (4.0+)")
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final r = filtered[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(r["image"], fit: BoxFit.contain),
                      ),
                    ),
                    title: Text(r["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(children: [const Icon(Icons.star, color: Colors.orange, size: 16), const SizedBox(width: 4), Text("${r["rate"]} • ${r["category"]}")]),
                        Text(r["address"], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ItemPage(restaurant: r))),
                  ),
                );
              },
              childCount: filtered.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }
}