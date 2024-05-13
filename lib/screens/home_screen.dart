import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user['name']['first'];
          final email = user['email'];
          final imageUrl = user['picture']['thumbnail'];

          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(image: NetworkImage(imageUrl))),
            title: Text(name),
            subtitle: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchUsers();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchUsers() async {
    //const url = 'https://randomuser.me/api/?results=2';
    final uri = Uri.parse('https://randomuser.me/api/?results=100');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        users = json['results'];
      });
      print("Api success");
    } else {
      throw Exception("failded to load users");
    }
  }
}
