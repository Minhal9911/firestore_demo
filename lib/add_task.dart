import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  final controller=Get.find<TaskController>();
   AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(onPressed: (){
              final name=controller.nameController.text.trim();
              final desc=controller.descriptionController.text.trim();
              if(name.isNotEmpty && desc.isNotEmpty){
                controller.addTask(name, desc);
              }
              Get.back();
            }, child: Text('Create Task'))
          ],
        ),
      ),
    );
  }
}
