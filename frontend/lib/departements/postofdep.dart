import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDep {
  final int id;
  final String title;
  final String content;
  final int dep;

  PostDep({required this.id, required this.title, required this.content, required this.dep});

  factory PostDep.fromJson(Map<String, dynamic> json) {
    return PostDep(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      dep: json['dep'],
    );
  }
}

class PostDepPage extends StatefulWidget {
  final int departmentId;

  const PostDepPage({Key? key, required this.departmentId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostDepPageState createState() => _PostDepPageState();
}

class _PostDepPageState extends State<PostDepPage> {
  List<PostDep> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/postdepartements/${widget.departmentId}/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _posts = data.map((item) => PostDep.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_posts[index].title),
            subtitle: Text(_posts[index].content),
          );
        },
      ),
    );
  }
}
