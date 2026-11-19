import 'package:flutter/material.dart';

void main() {
  runApp(const MiniTaskTrackerApp());
}

class MiniTaskTrackerApp extends StatelessWidget {
  const MiniTaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Task Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Model data sederhana untuk menyimpan struktur tugas
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  // List untuk menyimpan data tugas di memori lokal
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Fungsi untuk menambah tugas baru
  void _addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: _taskController.text.trim()));
      });
      _taskController.clear();
    }
  }

  // Fungsi untuk menghapus tugas
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Fungsi untuk mengubah status selesai/belum
  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Harian'),
      ),
      body: Column(
        children: [
          // 1. Input Data & Tombol Simpan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan tugas/catatan baru...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
          // 2. Tampilan Daftar (List) & Aksi Sederhana
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) => _toggleTask(index),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}