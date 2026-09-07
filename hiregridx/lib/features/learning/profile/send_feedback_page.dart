import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  String _category = 'Suggestion';
  final _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Send Feedback', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Feedback Category', style: AppTypography.caption),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  dropdownColor: AppColors.surface,
                  style: AppTypography.bodyLarge,
                  items: ['Suggestion', 'Bug Report', 'Content Issue', 'Other'].map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _category = val!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            HgTextField(
              labelText: 'Message & Description',
              hintText: 'Tell us how we can improve...',
              controller: _msgController,
            ),
            const SizedBox(height: 24),

            HgPrimaryButton(
              text: 'Submit Feedback',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: const Text('Thank You!', style: AppTypography.cardTitle),
                    content: const Text('Your feedback has been received.', style: AppTypography.bodyMedium),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                        },
                        child: const Text('OK', style: TextStyle(color: AppColors.primaryGreen)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
