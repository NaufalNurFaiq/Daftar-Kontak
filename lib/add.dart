import 'package:crud_flutter/repository.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Repository repository = Repository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>?;

    if (args != null && args.isNotEmpty) {
      if (args.length > 1 && args[1].isNotEmpty) {
        _titleController.text = args[1];
      }
      if (args.length > 2 && args[2].isNotEmpty) {
        _contentController.text = args[2];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak',
        style: TextStyle(fontWeight: FontWeight.w700),
        ),
      backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Nama'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(hintText: 'Nomor Hp'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool response = await repository.postData(
                _titleController.text,
                _contentController.text,
              );

              if (response) {
                Navigator.of(context).popAndPushNamed('/home');
              } else {
                print('Post Data Gagal');
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  Repository repository = Repository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>?;

    if (args != null && args.isNotEmpty) {
      if (args.length > 1 && args[1].isNotEmpty) {
        _titleController.text = args[1];
      }
      if (args.length > 2 && args[2].isNotEmpty) {
        _contentController.text = args[2];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Kontak',
        style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Nama'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(hintText: 'Nomor Hp'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (args != null && args.isNotEmpty) {
                bool response = await repository.putData(
                  int.parse(args[0]),
                  _titleController.text,
                  _contentController.text,
                );

                if (response) {
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  print('Update Data Gagal');
                }
              } else {
                print('Tidak ada data untuk diperbarui');
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}