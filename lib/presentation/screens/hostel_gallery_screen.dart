import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import 'hostel_details_screen.dart'; // Navigate to Room List (Screen 5)

class HostelGalleryScreen extends StatelessWidget {
  const HostelGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
             // Logic to go back or log out? 
             // Typically this is the home screen, so maybe no action or exit.
             // HTML has a back button, so I'll include it.
             if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text('Hostel Gallery'),
        actions: [
          // Simulated status bar safe area handled by AppBar automatically
        ],
      ),
      body: Column(
        children: [
          // Brand Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
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
                const SizedBox(height: 8),
                Text(
                  'FEDERAL UNIVERSITY OF TECHNOLOGY, OWERRI',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          // Gallery Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.8, // 4/5 ratio
                 crossAxisSpacing: 16,
                 mainAxisSpacing: 16,
              ),
              itemCount: MockData.hostels.length,
              itemBuilder: (context, index) {
                final hostel = MockData.hostels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HostelDetailsScreen(hostel: hostel),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade800 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                      ),
                      boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.05),
                           blurRadius: 2,
                         ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                hostel.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (c,e,s) => Container(color: Colors.grey.shade300),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(hostel.availabilityStatus).withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    hostel.availabilityStatus,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                 hostel.name,
                                 style: const TextStyle(
                                   color: AppTheme.primaryColor,
                                   fontWeight: FontWeight.w600,
                                   fontSize: 14,
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                               const SizedBox(height: 4),
                               Text(
                                 hostel.wing,
                                 style: TextStyle(
                                   color: Colors.grey.shade400,
                                   fontSize: 12,
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available': return Colors.green;
      case 'Full': return Colors.red;
      case 'Few Spaces': return Colors.orange;
      default: return Colors.grey;
    }
  }
}
