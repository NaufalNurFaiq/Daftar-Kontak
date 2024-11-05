import 'package:crud_flutter/add.dart';
import 'package:crud_flutter/model.dart';
import 'package:crud_flutter/repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskPage(),
      routes: {
        '/home': (context) => const TaskPage(),
        '/add': (context) => const AddTask(),
        '/update': (context) => const UpdateTask(),
      },
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).popAndPushNamed('/add'),
          ),
        ],
      ),
      body: listBlog.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/update',
                      arguments: [
                        listBlog[index].id,
                        listBlog[index].title,
                        listBlog[index].content
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listBlog[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                listBlog[index].content,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed:
                             () => Navigator.of(context).popAndPushNamed('/update',
                            arguments: [
                            listBlog[index].id,
                            listBlog[index].title,
                            listBlog[index].content
                            ]), icon: const Icon(Icons.edit, color: Colors.blue,),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool response = await repository.deleteData(listBlog[index].id);
                            if (response) {
                              print('Delete data success');
                            } else {
                              print('Delete data failed');
                            }
                            getData();
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: listBlog.length,
            ),
    );
  }
}
