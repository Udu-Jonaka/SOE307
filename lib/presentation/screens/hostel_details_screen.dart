import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import 'room_detail_screen.dart'; // Navigate to Room Detail (Screen 6)

// This Screen matches HTML 5 (Room Selection / Hostel Details)
class HostelDetailsScreen extends StatefulWidget {
  final Hostel hostel;

  const HostelDetailsScreen({super.key, required this.hostel});

  @override
  State<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  String _selectedFilter = 'All Rooms';
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    _rooms = MockData.rooms; // In real app, filter by hostelId
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Filter logic (mock)
    final filteredRooms = _selectedFilter == 'All Rooms' 
        ? _rooms 
        : _rooms.where((r) => r.type == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/futo_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Text('FUTO', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: isDark ? const Color(0xFF0F2323) : const Color(0xFFF5F8F5),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : const Color(0xFF0C1D0C)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: isDark ? Colors.white : const Color(0xFF0C1D0C)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Context Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.hostel.name} • ${widget.hostel.wing}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFFA3BBA3) : const Color(0xFF4B5C4B),
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Select Room',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xFFE6F4E6) : const Color(0xFF0C1D0C),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: MockData.floors.map((filter) {
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedFilter = filter);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : (isDark ? const Color(0xFF162E16) : Colors.white),
                        borderRadius: BorderRadius.circular(50),
                        border: isSelected ? null : Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
                        boxShadow: isSelected 
                           ? [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))]
                           : null,
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : (isDark ? const Color(0xFFA3BBA3) : const Color(0xFF4B5C4B)),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Room List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: filteredRooms.length,
              separatorBuilder: (c, i) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final room = filteredRooms[index];
                return GestureDetector(
                  onTap: () {
                     // Normally selects logic, but here we go to Showcase (Screen 6)
                     Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) => RoomDetailScreen(room: room)),
                     );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF162E16) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        // Image
                        Container(
                          height: 200, // aspect 4/3 rough approx
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(room.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: room.isPopular ? Stack(
                            children: [
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.black87 : Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.bolt, size: 16, color: AppTheme.primaryColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        'POPULAR',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : const Color(0xFF0C1D0C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ) : null,
                        ),
                        
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? const Color(0xFFE6F4E6) : const Color(0xFF0C1D0C),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: room.amenities.map((a) => Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: isDark ? Colors.white10 : Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(_getAmenityIcon(a), size: 14, color: isDark ? const Color(0xFFA3BBA3) : const Color(0xFF4B5C4B)),
                                                const SizedBox(width: 4),
                                                Text(
                                                  a,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark ? const Color(0xFFA3BBA3) : const Color(0xFF4B5C4B),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₦${(room.price / 1000).toStringAsFixed(0)}k',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        room.period,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark ? const Color(0xFFA3BBA3) : const Color(0xFF4B5C4B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Divider(color: isDark ? Colors.white10 : Colors.grey.shade100, height: 1),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            room.availableCount > 0 ? Icons.timelapse : Icons.error_outline,
                                            size: 14,
                                            color: _getStockColor(room.availableCount),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            room.availableCount > 0 ? '${room.availableCount} rooms left' : 'Unavailable',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: _getStockColor(room.availableCount),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: 100,
                                        child: LinearProgressIndicator(
                                          value: room.availableCount / 10.0, // Mock progress
                                          color: _getStockColor(room.availableCount),
                                          backgroundColor: isDark ? Colors.white10 : Colors.grey.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: room.availableCount > 0 ? () {
                                       Navigator.of(context).push(
                                         MaterialPageRoute(builder: (context) => RoomDetailScreen(room: room)),
                                       );
                                    } : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryColor,
                                      disabledBackgroundColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                    ),
                                    child: Text(
                                      room.availableCount > 0 ? 'Select' : 'Full',
                                      style: TextStyle(
                                        color: room.availableCount > 0 ? Colors.white : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
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

  IconData _getAmenityIcon(String name) {
    if (name.contains('WiFi')) return Icons.wifi;
    if (name.contains('Fan')) return Icons.mode_fan_off;
    if (name.contains('Desk')) return Icons.desk; // Check if available, fallback below
    if (name.contains('A/C')) return Icons.ac_unit;
    if (name.contains('Ensuite')) return Icons.shower;
    return Icons.check_circle_outline;
  }

  Color _getStockColor(int count) {
    if (count == 0) return Colors.grey;
    if (count < 3) return Colors.red;
    return Colors.orange;
  }
}
