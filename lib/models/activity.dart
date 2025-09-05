import 'package:flutter/material.dart';
import '/enums/activity_category.dart';

class Activity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String organizer;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final ActivityCategory category;

  Activity({
    String? id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.organizer,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? organizer,
    DateTime? date,
    TimeOfDay? time,
    String? location,
    ActivityCategory? category,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      organizer: organizer ?? this.organizer,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      category: category ?? this.category,
    );
  }
}