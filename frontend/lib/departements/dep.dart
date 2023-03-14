import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'postofdep.dart';

class Department {
  final int id;
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DepInfo extends StatefulWidget {
  const DepInfo({Key? key}) : super(key: key);

  @override
  _DepInfoState createState() => _DepInfoState();
}

class _DepInfoState extends State<DepInfo> {
  List<Department> departments = [];
  List<PostDep> posts = [];

  Future<List<Department>> fetchDepartments() async {
    var url = "http://127.0.0.1:8000/api/departements/";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var departmentsJson = json.decode(response.body) as List;
      List<Department> departmentsList =
          departmentsJson.map((dept) => Department.fromJson(dept)).toList();
      return departmentsList;
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<List<PostDep>> fetchAllPosts() async {
    var url = "http://127.0.0.1:8000/api/postdepartements/";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var postsJson = json.decode(response.body) as List;
      List<PostDep> postsList =
          postsJson.map((b) => PostDep.fromJson(b)).toList();
      return postsList;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDepartments().then((departmentsList) {
      setState(() {
        departments = departmentsList;
      });
    });
    fetchAllPosts().then((postsList) {
      setState(() {
        posts = postsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDepPage(
                            departmentId: departments[index].id,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(departments[index].name),
                      subtitle: Text('ID: ${departments[index].id}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].content),
          );
        },
      ),
    );
  }
}