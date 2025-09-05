import '../models/activity.dart';
import '../enums/activity_category.dart';
import '../data/sample_activities.dart';

class ActivityService {
  static final List<Activity> _activities = [...SampleActivities.activities];

  static List<Activity> get allActivities => _activities;

  static List<Activity> getActivitiesByCategory(ActivityCategory category) {
    if (category == ActivityCategory.all) return _activities;
    return _activities.where((activity) => activity.category == category).toList();
  }

  static void addActivity(Activity activity) {
    _activities.add(activity);
  }

  static void updateActivity(Activity updatedActivity) {
    int index = _activities.indexWhere((a) => a.id == updatedActivity.id);
    if (index != -1) {
      _activities[index] = updatedActivity;
    }
  }

  static void deleteActivity(String id) {
    _activities.removeWhere((a) => a.id == id);
  }

  static Activity? findById(String id) {
    try {
      return _activities.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}