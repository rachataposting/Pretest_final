import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../enums/activity_category.dart';
import '../services/activity_service.dart';
import '../widgets/activity_card.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/empty_state.dart';
import '../utils/app_theme.dart';
import 'activity_detail_screen.dart';
import 'add_edit_activity_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  ActivityCategory currentCategory = ActivityCategory.all;

  List<Activity> get filteredActivities {
    return ActivityService.getActivitiesByCategory(currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 191, 106, 224),
        title: Text(
          'RMUTR Activities by 1168',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          ActivityNavigationBar(
            currentCategory: currentCategory,
            onCategoryChanged: (category) {
              setState(() {
                currentCategory = category;
              });
            },
          ),
          Expanded(
            child: filteredActivities.isEmpty 
                ? EmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredActivities.length,
                    itemBuilder: (context, index) {
                      final activity = filteredActivities[index];
                      return ActivityCard(
                        activity: activity,
                        index: index,
                        onTap: () => _openDetailView(activity),
                        onLongPress: () => _showActivityOptions(activity),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: _buildAnimatedFAB(),
    );
  }

  Widget _buildAnimatedFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToAddActivity(),
      backgroundColor: const Color.fromARGB(255, 199, 129, 223),
      elevation: 8,
      icon: Icon(Icons.add, color: Colors.white),
      label: Text(
        'เพิ่มกิจกรรม',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _openDetailView(Activity activity) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ActivityDetailScreen(
            activity: activity,
            onEdit: () => _navigateToEditActivity(activity),
            onDelete: () => _confirmDeleteActivity(activity),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  void _showActivityOptions(Activity activity) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              Text(
                activity.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(
                    icon: Icons.visibility,
                    label: 'ดูรายละเอียด',
                    onTap: () {
                      Navigator.pop(context);
                      _openDetailView(activity);
                    },
                  ),
                  _buildOptionButton(
                    icon: Icons.edit,
                    label: 'แก้ไข',
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToEditActivity(activity);
                    },
                  ),
                  _buildOptionButton(
                    icon: Icons.delete,
                    label: 'ลบ',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      _confirmDeleteActivity(activity);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final buttonColor = color ?? AppTheme.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: buttonColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonColor.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: buttonColor, size: 28),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditActivityScreen(
          onSave: (activity) {
            ActivityService.addActivity(activity);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _navigateToEditActivity(Activity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditActivityScreen(
          activity: activity,
          onSave: (updatedActivity) {
            ActivityService.updateActivity(updatedActivity);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _confirmDeleteActivity(Activity activity) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.warning, color: const Color.fromARGB(255, 248, 123, 20)),
              SizedBox(width: 8),
              Text('ยืนยันการลบ'),
            ],
          ),
          content: Text('คุณต้องการลบกิจกรรม "${activity.title}" หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                ActivityService.deleteActivity(activity.id);
                setState(() {});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ลบกิจกรรมเรียบร้อยแล้ว'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('ลบ', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}