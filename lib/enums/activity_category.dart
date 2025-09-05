import 'package:flutter/material.dart';

enum ActivityCategory {
  all,
  academic,
  art,
  sport,
  social;

  String get displayName {
    switch (this) {
      case ActivityCategory.all:
        return 'ทั้งหมด';
      case ActivityCategory.academic:
        return 'วิชาการ';
      case ActivityCategory.art:
        return 'ศิลปะ';
      case ActivityCategory.sport:
        return 'กีฬา';
      case ActivityCategory.social:
        return 'สังคม';
    }
  }

  IconData get icon {
    switch (this) {
      case ActivityCategory.all:
        return Icons.apps;
      case ActivityCategory.academic:
        return Icons.school;
      case ActivityCategory.art:
        return Icons.palette;
      case ActivityCategory.sport:
        return Icons.sports_soccer;
      case ActivityCategory.social:
        return Icons.people;
    }
  }

  static ActivityCategory fromString(String category) {
    switch (category) {
      case 'วิชาการ':
        return ActivityCategory.academic;
      case 'ศิลปะ':
        return ActivityCategory.art;
      case 'กีฬา':
        return ActivityCategory.sport;
      case 'สังคม':
        return ActivityCategory.social;
      default:
        return ActivityCategory.all;
    }
  }
}