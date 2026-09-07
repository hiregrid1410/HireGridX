import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class ExamTakingPage extends StatefulWidget {
  final String moduleId;

  const ExamTakingPage({super.key, required this.moduleId});

  @override
  State<ExamTakingPage> createState() => _ExamTakingPageState();
}

class _ExamTakingPageState extends State<ExamTakingPage> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  final Set<int> _flaggedForReview = {};
  late Timer _timer;
  int _secondsRemaining = 1800; // 30 mins

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        _submitExam();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final mins = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final secs = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  void _submitExam() {
    context.go('/learning/result/${widget.moduleId}');
  }

  @override
  Widget build(BuildContext context) {
    final exam = MockRepository.dsaTreesExam;
    final question = exam.questions[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(exam.title, style: AppTypography.sectionHeader),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppColors.primaryGreen),
                const SizedBox(width: 6),
                Text(_formattedTime, style: AppTypography.button.copyWith(color: AppColors.primaryGreen, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Tracker Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of ${exam.questions.length}',
                    style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.grid_view_rounded, color: AppColors.textSecondary),
                    onPressed: () => _showQuestionPalette(context, exam.questions.length),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Question Text Card
              HgCard(
                child: Text(
                  question.text,
                  style: AppTypography.cardTitle.copyWith(fontSize: 17, height: 1.4),
                ),
              ),
              const SizedBox(height: 20),

              // Options List
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, optIdx) {
                    final isSelected = _selectedAnswers[_currentIndex] == optIdx;

                    return HgCard(
                      onTap: () {
                        setState(() {
                          _selectedAnswers[_currentIndex] = optIdx;
                        });
                      },
                      border: isSelected
                          ? Border.all(color: AppColors.primaryGreen, width: 2)
                          : Border.all(color: AppColors.border),
                      backgroundColor: isSelected
                          ? AppColors.primaryGreen.withOpacity(0.1)
                          : AppColors.surface,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : AppColors.surfaceElevated,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              String.fromCharCode(65 + optIdx),
                              style: TextStyle(
                                color: isSelected ? AppColors.backgroundDark : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              question.options[optIdx],
                              style: AppTypography.bodyLarge.copyWith(
                                color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Control Bar
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _flaggedForReview.contains(_currentIndex) ? Icons.bookmark : Icons.bookmark_border,
                      color: AppColors.accentYellow,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_flaggedForReview.contains(_currentIndex)) {
                          _flaggedForReview.remove(_currentIndex);
                        } else {
                          _flaggedForReview.add(_currentIndex);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  if (_currentIndex > 0)
                    Expanded(
                      child: HgSecondaryButton(
                        text: 'Previous',
                        onPressed: () {
                          setState(() {
                            _currentIndex--;
                          });
                        },
                      ),
                    ),
                  if (_currentIndex > 0) const SizedBox(width: 12),
                  Expanded(
                    child: HgPrimaryButton(
                      text: _currentIndex == exam.questions.length - 1 ? 'Submit' : 'Next',
                      onPressed: () {
                        if (_currentIndex < exam.questions.length - 1) {
                          setState(() {
                            _currentIndex++;
                          });
                        } else {
                          _submitExam();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuestionPalette(BuildContext context, int total) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Question Palette', style: AppTypography.cardTitle),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: total,
                itemBuilder: (context, index) {
                  final isAnswered = _selectedAnswers.containsKey(index);
                  final isFlagged = _flaggedForReview.contains(index);

                  Color bg = AppColors.surfaceElevated;
                  if (isAnswered) bg = AppColors.primaryGreen;
                  if (isFlagged) bg = AppColors.accentYellow;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                      context.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: (isAnswered || isFlagged) ? AppColors.backgroundDark : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
