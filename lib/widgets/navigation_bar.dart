import 'package:flutter/material.dart';
import '../enums/activity_category.dart';
import '../utils/app_theme.dart';

class ActivityNavigationBar extends StatelessWidget {
  final ActivityCategory currentCategory;
  final Function(ActivityCategory) onCategoryChanged;

  const ActivityNavigationBar({
    super.key,
    required this.currentCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ActivityCategory.values.map((category) {
          return _buildNavItem(category);
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(ActivityCategory category) {
    bool isActive = currentCategory == category;
    
    return GestureDetector(
      onTap: () => onCategoryChanged(category),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(isActive ? 8 : 6),
              decoration: BoxDecoration(
                color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                category.icon,
                color: isActive ? Colors.white : Colors.white70,
                size: isActive ? 28 : 24,
              ),
            ),
            SizedBox(height: 4),
            Text(
              category.displayName,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isActive)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(top: 2),
                height: 3,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}