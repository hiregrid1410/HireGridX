import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../shared/mock_data/mock_repository.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: MockRepository.currentUser.name);
  final _collegeController = TextEditingController(text: MockRepository.currentUser.college);
  final _universityController = TextEditingController(text: MockRepository.currentUser.university);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Profile', style: AppTypography.sectionHeader),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HgTextField(
              labelText: 'Full Name',
              hintText: 'Enter name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            HgTextField(
              labelText: 'College / Institute',
              hintText: 'Enter college',
              controller: _collegeController,
            ),
            const SizedBox(height: 16),
            HgTextField(
              labelText: 'University',
              hintText: 'Enter university',
              controller: _universityController,
            ),
            const SizedBox(height: 24),
            HgPrimaryButton(
              text: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully!')),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
