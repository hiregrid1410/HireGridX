import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';
import '../../../shared/models/data_models.dart';

class SubjectLevelPage extends StatelessWidget {
  final String categoryId;

  const SubjectLevelPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category = MockRepository.categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => HierarchyNode(
        id: categoryId,
        name: 'Electrical Engineering',
        type: 'branch',
        parentId: '',
        accessType: 'free',
        displayOrder: 1,
      ),
    );

    final subjects = MockRepository.getSubjectsForCategory(categoryId);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb & Back header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Learning  /  ${category.name}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title & Subtitle
              Text(
                category.name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Select a subject to view modules and practice questions.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 20),

              // Search field
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1720),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0x1AFFFFFF)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search_rounded, color: Color(0xFF6E7B85), size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Search subjects in this category...',
                          hintStyle: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF6E7B85)),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Subjects Deck List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final subj = subjects[index];
                  return HgCard(
                    onTap: () => context.push('/learning/topic/${subj.id}'),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF142230),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.folder_outlined,
                            color: subj.accessType == 'free' ? AppColors.primaryGreen : AppColors.accentYellow,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      subj.name,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  if (subj.accessType == 'premium_only')
                                    const HgAccessBadge(type: 'PREMIUM')
                                  else
                                    const HgAccessBadge(type: 'FREE'),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${subj.moduleCount} Modules available',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Color(0xFF6E7B85),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: subj.progress,
                                        minHeight: 4,
                                        backgroundColor: const Color(0xFF162534),
                                        color: AppColors.primaryGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${(subj.progress * 100).toInt()}%',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
