/*import 'dart:convert';
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
  // ignore: library_private_types_in_public_api
  _DepInfoState createState() => _DepInfoState();
}

class _DepInfoState extends State<DepInfo> {
  List<Department> departments = [];
  List<PostDep> posts = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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

  Future<List<PostDep>> fetchallPosts() async {
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

Future<void> _savePost(PostDep postDep) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/postdepartements/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDep.toJson()),
    );

    if (response.statusCode == 201) {
      setState(() {
        posts.add(postDep);
      });
    }else {
    throw Exception('Failed to save pose'); // Throw an exception if the POST request is not successful
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
    fetchallPosts().then((postsList) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createPost(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createPost(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    Department? selectedDepartment;

    // Show a dialog to get the post details
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<Department>(
                  value: selectedDepartment,
                  items: departments.map((department) {
                    return DropdownMenuItem<Department>(
                      value: department,
                      child: Text(department.name),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Department',
                  ),
                  onChanged: (Department? value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                  },
                  validator: (Department? value) {
                    if (value == null) {
                      return 'Please select a department';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final postDep = PostDep(
                    id: 0, // The server will assign an ID
                    title: titleController.text,
                    content: contentController.text,
                    dep: selectedDepartment!.id,
                  );
                  await _savePost(postDep);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
*/


/*
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
*/