import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';

class BranchSwitchPage extends StatefulWidget {
  const BranchSwitchPage({super.key});

  @override
  State<BranchSwitchPage> createState() => _BranchSwitchPageState();
}

class _BranchSwitchPageState extends State<BranchSwitchPage> {
  String _selectedBranch = 'Computer Science Engineering';

  final List<String> _branches = [
    'Computer Science Engineering',
    'Electrical Engineering',
    'Electronics & Communication Engineering',
    'Information Technology',
    'Mechanical Engineering',
    'Civil Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Select Academic Branch',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'Choosing your branch customizes your subject hierarchy and placement prep syllabus.',
                style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: AppColors.textMuted),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  itemCount: _branches.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final branch = _branches[index];
                    final bool isSelected = _selectedBranch == branch;

                    return HgCard(
                      onTap: () {
                        setState(() {
                          _selectedBranch = branch;
                        });
                      },
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: isSelected ? AppColors.primaryGreen : const Color(0xFF6E7B85),
                            size: 20,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              branch,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              HgPrimaryButton(
                text: 'Confirm Branch Change',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Branch updated to $_selectedBranch'),
                      backgroundColor: AppColors.primaryGreen,
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
