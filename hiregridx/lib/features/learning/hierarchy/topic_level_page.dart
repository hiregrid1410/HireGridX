import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';
import '../../../shared/models/data_models.dart';

class TopicLevelPage extends StatelessWidget {
  final String subjectId;

  const TopicLevelPage({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    final subject = MockRepository.subjects.firstWhere(
      (s) => s.id == subjectId,
      orElse: () => HierarchyNode(
        id: subjectId,
        name: 'AC Concepts',
        type: 'subject',
        parentId: 'cat_ee',
        accessType: 'free',
        displayOrder: 1,
      ),
    );

    final topics = MockRepository.getTopicsForSubject(subjectId);

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
                      'Subjects  /  ${subject.name}',
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

              // Subject Title
              Text(
                subject.name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Complete all topic modules below to complete this subject.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),

              // Module Cards List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topics.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  final bool isLocked = topic.accessType == 'premium_only' && !MockRepository.currentUser.isPremium;

                  return HgCard(
                    onTap: () {
                      if (isLocked) {
                        context.push('/learning/plans');
                      } else {
                        context.push('/learning/module/${topic.id}');
                      }
                    },
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isLocked ? const Color(0x33FFE035) : AppColors.primaryGreen.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isLocked ? 'PREMIUM MODULE' : 'PRACTICE MODULE',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: isLocked ? AppColors.accentYellow : AppColors.primaryGreen,
                                ),
                              ),
                            ),
                            Icon(
                              isLocked ? Icons.lock_outline_rounded : Icons.check_circle_outline_rounded,
                              color: isLocked ? AppColors.accentYellow : AppColors.primaryGreen,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          topic.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${topic.moduleCount} Questions • 25 Mins • +150 XP Reward',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Color(0xFF6E7B85),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: AppColors.accentYellow,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '4.8 Rating',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isLocked ? const Color(0xFF182430) : AppColors.primaryGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isLocked ? 'Unlock Plan' : 'Start Module',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isLocked ? AppColors.accentYellow : const Color(0xFF02080D),
                                ),
                              ),
                            ),
                          ],
                        ),
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
