import 'package:flutter/material.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  bool showHighRated = false;

  List<Map> restaurants = [

    {
      "name": "Barbar",
      "category": "Lebanese",
      "rate": 4.6,
      "image": "assets/barbar.jpg",
      "address": "Hamra, Beirut",
      "phone": "+961 1 753 330",
      "desc": "Famous Lebanese fast-food restaurant known for shawarma, sandwiches, and grills."
    },
    {
      "name": "Hawa Beirut",
      "category": "Lebanese",
      "rate": 4.0,
      "image": "assets/hawa.jpg",
      "address": "DownTown, Beirut",
      "phone": "+961 1 123 456",
      "desc": "Traditional Lebanese cuisine in a cozy atmosphere."
    },
    {
      "name": "Al Beiruti",
      "category": "Lebanese",
      "rate": 4.3,
      "image": "assets/beiruti.jpg",
      "address": "DownTown, Beirut",
      "phone": "+961 1 234 567",
      "desc": "Authentic Lebanese flavors with family-friendly service."
    },
    {
      "name": "Beit Halab",
      "category": "Lebanese",
      "rate": 4.1,
      "image": "assets/halab.jpg",
      "address": "Ain-Mreiseh, Beirut",
      "phone": "+961 1 345 678",
      "desc": "Famous for traditional Levantine dishes and sweets."
    },
    {
      "name": "Loris",
      "category": "Lebanese",
      "rate": 3.5,
      "image": "assets/loris.jpg",
      "address": "Hamra, Beirut",
      "phone": "+961 1 456 789",
      "desc": "Casual Lebanese restaurant serving fresh shawarma and mezzes."
    },


    {
      "name": "Roadster Diner",
      "category": "American",
      "rate": 4.5,
      "image": "assets/roadster.jpg",
      "address": "ABC-Verdun, Beirut",
      "phone": "+961 1 791 111",
      "desc": "Popular diner offering burgers, fries, salads, and desserts."
    },
    {
      "name": "The Goat",
      "category": "American",
      "rate": 2.4,
      "image": "assets/goat.jpg",
      "address": "Hamra, Beirut",
      "phone": "+961 1 567 890",
      "desc": "Modern American cuisine with gourmet burgers and sides."
    },
    {
      "name": "Cheese On Top",
      "category": "American",
      "rate": 4.6,
      "image": "assets/cheese.jpg",
      "address": "Bliss Street, Beirut",
      "phone": "+961 1 678 901",
      "desc": "Specializes in cheesy dishes and comfort food classics."
    },


    {
      "name": "Mamma In Cucina",
      "category": "Italian",
      "rate": 4.5,
      "image": "assets/mama.jpg",
      "address": "Achrafieh, Beirut",
      "phone": "+961 1 789 012",
      "desc": "Homemade Italian pasta, pizza, and classic dishes."
    },
    {
      "name": "Vicoli",
      "category": "Italian",
      "rate": 4.4,
      "image": "assets/vicoli.jpg",
      "address": "Hamra, Beirut",
      "phone": "+961 1 890 123",
      "desc": "Traditional Italian flavors with cozy ambiance."
    },
    {
      "name": "Pertutti",
      "category": "Italian",
      "rate": 3.8,
      "image": "assets/pertutti.jpg",
      "address": "Mar-Takla, Beirut",
      "phone": "+961 1 901 234",
      "desc": "Authentic Italian cuisine with wood-fired pizza."
    },
    {
      "name": "Squisito",
      "category": "Italian",
      "rate": 4.2,
      "image": "assets/squisto.jpg",
      "address": "Achrafieh, Beirut",
      "phone": "+961 1 012 345",
      "desc": "Fine Italian dining with pasta and dessert specialties."
    },


    {
      "name": "Le Petit Gris",
      "category": "French",
      "rate": 4.5,
      "image": "assets/lepetit.jpg",
      "address": "Gemayze, Beirut",
      "phone": "+961 1 111 222",
      "desc": "Classic French bistro serving delicious French cuisine."
    },
    {
      "name": "Entre-Deux",
      "category": "French",
      "rate": 3.4,
      "image": "assets/entre.jpg",
      "address": "Mar-Mekhaiel, Beirut",
      "phone": "+961 1 222 333",
      "desc": "Charming French restaurant with fine dining experience."
    },
    {
      "name": "L'Autre Bistro",
      "category": "French",
      "rate": 3.5,
      "image": "assets/latu.jpg",
      "address": "Achrafieh, Beirut",
      "phone": "+961 1 333 444",
      "desc": "Cozy bistro serving classic French dishes."
    },
    {
      "name": "Plume La Brasserie",
      "category": "French",
      "rate": 4.2,
      "image": "assets/plume.jpg",
      "address": "Hamra, Beirut",
      "phone": "+961 1 444 555",
      "desc": "Brasserie with authentic French meals and pastries."
    },
    {
      "name": "Lezard Noir",
      "category": "French",
      "rate": 4.3,
      "image": "assets/lezard.jpg",
      "address": "Beirut-Souks, Beirut",
      "phone": "+961 1 555 666",
      "desc": "Upscale French dining with modern presentation."
    },


    {
      "name": "Eddys",
      "category": "Street Food",
      "rate": 4.5,
      "image": "assets/eddys.jpg",
      "address": "Abraj, Beirut",
      "phone": "+961 1 666 777",
      "desc": "Fast and tasty street food including sandwiches and wraps."
    },
    {
      "name": "Sisters Wrap",
      "category": "Street Food",
      "rate": 4.5,
      "image": "assets/sister.jpg",
      "address": "Abraj, Beirut",
      "phone": "+961 1 777 888",
      "desc": "Specialized in fresh wraps and quick meals."
    },
    {
      "name": "Bonless 28",
      "category": "Street Food",
      "rate": 3.2,
      "image": "assets/28.jpg",
      "address": "Bliss-Street, Beirut",
      "phone": "+961 1 888 999",
      "desc": "Street food with creative sandwiches and snacks."
    },
    {
      "name": "Timmy",
      "category": "Street Food",
      "rate": 3.3,
      "image": "assets/timmy.jpg",
      "address": "Gemayze, Beirut",
      "phone": "+961 1 999 000",
      "desc": "Quick bites and street-style meals popular among students."
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

      appBar: AppBar(
        toolbarHeight: 300,
        centerTitle: true,
        title: const Text(
          "Beirut Restaurants Suggester",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/beirut.jpg"),
              fit: BoxFit.cover,
                alignment: Alignment.topCenter,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Please choose your food type",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),





          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: ["All", "Lebanese", "American", "Italian", "French", "Street Food"]
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Checkbox(
                  value: showHighRated,
                  onChanged: (val) {
                    setState(() => showHighRated = val!);
                  },
                ),
                const Text("Show only restaurants rated 4.0+"),
              ],
            ),
          ),


          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final r = filtered[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            r["image"],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r["name"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 18),
                                  const SizedBox(width: 4),
                                  Text(r["rate"].toString()),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ItemPage(restaurant: r),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Show Description"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
