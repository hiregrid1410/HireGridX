import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/learning/learning_shell_page.dart';

// Import Feature Pages
import '../features/auth/splash_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/signup_page.dart';
import '../features/auth/branch_onboarding_page.dart';

// Learning Sub-pages
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/learning/my_learning/my_learning_page.dart';
import '../features/learning/company_exams/company_exams_page.dart';
import '../features/learning/company_exams/company_detail_page.dart';
import '../features/learning/placement/placement_mission_page.dart';
import '../features/learning/plans/premium_plans_page.dart';
import '../features/learning/plans/mock_purchase_page.dart';
import '../features/learning/plans/purchase_page.dart';
import '../features/learning/profile/student_profile_page.dart';
import '../features/learning/profile/edit_profile_page.dart';
import '../features/learning/profile/send_feedback_page.dart';
import '../features/learning/profile/branch_switch_page.dart';
import '../features/learning/noticeboard/notice_board_page.dart';
import '../features/learning/hierarchy/subject_level_page.dart';
import '../features/learning/hierarchy/topic_level_page.dart';
import '../features/learning/hierarchy/module_detail_page.dart';
import '../features/learning/leaderboard/leaderboard_page.dart';

// Exam Engine
import '../features/learning/exam/exam_rules_page.dart';
import '../features/learning/exam/exam_taking_page.dart';
import '../features/learning/exam/result_page.dart';
import '../features/learning/exam/solutions_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/learning/home',
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

    // Learning Shell Route
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return LearningShellPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/learning/home',
          builder: (context, state) => const DashboardPage(),
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
          path: '/learning/noticeboard',
          builder: (context, state) => const NoticeBoardPage(),
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
      path: '/learning/category/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'cat_ee';
        return SubjectLevelPage(categoryId: id);
      },
    ),
    GoRoute(
      path: '/learning/topic/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'sub_ac';
        return TopicLevelPage(subjectId: id);
      },
    ),
    GoRoute(
      path: '/learning/module/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'mod_ac_01';
        return ModuleDetailPage(moduleId: id);
      },
    ),
    GoRoute(
      path: '/learning/leaderboard',
      builder: (context, state) => const LeaderboardPage(),
    ),
    GoRoute(
      path: '/learning/plans',
      builder: (context, state) => const PremiumPlansPage(),
    ),
    GoRoute(
      path: '/learning/purchase',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final title = extra?['title'] as String? ?? 'Premium Pro Plan';
        final price = extra?['price'] as String? ?? '₹1,499 / year';
        return PurchasePage(planTitle: title, planPrice: price);
      },
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
    GoRoute(
      path: '/learning/branch-switch',
      builder: (context, state) => const BranchSwitchPage(),
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
