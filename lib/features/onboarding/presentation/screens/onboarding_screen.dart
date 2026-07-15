import 'package:fitnies/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/onboarding_notifier.dart';

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

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next(){
    if (_index == onboardingPages.length - 1){
      context.go(LoginRoute.path);
      return;
    }
      _controller.nextPage(duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);

  }
  Future<void> _finish() async{
    await ref.read(onboardingNotifierProvider.notifier).complete();
    if(mounted) {
      context.go(LoginRoute.path);
    }
  }

  void _back() {
    if (_index == 0) return;
    _controller.previousPage(duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut);
  }

  void _skip() {
    _controller.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              physics: const PageScrollPhysics(),
              itemCount: onboardingPages.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => _Page(
                data: onboardingPages[i],
                index: _index,
                total: onboardingPages.length,
                onSkip: _skip,
                onBack: _back,
                onNext: _next,
                onFinish: _finish,

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
  final int index, total;
  final VoidCallback onSkip, onBack, onNext, onFinish;

  const _Page({
    required this.data,
    required this.index,
    required this.total,
    required this.onSkip,
    required this.onBack,
    required this.onNext,
    required this.onFinish
  });

  // static const orange = Color(0xFFE8642C);

  @override
  Widget build(BuildContext context) {
    final isLast = index == total - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // full-bleed background image
            Image.asset(data.image, fit: BoxFit.cover),

            if (!isLast)
              Positioned(
                top: 12,
                right: 12,
                child: TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black38,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  ),
                  child: const Text('Skip', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

            // text block overlaid at bottom — solid background, no gradient
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                color: const Color(0xE6120E0B), // solid-ish dark bg, slight transparency
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.3)),
                    const SizedBox(height: 6),
                    Text(data.desc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5, height: 1.4)),
                    const SizedBox(height: 14),

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          total,
                              (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: 5,
                            width: index == i ? 16 : 5,
                            decoration: BoxDecoration(
                              color: index == i ? AppColors.orange : Colors.white38,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        if (index != 0) ...[
                          OutlinedButton(
                            onPressed: onBack,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white54),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            ),
                            child: const Text('Back', style: TextStyle(fontSize: 13)),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              isLast ? onFinish() : onNext();

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(isLast ? 'DO IT' : 'Next',
                                style: const TextStyle(fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
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