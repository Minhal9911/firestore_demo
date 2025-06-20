import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final DateTime createAt;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.createAt,
  });

  factory Task.fromMap(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      name: data['name'],
      description: data["description"],
      createAt:  (data['createAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createAt': createAt,
    };
  }
}
