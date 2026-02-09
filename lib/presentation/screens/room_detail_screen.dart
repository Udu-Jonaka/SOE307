import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room? room; // Allow null and use mock default for showcase

  const RoomDetailScreen({super.key, this.room});

  @override
  Widget build(BuildContext context) {
    // Use passed room or default to the first one for the "Room Showcase" HTML 6 matching
    final displayRoom = room ?? MockData.rooms[0];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Column(
        children: [
          // App Bar Area (Custom Overlay)
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 320,
                  pinned: true,
                  backgroundColor: isDark ? const Color(0xFF0F230F).withOpacity(0.9) : Colors.white.withOpacity(0.9),
                  iconTheme: IconThemeData(color: isDark ? Colors.white : const Color(0xFF1E293B)),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          displayRoom.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (c,e,s) => Container(color: Colors.grey),
                        ),
                        // Gradient Overlay
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                        ),
                        // Floating Tag
                        Positioned(
                          top: 40 + 16, // SafeArea approx
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.black87 : Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.circle, size: 8, color: Colors.orange),
                                SizedBox(width: 4),
                                Text(
                                  'Few Left',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                    ),
                  ],
                  title: Row(
                    children: [
                       Container(
                         width: 24, height: 24,
                         decoration: BoxDecoration(
                           color: AppTheme.primaryColor,
                           borderRadius: BorderRadius.circular(6),
                         ),
                         alignment: Alignment.center,
                         child: const Text('F', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                       ),
                       const SizedBox(width: 8),
                       Text('FUTO Reserve', style: TextStyle(color: isDark ? Colors.white : const Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title & Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayRoom.hostelId == '1' ? 'Male Hostel A' : 'Hostel',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Room 204',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₦${displayRoom.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Per Session',
                                  style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        // Tags
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildTag(displayRoom.type, Colors.green),
                            const SizedBox(width: 8),
                            _buildTag('2nd Floor', Colors.blue),
                            const SizedBox(width: 8),
                            _buildTag('Block C', Colors.purple),
                          ],
                        ),
                        
                        const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),
                        
                        // Amenities
                        const Row(
                          children: [
                            Icon(Icons.category, color: AppTheme.primaryColor),
                            SizedBox(width: 8),
                            Text('Amenities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GridView.custom(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),
                          childrenDelegate: SliverChildListDelegate([
                            _buildAmenity(Icons.wifi, 'Free WiFi', context),
                            _buildAmenity(Icons.mode_fan_off, 'Ceiling Fan', context),
                            _buildAmenity(Icons.desk, 'Study Desk', context), // using desk if avail
                            _buildAmenity(Icons.bathtub, 'En-suite', context),
                            _buildAmenity(Icons.bolt, '24/7 Power', context),
                            _buildAmenity(Icons.local_laundry_service, 'Laundry', context),
                            _buildAmenity(Icons.shelves, 'Storage', context), // using shelves
                            _buildSeeAll(context),
                          ]),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Description
                        const Row(
                          children: [
                            Icon(Icons.description, color: AppTheme.primaryColor),
                            SizedBox(width: 8),
                            Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Spacious 4-man room located on the 2nd floor with good ventilation and close proximity to the cafeteria. The room was recently renovated with tiled floors and new window nets.',
                          style: TextStyle(height: 1.5, color: Colors.grey),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Text('Read more'),
                          label: const Icon(Icons.expand_more, size: 16),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        
                        // Map
                        const SizedBox(height: 8),
                        Container(
                          height: 128,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(MockData.mapUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map),
                            label: const Text('View on Campus Map'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100), // Space for fixed bottom bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Bar
          Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F230F) : const Color(0xFFF5F8F5),
              border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Price', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('₦${displayRoom.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking Feature Coming Soon')));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Book Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.shade100),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color.shade700,
        ),
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String label, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSeeAll(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.grey, size: 28),
          SizedBox(height: 8),
          Text(
            'See All',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
