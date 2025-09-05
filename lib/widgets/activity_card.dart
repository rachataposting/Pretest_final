import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../utils/app_theme.dart';
import '../utils/date_formatter.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: _buildCard(context),
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        shadowColor: Colors.black26,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroImage(),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        Hero(
          tag: 'activity-${activity.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              activity.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[300]!, Colors.grey[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('ไม่สามารถโหลดรูปได้', 
                          style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        _buildCategoryBadge(),
        _buildReadMoreOverlay(),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          activity.category.displayName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReadMoreOverlay() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'อ่านเพิ่มเติม',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            activity.description.length > 100 
                ? '${activity.description.substring(0, 100)}...' 
                : activity.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoRow(),
          SizedBox(height: 8),
          _buildDateTimeRow(context),
          if (activity.location.isNotEmpty) ...[
            SizedBox(height: 8),
            _buildLocationRow(),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Icon(Icons.group, size: 18, color: AppTheme.primaryColor),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            activity.organizer,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
        SizedBox(width: 6),
        Text(
          DateFormatter.formatDate(activity.date),
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        SizedBox(width: 16),
        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
        SizedBox(width: 6),
        Text(
          activity.time.format(context),
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            activity.location,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}