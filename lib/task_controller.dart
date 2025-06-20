import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/model.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final task = <Task>[].obs;
  final sortAscending = true.obs;
  final searchQuery = ''.obs;
  late Stream<List<Task>> _taskStream;

  @override
  void onInit() {
    super.onInit();
    fetchTask();
  }

  void fetchTask() {
    /*_taskStream = _firestore
        .collection('task')
        .orderBy('createAt', descending: !sortAscending.value)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((d) => Task.fromMap(d.data(), d.id)).toList(),
        );

    _taskStream.listen((task){
      task.assignAll(task);
    });*/
    _firestore
        .collection('task')
        .orderBy('createAt', descending: !sortAscending.value)
        .snapshots()
        .listen((snapshot) {
          task.value =
              snapshot.docs
                  .map((doc) => Task.fromMap(doc.data(), doc.id))
                  .toList();
        });
  }

  void addTask(String name, String description) {
    debugPrint('timeStamp: ${DateTime.now()}');
    final newTask = Task(
      id: '',
      name: name,
      description: description,
      createAt: DateTime.now(),
    );
    _firestore.collection('task').add(newTask.toMap());
  }

  List<Task> get filterTask {
    if (searchQuery.value.isEmpty) return task;
    return task
        .where(
          (task) =>
              task.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleSortingOrder() {
    sortAscending.toggle();
    ;
    fetchTask();
  }

  void deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('task').doc(taskId).delete();
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }

  void updateTask(String taskId, String newName, String newDescription) async {
    try {
      await FirebaseFirestore.instance.collection('task').doc(taskId).update({
        'name': newName,
        'description': newDescription,
        'createAt': DateTime.now(),
      });
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
