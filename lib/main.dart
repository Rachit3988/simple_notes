import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_notes/addNote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'databaseHelper.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SqliteApp());
}

// main class for building layout
class SqliteApp extends StatefulWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  State<SqliteApp> createState() => _SqliteAppState();
}

class _SqliteAppState extends State<SqliteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
      ),
      body: Center(
        child: FutureBuilder<List<Grocery>>(
            future: DatabaseHelper.instance.getGroceries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Loading...'),
                );
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Groceries in List.'))
                  : ListView(
                      children: snapshot.data!.map((grocery) {
                        return Center(
                          child: ListTile(
                            title: Text(grocery.name),
                            subtitle: Text(grocery.another),
                            onLongPress: () {
                              setState(() {
                                DatabaseHelper.instance.remove(grocery.id!);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
    );
  }
}

// this our main glossary class
class Grocery {
  final int? id;
  final String name;
  final String another;

  Grocery({
    this.id,
    required this.name,
    required this.another,
  });

  factory Grocery.fromMap(Map<String, dynamic> json) => Grocery(
        id: json['id'],
        name: json['name'],
        another: json['another'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'another': another,
    };
  }
}
