import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';
import '../features/learning/learning_shell_page.dart';

// Import Feature Pages
import '../features/auth/splash_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/signup_page.dart';
import '../features/auth/branch_onboarding_page.dart';
import '../features/gateway/student_gateway_page.dart';
import '../features/networking/networking_placeholder_page.dart';

// Learning Sub-pages
import '../features/learning/home/learning_home_page.dart';
import '../features/learning/my_learning/my_learning_page.dart';
import '../features/learning/company_exams/company_exams_page.dart';
import '../features/learning/company_exams/company_detail_page.dart';
import '../features/learning/placement/placement_mission_page.dart';
import '../features/learning/plans/premium_plans_page.dart';
import '../features/learning/plans/mock_purchase_page.dart';
import '../features/learning/profile/student_profile_page.dart';
import '../features/learning/profile/edit_profile_page.dart';
import '../features/learning/profile/send_feedback_page.dart';

// Exam Engine
import '../features/learning/exam/exam_rules_page.dart';
import '../features/learning/exam/exam_taking_page.dart';
import '../features/learning/exam/result_page.dart';
import '../features/learning/exam/solutions_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const BranchOnboardingPage(),
    ),
    GoRoute(
      path: '/gateway',
      builder: (context, state) => const StudentGatewayPage(),
    ),
    GoRoute(
      path: '/networking',
      builder: (context, state) => const NetworkingPlaceholderPage(),
    ),

    // Learning Shell Route
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return LearningShellPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/learning/home',
          builder: (context, state) => const LearningHomePage(),
        ),
        GoRoute(
          path: '/learning/my-learning',
          builder: (context, state) => const MyLearningPage(),
        ),
        GoRoute(
          path: '/learning/company-exams',
          builder: (context, state) => const CompanyExamsPage(),
        ),
        GoRoute(
          path: '/learning/company/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? 'comp_tcs';
            return CompanyDetailPage(companyId: id);
          },
        ),
        GoRoute(
          path: '/learning/placement',
          builder: (context, state) => const PlacementMissionPage(),
        ),
        GoRoute(
          path: '/learning/profile',
          builder: (context, state) => const StudentProfilePage(),
        ),
      ],
    ),

    // Independent Full-Screen Learning Overlays
    GoRoute(
      path: '/learning/plans',
      builder: (context, state) => const PremiumPlansPage(),
    ),
    GoRoute(
      path: '/learning/mock-purchase',
      builder: (context, state) => const MockPurchasePage(),
    ),
    GoRoute(
      path: '/learning/edit-profile',
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: '/learning/feedback',
      builder: (context, state) => const SendFeedbackPage(),
    ),

    // Exam Flow
    GoRoute(
      path: '/learning/exam-rules/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'mod_trees_01';
        return ExamRulesPage(moduleId: id);
      },
    ),
    GoRoute(
      path: '/learning/exam-taking/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'mod_trees_01';
        return ExamTakingPage(moduleId: id);
      },
    ),
    GoRoute(
      path: '/learning/result/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'mod_trees_01';
        return ResultPage(moduleId: id);
      },
    ),
    GoRoute(
      path: '/learning/solutions/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'mod_trees_01';
        return SolutionsPage(moduleId: id);
      },
    ),
  ],
);
