import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';

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
    return 0; // Default Home
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school, size: 18, color: AppColors.primaryGreen),
            ),
            const SizedBox(width: 8),
            const Text('Learning', style: AppTypography.sectionHeader),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Switch Space',
            icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.primaryGreen),
            onPressed: () => context.go('/gateway'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined),
            activeIcon: Icon(Icons.account_tree_rounded),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            activeIcon: Icon(Icons.business_center_rounded),
            label: 'Companies',
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
    );
  }
}
