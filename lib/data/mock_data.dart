class Hostel {
  final String id;
  final String name;
  final String imageUrl;
  final String wing;
  final String availabilityStatus; // 'Available', 'Full', 'Few Spaces'
  final double startPrice;

  Hostel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.wing,
    required this.availabilityStatus,
    this.startPrice = 0,
  });
}

class Room {
  final String id;
  final String hostelId;
  final String name; // e.g., 'Standard 4-Man'
  final String type; // '4-Man', '2-Man'
  final double price;
  final String period; // '/ session'
  final int capacity;
  final int availableCount;
  final List<String> amenities;
  final String imageUrl;
  final bool isPopular;

  Room({
    required this.id,
    required this.hostelId,
    required this.name,
    required this.type,
    required this.price,
    this.period = '/ session',
    required this.capacity,
    required this.availableCount,
    required this.amenities,
    required this.imageUrl,
    this.isPopular = false,
  });
}

class MockData {
  // Constant assets
  static const String futoLogoUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBWYZgaHkmtujuwJGuhrPArH0LPQ0Ha1bdzul0zFGsyknzJBy3KcA_Cho14OODKx51pR9bYpYAEwo5vuIGsU-ZCSRTiu9Cjwlq1vXrzNSg-KoA3mIn2aCBFyZI5cW_RjcPB8mo18LYDEBVSGgEzoc8UOZZL4XBGbJ_scs_9sXUZZ02c9-1ECZKvHXvDEIzksUS6zCfJY6HUoAJsmsQsQp1xnKn3obbkaDGM8Zex1MYYxyfTpuDTPVdJf3lGQl27zl-GjpZiU7v9qbBx';
  static const String futoLogoGreenUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuAOtiyJ585COyjuuvN1Q09sKF_6GcwZzcCjppq-Jk-PUSZViipasee910MvM-IymMQJNuovS4j1ZxtrW_lSEF5-o94TSL3BTQaVHu0ZxGcX0omXgA_lQ0vgOmOI8b_lQujds8bWMnlnnwCPTiyFaAitVvIAWgrwaYa5FnDpJ6si6dged5313hCri8uMYQ750VeVWeJMPW2pfsodGYFKmfbJ5ukHgM5Kh-h2oHJ7VWFEsMjp27TDCLR4ptjfLHlioMPdPMSmzYA3T2T9';
  static const String mapUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuCZDEJ1Gh6qW6Taj0VLjfkUX48-cqFR_Y43bJbfJl2xBzIWAa_Z3BS1pLWEPB8NueYzRgbmYnXBS21imIvLSqFsNb758tE95Ljf_CVLXGb2_d893ImGCd3nJGKkLbNU5V82V6PKrRVUKnB33DyLIHsuDE6AmlEGTe3fWZwmt3EzEkVIDEysntU4reJ0c_YmaB87cRURkgugBsUW5B8htSJSnAorYEluz0qtQFKo6logzOl67FLNSZvHQhTQfZc_Z8sm-fwbScNPDedC';

