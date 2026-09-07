import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/models/data_models.dart';
import '../../../shared/mock_data/mock_repository.dart';

class MyLearningPage extends StatefulWidget {
  const MyLearningPage({super.key});

  @override
  State<MyLearningPage> createState() => _MyLearningPageState();
}

class _MyLearningPageState extends State<MyLearningPage> {
  String? _selectedSubjectId;
  String? _selectedTopicId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Learning', style: AppTypography.pageTitle),
              const SizedBox(height: 4),
              Text(
                'Explore your academic curriculum and skill roadmap.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Breadcrumb Navigation
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedSubjectId = null;
                          _selectedTopicId = null;
                        });
                      },
                      child: Text(
                        'CSE BRANCH',
                        style: AppTypography.caption.copyWith(
                          color: _selectedSubjectId == null
                              ? AppColors.primaryGreen
                              : AppColors.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_selectedSubjectId != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('/', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTopicId = null;
                          });
                        },
                        child: Text(
                          _getSubjectName(_selectedSubjectId!),
                          style: AppTypography.caption.copyWith(
                            color: _selectedTopicId == null
                                ? AppColors.primaryGreen
                                : AppColors.textMuted,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (_selectedTopicId != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('/', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      ),
                      Text(
                        'TREES & GRAPHS',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Content View Switch
              Expanded(
                child: _selectedTopicId != null
                    ? _buildModulesView()
                    : _selectedSubjectId != null
                        ? _buildTopicsView()
                        : _buildSubjectsView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSubjectName(String id) {
    final subj = MockRepository.subjects.firstWhere((s) => s.id == id, orElse: () => MockRepository.subjects.first);
    return subj.name.toUpperCase();
  }

  // Level 1: Subjects List
  Widget _buildSubjectsView() {
    return ListView.separated(
      itemCount: MockRepository.subjects.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = MockRepository.subjects[index];
        return HgCard(
          onTap: () {
            setState(() {
              _selectedSubjectId = item.id;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HgAccessBadge(type: item.accessType == 'free' ? 'FREE' : 'PREMIUM'),
                  Text('${item.moduleCount} Modules', style: AppTypography.caption),
                ],
              ),
              const SizedBox(height: 12),
              Text(item.name, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: item.progress,
                backgroundColor: AppColors.surfaceElevated,
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${(item.progress * 100).toInt()}% Completed', style: AppTypography.caption),
                  const Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryGreen),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Level 2: Topics List
  Widget _buildTopicsView() {
    final topics = MockRepository.getTopicsForSubject(_selectedSubjectId!);

    return ListView.separated(
      itemCount: topics.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = topics[index];
        final isLocked = item.accessType == 'premium_only' && !MockRepository.currentUser.isPremium;

        return HgCard(
          onTap: () {
            if (isLocked) {
              context.go('/learning/plans');
            } else {
              setState(() {
                _selectedTopicId = item.id;
              });
            }
          },
          backgroundColor: isLocked ? const Color(0xFF14151C) : AppColors.surface,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLocked
                      ? AppColors.accentYellow.withOpacity(0.15)
                      : AppColors.primaryGreen.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLocked ? Icons.lock_outline : Icons.folder_open,
                  color: isLocked ? AppColors.accentYellow : AppColors.primaryGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.name, style: AppTypography.cardTitle)),
                        HgAccessBadge(type: isLocked ? 'PREMIUM' : 'FREE'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${item.moduleCount} Assessment Modules', style: AppTypography.caption),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Level 3: Modules / Exam List
  Widget _buildModulesView() {
    final exam = MockRepository.dsaTreesExam;

    return ListView(
      children: [
        HgCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HgBadge(label: 'ASSESSMENT', color: Color(0x3322E573), textColor: AppColors.primaryGreen),
                  HgAccessBadge(type: exam.accessType),
                ],
              ),
              const SizedBox(height: 12),
              Text(exam.title, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
              const SizedBox(height: 8),
              Text(
                'Includes Binary Tree traversals, BST properties, search complexity, and balance factor checks.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildExamMetaInfo(Icons.help_outline, '${exam.questions.length} Questions'),
                  _buildExamMetaInfo(Icons.timer_outlined, '${exam.timeLimitMinutes} Mins'),
                  _buildExamMetaInfo(Icons.grade_outlined, '${exam.passPercentage}% Pass'),
                ],
              ),
              const SizedBox(height: 20),

              HgPrimaryButton(
                text: exam.lastScore >= 0 ? 'Retake Exam (Last: ${exam.lastScore}%)' : 'Start Exam',
                onPressed: () => context.go('/learning/exam-rules/${exam.id}'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExamMetaInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(text, style: AppTypography.caption),
      ],
    );
  }
}
