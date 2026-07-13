import 'package:flutter/material.dart';

class OnboardingData {
  final String image, title, desc;
  OnboardingData(this.image, this.title, this.desc);
}

final onboardingPages = [
  OnboardingData('assets/images/on1.png', 'The Price Of Excellence\nIs Discipline',
      'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus, Mauris Massa'),
  OnboardingData('assets/images/on2.png', 'Fitness Has Never Been So\nMuch Fun',
      'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus, Mauris Massa'),
  OnboardingData('assets/images/on3.png', 'NO MORE EXCUSES\nDo It Now',
      'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus, Mauris Massa'),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const bg = Color(0xFF17130F);
  static const orange = Color(0xFFE8642C);

  void _next() {
    if (_index == onboardingPages.length - 1) {
      // TODO: navigate to Login/Home
      return;
    }
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _back() {
    if (_index == 0) return;
    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingPages.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => _Page(data: onboardingPages[i]),
            ),

            // Skip
            if (!isLast)
              Positioned(
                top: 8,
                right: 16,
                child: TextButton(
                  onPressed: () {}, // TODO: skip to last page / navigate away
                  child: const Text('Skip', style: TextStyle(color: Colors.white70)),
                ),
              ),

            // Dots + buttons
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingPages.length,
                          (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 6,
                        width: _index == i ? 18 : 6,
                        decoration: BoxDecoration(
                          color: _index == i ? orange : Colors.white24,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _index == 0
                          ? const SizedBox(width: 80)
                          : OutlinedButton(
                        onPressed: _back,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white38),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        ),
                        child: Text(isLast ? 'DO IT' : 'Next'),
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
  }
}

class _Page extends StatelessWidget {
  final OnboardingData data;
  const _Page({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 140),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(data.image, fit: BoxFit.cover),
            Positioned(
              left: 0, right: 0, bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.title,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3)),
                    const SizedBox(height: 8),
                    Text(data.desc,
                        style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}