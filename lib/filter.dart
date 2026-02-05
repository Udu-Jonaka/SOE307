import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FilterPage(),
    );
  }
}

class Room {
  final String name;
  final String category;
  final String price;
  final String image;

  Room(this.name, this.category, this.price, this.image);
}

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedFilter = "All";
  String searchQuery = "";

  final List<String> filters = [
    "All",
    "Deluxe - 84k",
    "Premier - 42k",
    "Economy - 21k",
  ];

  final List<Room> rooms = [
    Room("Deluxe Room 1", "Deluxe", "84k", "assets/deluxe-hostel.jpg"),
    Room("Deluxe Room 2", "Deluxe", "84k", "assets/deluxe-hostel.jpg"),
    Room("Premier Room 1", "Premier", "42k", "assets/premier-hostel.jpg"),
    Room("Premier Room 2", "Premier", "42k", "assets/premier-hostel.jpg"),
    Room("Premier Room 3", "Premier", "42k", "assets/premier-hostel.jpg"),
    Room("Premier Room 4", "Premier", "42k", "assets/premier-hostel.jpg"),
    Room("Economy Room 1", "Economy", "21k", "assets/economy-hostel.jpg"),
    Room("Economy Room 2", "Economy", "21k", "assets/economy-hostel.jpg"),
    Room("Economy Room 3", "Economy", "21k", "assets/economy-hostel.jpg"),
    Room("Economy Room 4", "Economy", "21k", "assets/economy-hostel.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRooms = rooms.where((room) {
      final matchesFilter = selectedFilter == "All"
          ? true
          : selectedFilter.startsWith(room.category);

      final matchesSearch =
          room.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          room.category.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine columns based on screen width
              int crossAxisCount;
              double imageHeight;
              double childAspectRatio;

              if (constraints.maxWidth >= 900) {
                crossAxisCount = 3; // 3 columns for large screens
                imageHeight = 140; // reduced image height
                childAspectRatio = 1.4; // reduce overall container height
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 2; // 2 columns for medium screens
                imageHeight = 160;
                childAspectRatio = 1.02;
              } else {
                crossAxisCount = 1; // 1 column for small screens
                imageHeight = 180;
                childAspectRatio = 1.6;
              }

              final isMobile = crossAxisCount == 1;

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 16,
                  ),
                  child: Column(
                    children: [
                      /// LOGO
                      SizedBox(
                        height: isMobile ? 60 : 80,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: isMobile ? 12 : 20),

                      /// SEARCH + FILTER
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Select room type",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedFilter,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.filter_list),
                              items: filters.map((filter) {
                                return DropdownMenuItem(
                                  value: filter,
                                  child: Text(filter),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedFilter = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isMobile ? 12 : 20),

                      /// RESULTS
                      Expanded(
                        child: filteredRooms.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.search_off,
                                      size: 36,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "No results found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Try a different room type or search term",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            : GridView.builder(
                                itemCount: filteredRooms.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: childAspectRatio,
                                    ),
                                itemBuilder: (context, index) {
                                  final room = filteredRooms[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        6,
                                        6,
                                        6,
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ROOM IMAGE
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: imageHeight,
                                              child: Image.asset(
                                                room.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          Text(
                                            room.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(height: 2),

                                          Text(
                                            "${room.category} • ${room.price}",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          const Spacer(),

                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Text("Book Now"),
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                    ),
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
