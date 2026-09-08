import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({super.key});

  @override
  State<NoticeBoardPage> createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _notices = [
    {
      'id': 'n1',
      'title': 'TCS NQT 2026 Registration Open',
      'category': 'Placement',
      'date': '07 Sep 2026',
      'time': '10:30 AM',
      'isImportant': true,
      'description': 'Tata Consultancy Services (TCS) has officially opened registrations for the National Qualifier Test (NQT) 2026 batch. All final year CS, IT, ECE, and EE students with minimum 60% aggregate are eligible to apply.',
      'tagColor': AppColors.primaryGreen,
    },
    {
      'id': 'n2',
      'title': 'Mid-Semester Exam Schedule Released',
      'category': 'Exams',
      'date': '06 Sep 2026',
      'time': '04:15 PM',
      'isImportant': false,
      'description': 'The mid-semester practical and theory examinations schedule for Data Structures, DBMS, and Quantitative Aptitude has been published on the student portal.',
      'tagColor': AppColors.accentBlue,
    },
    {
      'id': 'n3',
      'title': 'Weekly Placement Mission #12 Live',
      'category': 'Learning',
      'date': '05 Sep 2026',
      'time': '09:00 AM',
      'isImportant': true,
      'description': 'Complete 5 company aptitude assessments before Sunday 11:59 PM to claim +500 XP bonus and unlock the TCS Gold Mock Exam.',
      'tagColor': AppColors.accentYellow,
    },
    {
      'id': 'n4',
      'title': 'Campus Placement Drive: Infosys & Wipro',
      'category': 'Placement',
      'date': '03 Sep 2026',
      'time': '02:00 PM',
      'isImportant': false,
      'description': 'Infosys Specialist Programmer and Wipro Elite NLTH placement drives will commence next week. Ensure your profile and resume details are up to date.',
      'tagColor': AppColors.primaryGreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredNotices = _selectedCategory == 'All'
        ? _notices
        : _notices.where((n) => n['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notes_rounded, color: AppColors.textPrimary, size: 26),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notice Board',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Latest updates, announcements & alerts.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_active_rounded, color: AppColors.primaryGreen, size: 24),
                ],
              ),
              const SizedBox(height: 20),

              // Filter Category Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Placement', 'Exams', 'Learning'].map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          cat,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? const Color(0xFF02080D) : AppColors.textSecondary,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primaryGreen,
                        backgroundColor: const Color(0xFF0D1720),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? AppColors.primaryGreen : const Color(0x1AFFFFFF),
                          ),
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedCategory = cat;
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Notices List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredNotices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notice = filteredNotices[index];
                  final Color tagColor = notice['tagColor'] as Color;

                  return HgCard(
                    onTap: () => _showNoticeDetails(notice),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: tagColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                notice['category'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: tagColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (notice['isImportant'] == true) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0x33FF4D5A),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'URGENT',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.error,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  notice['date'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          notice['title'].toString(),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notice['description'].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
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

  void _showNoticeDetails(Map<String, dynamic> notice) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D1720),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notice['category'].toString().toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: notice['tagColor'] as Color,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice['title'].toString(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Posted: ${notice['date']} at ${notice['time']}',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                notice['description'].toString(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              HgPrimaryButton(
                text: 'Acknowledge',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
