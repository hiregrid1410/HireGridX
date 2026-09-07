class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String branchId;
  final String branch;
  final String college;
  final String university;
  final String activePlanId;
  final int planExpiry;
  final int xp;
  final int streak;
  final double accuracy;
  final String lastExamAttemptDate;
  final Map<String, int> moduleScores;
  final Map<String, int> grantedModuleAccess;
  final String theme;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.branchId,
    required this.branch,
    required this.college,
    required this.university,
    required this.activePlanId,
    required this.planExpiry,
    required this.xp,
    required this.streak,
    required this.accuracy,
    required this.lastExamAttemptDate,
    required this.moduleScores,
    required this.grantedModuleAccess,
    required this.theme,
  });

  bool get isPremium => activePlanId.isNotEmpty && planExpiry > DateTime.now().millisecondsSinceEpoch;

  String get rankBadge {
    if (xp < 500) return 'Bronze V';
    if (xp < 1000) return 'Silver III';
    if (xp < 2000) return 'Gold III';
    if (xp < 3500) return 'Diamond I';
    return 'Master';
  }
}

class HierarchyNode {
  final String id;
  final String name;
  final String type; // branch, subject, topic, subtopic
  final String parentId;
  final String accessType; // free, demo, premium_only
  final int displayOrder;
  final int moduleCount;
  final double progress;

  HierarchyNode({
    required this.id,
    required this.name,
    required this.type,
    required this.parentId,
    required this.accessType,
    required this.displayOrder,
    this.moduleCount = 0,
    this.progress = 0.0,
  });
}

class ExamQuestion {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  ExamQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

class ExamModule {
  final String id;
  final String title;
  final String parentId;
  final String category;
  final List<ExamQuestion> questions;
  final int timeLimitMinutes;
  final int passPercentage;
  final String accessType; // free, demo, premium
  final int lastScore;

  ExamModule({
    required this.id,
    required this.title,
    required this.parentId,
    required this.category,
    required this.questions,
    required this.timeLimitMinutes,
    required this.passPercentage,
    required this.accessType,
    this.lastScore = -1,
  });
}

class CompanyModel {
  final String id;
  final String name;
  final String logoUrl;
  final String accessBadge; // FREE, PREMIUM, UNLOCKED
  final String price;
  final String description;
  final String minCgpa;
  final String eligibleBranches;
  final String backlogsPolicy;
  final List<ExamModule> modules;

  CompanyModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.accessBadge,
    required this.price,
    required this.description,
    required this.minCgpa,
    required this.eligibleBranches,
    required this.backlogsPolicy,
    required this.modules,
  });
}

class PlanModel {
  final String id;
  final String title;
  final String durationText;
  final String priceText;
  final bool isPopular;
  final List<String> benefits;

  PlanModel({
    required this.id,
    required this.title,
    required this.durationText,
    required this.priceText,
    this.isPopular = false,
    required this.benefits,
  });
}

class LeaderboardUser {
  final int rank;
  final String name;
  final String branch;
  final int xp;
  final String avatarUrl;

  LeaderboardUser({
    required this.rank,
    required this.name,
    required this.branch,
    required this.xp,
    required this.avatarUrl,
  });
}
