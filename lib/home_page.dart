import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/add_task.dart';
import 'package:todo/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo Task'),
        actions: [
          IconButton(
            onPressed: controller.toggleSortingOrder,
            icon: Icon(Icons.sort),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final task = controller.filterTask;
        if (task.isEmpty) {
          return Center(child: Text('No Task found'));
        }
        return ListView.builder(
          itemCount: task.length,
          itemBuilder: (BuildContext context, int index) {
            final data = task[index];
            return Card(
              child: ListTile(
                title: Text(data.name),
                subtitle: Text(data.description),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 4,
                  children: [
                    InkWell(onTap: (){
                      controller.deleteTask(data.id);
                    },child: Icon(Icons.delete,size: 24,color: Colors.red)),
                    Text(data.createAt.toString()),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddTaskScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
