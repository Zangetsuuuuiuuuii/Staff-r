import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UpdatesCarousel extends StatefulWidget {
  final List<String> updates;

  const UpdatesCarousel({super.key, required this.updates});

  @override
  State<UpdatesCarousel> createState() => _UpdatesCarouselState();
}

class _UpdatesCarouselState extends State<UpdatesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late final PageController _indicatorController;

  @override
  void initState() {
    super.initState();
    _indicatorController = _pageController;

    // Auto-scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      int nextPage = _pageController.page!.round() + 1;
      if (nextPage >= widget.updates.length) nextPage = 0;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      _autoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.updates.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active,
                        color: Colors.deepPurple),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.updates[index],
                        style: const TextStyle(fontSize: 13.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _indicatorController,
          count: widget.updates.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.deepPurple,
            dotColor: Colors.deepPurple.shade100,
            dotHeight: 6,
            dotWidth: 6,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }
}
