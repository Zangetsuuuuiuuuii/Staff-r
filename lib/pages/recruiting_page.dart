import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/category_card.dart';
import '../pages/job_listing_page.dart';

class RecruitingPage extends StatefulWidget {
  const RecruitingPage({super.key});

  @override
  State<RecruitingPage> createState() => _RecruitingPageState();
}

class _RecruitingPageState extends State<RecruitingPage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<String> bannerImages = [
    'assets/banners/banner1.jpg',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.jpg',
  ];

  final Map<String, List<Map<String, dynamic>>> groupedCategories = {
    "Top Services": [
      {"title": "Security Guards", "icon": Icons.security},
      {"title": "Cleaners", "icon": Icons.cleaning_services},
      {"title": "Babysitters", "icon": Icons.child_friendly},
      {"title": "Drivers", "icon": Icons.directions_car},
      {"title": "Nurses", "icon": Icons.local_hospital},
      {"title": "Tutors", "icon": Icons.school},
    ],
    "Home & Domestic Services": [
      {"title": "Security Guards", "icon": Icons.security},
      {"title": "Housemaids & Cleaners", "icon": Icons.cleaning_services},
      {"title": "Babysitters & Nannies", "icon": Icons.child_friendly},
      {"title": "Cooks & Chefs", "icon": Icons.restaurant},
      {"title": "Gardeners", "icon": Icons.grass},
    ],
    "Driving & Transportation": [
      {"title": "Personal Drivers", "icon": Icons.directions_car},
      {"title": "Delivery Riders", "icon": Icons.delivery_dining},
      {"title": "Chauffeurs", "icon": Icons.emoji_transportation},
    ],
    "Healthcare & Personal Care": [
      {"title": "Nurses & Caregivers", "icon": Icons.local_hospital},
      {"title": "Elderly Care", "icon": Icons.elderly},
      {"title": "Physiotherapists", "icon": Icons.healing},
      {"title": "Pet Sitters & Groomers", "icon": Icons.pets},
    ],
    "Office & Admin": [
      {"title": "Receptionists", "icon": Icons.receipt_long},
      {"title": "Cashiers", "icon": Icons.attach_money},
      {"title": "Office Assistants", "icon": Icons.work_outline},
    ],
    "Event & Hospitality": [
      {"title": "Waiters & Bartenders", "icon": Icons.room_service},
      {"title": "Event Staff", "icon": Icons.emoji_events},
      {"title": "Hotel Housekeeping", "icon": Icons.king_bed},
    ],
    "Education & Tutoring": [
      {"title": "Private Tutors", "icon": Icons.school},
      {"title": "Exam Preparation Coaches", "icon": Icons.menu_book},
      {"title": "Special Education Tutors", "icon": Icons.psychology},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            backgroundColor: theme.colorScheme.primary,
            expandedHeight: 0,
            title: Text(
              "TempStaffing",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),

          // Banner Carousel
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: bannerImages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(bannerImages[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerImages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 10 : 6,
                      height: _currentPage == index ? 10 : 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? theme.colorScheme.primary
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for a service...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Promo Banner Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.verified, size: 40, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hire Verified Professionals",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Top-rated, ID-verified staff in your area.",
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Category Cards Section
          ...groupedCategories.entries.map((entry) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: entry.value.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final item = entry.value[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    JobListingPage(jobTitle: item['title']),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item['icon'], size: 32, color: Colors.indigo),
                                const SizedBox(height: 8),
                                Text(
                                  item['title'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
