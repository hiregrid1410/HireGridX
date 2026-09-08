import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';

class LearningShellPage extends StatefulWidget {
  final Widget child;

  const LearningShellPage({super.key, required this.child});

  @override
  State<LearningShellPage> createState() => _LearningShellPageState();
}

class _LearningShellPageState extends State<LearningShellPage> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/learning/my-learning')) return 1;
    if (location.startsWith('/learning/company-exams')) return 2;
    if (location.startsWith('/learning/placement')) return 3;
    if (location.startsWith('/learning/profile')) return 4;
    return 0; // Default Home / Dashboard
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/learning/home');
        break;
      case 1:
        context.go('/learning/my-learning');
        break;
      case 2:
        context.go('/learning/company-exams');
        break;
      case 3:
        context.go('/learning/placement');
        break;
      case 4:
        context.go('/learning/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceHeader,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.surfaceHeader,
          elevation: 0,
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => _onItemTapped(index, context),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book_rounded),
              label: 'Learning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment_rounded),
              label: 'Exams',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              activeIcon: Icon(Icons.emoji_events_rounded),
              label: 'Placement',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
