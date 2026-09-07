import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class CompanyExamsPage extends StatefulWidget {
  const CompanyExamsPage({super.key});

  @override
  State<CompanyExamsPage> createState() => _CompanyExamsPageState();
}

class _CompanyExamsPageState extends State<CompanyExamsPage> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredCompanies = MockRepository.companies.where((comp) {
      if (_selectedFilter == 'Free') return comp.accessBadge == 'FREE';
      if (_selectedFilter == 'Unlocked') return comp.accessBadge == 'UNLOCKED';
      if (_selectedFilter == 'Premium') return comp.accessBadge == 'PREMIUM';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Company Exams', style: AppTypography.pageTitle),
              const SizedBox(height: 4),
              Text(
                'Practice Tier-1 company specific test suites and interview prep.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),

              const HgTextField(
                hintText: 'Search target companies (e.g. TCS, Infosys)...',
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 16),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Unlocked', 'Free', 'Premium'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(filter),
                        labelStyle: AppTypography.caption.copyWith(
                          color: isSelected ? AppColors.backgroundDark : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        selectedColor: AppColors.primaryGreen,
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        onSelected: (val) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Company List Grid
              Expanded(
                child: ListView.separated(
                  itemCount: filteredCompanies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final comp = filteredCompanies[index];
                    return HgCard(
                      onTap: () => context.go('/learning/company/${comp.id}'),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              comp.name.substring(0, 1),
                              style: AppTypography.cardTitle.copyWith(
                                color: AppColors.primaryGreen,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(comp.name, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                                    HgAccessBadge(type: comp.accessBadge),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comp.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