  static List<Hostel> hostels = [
    Hostel(
      id: '1',
      name: 'Hostel A',
      wing: 'Male Wing',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBZghYkwSI7klzwawVgtymP4nvMHZTVFNJ0OfVAKh4aBxvFDMBYylstz2GgdfqD2CZndylwZKZ6H7Txq8a_CncCkOZGxh3poO0EN0fO3hoOTtznmQj7M9oE2q7xWoANuSvQ51j2UDY6A2fKmriqM1rWHyjGThAK5uPMnkiuSaeEGD8aYTcNpOhKSIO-9mig-D65WbsYSd3VA_CRXru4WdAxJuAjVT3qwya_LkVxdZo48AC5L_LQageCmQINtYUpTZzu1rfqysndMbZX',
      availabilityStatus: 'Available',
    ),
    Hostel(
      id: '2',
      name: 'Hostel B',
      wing: 'Female Wing',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA9hqiCZd1tmUTdJM_8pm43XmPNLDrFXzVA8DX__0X6rZd6JFYLZRb0U5XXCreRc41N_xpu-PsZeXXdYRalAtBD4k2p421VCvcDNXxfxKFtvKP2A6yT7LELGhCQLmlLFmBh9KniSsNSYOahrQ17xveEy7Vmhbtuhx7LvEtaTLKC4QRDtMupuFPUp6PuPureyzuJAzuma1X47I6o8hYdWQOr2TnQJevp1N5amEfo_pIGxgSl8PgTvIwnnoMV23zXxDq83iFHNzrpJKTZ',
      availabilityStatus: 'Available',
    ),
    Hostel(
      id: '3',
      name: 'Hostel C',
      wing: 'Male Wing',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-PedkTYzsKNUxJQDetB4m4_iM_q5C1Ct11dCvZQ1YMh38v4OhJf9kUGi3FrOPdWShF2DJ9bdBETXkXbmShENqZVm2qVWXMsGbnJx3Z3SK70hS1t8tVgKCVNfNvaNWBKRtAQgjKH7PIsSZp0qi8zEZ7PMXBcDhk8PpLmjyIWaSKOhwYxetYcqplHjOfGWNKDKvpBgcjCJ_GXTSDmu0xmwpaWKEckezymTilBgLohtIkr-u9U9sIFlzbkKmpbI7Ebsn8zQ7X-DBmvHt',
      availabilityStatus: 'Full',
    ),
    Hostel(
      id: '4',
      name: 'Hostel D',
      wing: 'Freshers Only',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDcy-OQ_f90-X_RU_ybKzAYfUoEpA6ELinKqMmu1xaJE0uMLmD-p2ShFQQ-BGd2MPy0iSLJTCal6jnhGoSp3uHM2CkFdzn-UbCfsN5LeSIAiDV35Y4P2BiBCdR5E_RYZJyUv2mesR_l1IedXHB8Bv2uLzw1bY6Cf5MXa4pN1yOp1OP51Wh1_Ri30fza1BahBdZtx3DGpGLxcdpTLG51DoW5X1NPVAhzSjZKsiphAoBxk0xaa3AME6Dxis5giic1JJCAFKxbFJXmhWEY',
      availabilityStatus: 'Available',
    ),
    Hostel(
      id: '5',
      name: 'Hostel E',
      wing: 'Mixed Wing',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwh0GIvlA0EzA14prEDZQQNOAmvuqzMWg-fhi0RdXg8pm6NWkldNTleDC4HpV7SW8l8VrtjJcgzoViaXWPtkRibdgLuvHkA60uqkVlCMrMG4M_OD5G-tmVjpVssaInVT7MKWfjSj0iwsqhjOHkfgdmDqZGD9Q4tGi-4eRzOd2CmAq-vnR9D-miysZcQLwUiNZ7h__zKGFhu2M5-6b0rM4TyVKyGcM4gFhKh6qCWnQYYgsey5a6MItVOE-0djAiWbuK5YLOLlxWM-7G',
      availabilityStatus: 'Few Spaces',
    ),
    Hostel(
      id: '6',
      name: 'NDDC Hostel',
      wing: 'Premium',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCWYWInuiAmNUaaV5aetxlbh3rBjOBbmqhVw7r-dftOIIfLoOL64-BSTs-FRAlYY8p2eDq4w35Puelxn2xutM3vT66XlnJ047Hf_Z_SI73Djl_yuIfwx-gfZ6wxLnoWTj2Zk_ci9iuaBbNWdVVo6N5PzgPeYea17v659_UTn9uTbyRRCJhKInUk6Pr94lK3EWJFQ017EghGn2u_TbT-bQvLqlTFbOjAW4ie8ab_H9Sc4riu2NmlYFlUEJvxhx6KaFGB0Iw08wIYsDyQ',
      availabilityStatus: 'Available',
    ),
  ];

  static List<Room> rooms = [
    Room(
      id: '1',
      hostelId: '1',
      name: 'Standard 4-Man',
      type: '4-Man',
      price: 25000,
      capacity: 4,
      availableCount: 5,
      amenities: ['WiFi', 'Fan', 'Desk'],
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDNfiEvNDs0lvXotNm0cwJAIeW-mRRnx10TZzBqQdXXzP3YwauQtdtw8EdZVzSos5WfivnF_OZT2sNlc9_yU7rQigj8WMXAMFb4xtaVdVky7MHMyR7fcz7VloTsL3ayB4DGy3f6T5s0ETX7Lw0PFx-EejZcsFugECDFdGCgcJr5x8cVpc6NtKmREyQaEB6zIlXhyICCxDvzbb2UVfABHBliUcz0-gYylrTC0OzRBvhv8Li56gNSnjctK3VFZw9OccYOinlBY74Qb-ih',
      isPopular: true,
    ),
    Room(
      id: '2',
      hostelId: '1',
      name: 'Premium 2-Man',
      type: '2-Man',
      price: 45000,
      capacity: 2,
      availableCount: 2,
      amenities: ['A/C', 'Ensuite'],
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBm9fh72Ua-eKXtgj4uVBiWph-4xNxhR_4K1UYI8GtraAJFwSOtt0m5J34az7ixlVq3CGgR7rByGzjcKjT1ZatDnwDRc552fJ0Aa6pO4IuEG9sXzvJshxlWJf4J3S1p2d_KnbAk5Hs2Lp16k0x45LedRlNtpR0RtYnq7rz1yXQxZ2T40lJQFx1vm77XlxDOtezV0hvzHT0I518lU0Ti_X7phCtC3rJMWGYXLp7XRsvrfMZJ-1_9YfvaSB221ROfPvSnpt9UsleFFTcc',
      isPopular: false,
    ),
    Room(
      id: '3',
      hostelId: '1',
      name: 'Executive Single',
      type: 'Special',
      price: 120000,
      capacity: 1,
      availableCount: 0,
      amenities: ['All Included'],
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDznTlJZ_Gs7KtHVGo4MD3tfiWLZi4KGL-WAe4JNRgfmkQ1MUYukXzOW-XK9uXYaPn187aC0wjg6ILSaIySEJxnMl0VVF8t4f3HCXbT2ZHs830ZKIUulptZTBbNxg6yQRTriP6jOdSCpaelBvXEZdwEnWSIxMh4LYADHWhkzB3B1dXl4J47V0dfc60zEq4Uhqy0aDyXCH4N8Asdz28qjhZcNm7p4TG3n4BwPZxvbpBJPi_35fTA4bZxvaF1CAbysAvmOqh7bfGk9eg1',
      isPopular: false,
    ),
  ];
  
  static List<String> floors = ['All Rooms', '4-Man', '2-Man', 'Special'];
}
