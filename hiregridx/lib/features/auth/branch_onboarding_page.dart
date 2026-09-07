import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/widgets/common_widgets.dart';

class BranchOnboardingPage extends StatefulWidget {
  const BranchOnboardingPage({super.key});

  @override
  State<BranchOnboardingPage> createState() => _BranchOnboardingPageState();
}

class _BranchOnboardingPageState extends State<BranchOnboardingPage> {
  String _selectedBranch = 'Computer Science';

  final List<Map<String, String>> _branches = [
    {'name': 'Computer Science', 'desc': 'DSA, Web Dev, OS, DBMS & AI'},
    {'name': 'Information Technology', 'desc': 'Cloud, Networks, Software Engg'},
    {'name': 'Mechanical Engineering', 'desc': 'Thermodynamics, CAD, Robotics'},
    {'name': 'Electrical Engineering', 'desc': 'Power Systems, Circuits, Control'},
    {'name': 'Electronics & Communication', 'desc': 'Embedded, VLSI, Telecom'},
    {'name': 'Civil Engineering', 'desc': 'Structures, Surveying, CAD'},
    {'name': 'MCA', 'desc': 'Advanced Computing & Software Apps'},
    {'name': 'MBA', 'desc': 'Management, Finance & Business Analytics'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text('Choose Your Branch', style: AppTypography.display),
              const SizedBox(height: 8),
              Text(
                'We\'ll customize your prep roadmap, assessment modules, and placement tracks.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 20),

              const HgTextField(
                hintText: 'Search specializations...',
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.separated(
                  itemCount: _branches.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _branches[index];
                    final isSelected = _selectedBranch == item['name'];

                    return HgCard(
                      onTap: () {
                        setState(() {
                          _selectedBranch = item['name']!;
                        });
                      },
                      border: isSelected
                          ? Border.all(color: AppColors.primaryGreen, width: 2)
                          : Border.all(color: AppColors.border),
                      backgroundColor: isSelected
                          ? AppColors.primaryGreen.withOpacity(0.08)
                          : AppColors.surface,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryGreen.withOpacity(0.2)
                                  : AppColors.surfaceElevated,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.school_outlined,
                              color: isSelected ? AppColors.primaryGreen : AppColors.textMuted,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']!,
                                  style: AppTypography.cardTitle.copyWith(
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['desc']!,
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primaryGreen,
                              size: 24,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              HgPrimaryButton(
                text: 'Continue to Dashboard',
                onPressed: () {
                  context.go('/gateway');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
