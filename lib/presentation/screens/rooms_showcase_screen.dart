import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../widgets/futo_header.dart';

class RoomsShowcaseScreen extends StatefulWidget {
  final Hostel hostel;

  const RoomsShowcaseScreen({super.key, required this.hostel});

  @override
  State<RoomsShowcaseScreen> createState() => _RoomsShowcaseScreenState();
}

class _RoomsShowcaseScreenState extends State<RoomsShowcaseScreen> {
  String _selectedFloor = 'Floor 1';
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    _filterRooms();
  }

  void _filterRooms() {
    setState(() {
      _rooms = MockData.getRoomsForHostel(widget.hostel.id)
          .where((room) => room.floor == _selectedFloor)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.hostel.name} Rooms'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const FutoHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Text('Filter by: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFloor,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    items: MockData.floors.map((floor) {
                      return DropdownMenuItem(
                        value: floor,
                        child: Text(floor),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedFloor = value;
                          _filterRooms();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _rooms.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.meeting_room_outlined, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'No rooms available on $_selectedFloor',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _rooms.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final room = _rooms[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: room.isAvailable ? Colors.green.shade50 : Colors.red.shade50,
                            child: Icon(
                              Icons.bed,
                              color: room.isAvailable ? AppTheme.primaryColor : Colors.red,
                            ),
                          ),
                          title: Text(
                            'Room ${room.roomNumber}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Capacity: ${room.capacity} Students'),
                          trailing: room.isAvailable
                              ? ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Selected Room ${room.roomNumber}')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    minimumSize: const Size(0, 36),
                                  ),
                                  child: const Text('Select'),
                                )
                              : const Chip(
                                  label: Text('Full'),
                                  backgroundColor: Colors.grey,
                                  labelStyle: TextStyle(color: Colors.white),
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
