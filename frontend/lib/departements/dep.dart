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
  const DepInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DepInfoState createState() => _DepInfoState();
}

class _DepInfoState extends State<DepInfo> {
  List<Department> departments = [];

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

  @override
  void initState() {
    super.initState();
    fetchDepartments().then((departmentsList) {
      setState(() {
        departments = departmentsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Departments'),
        ),
        body: ListView.builder(
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
    );
  }
}