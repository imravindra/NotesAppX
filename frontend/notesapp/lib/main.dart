import 'package:flutter/material.dart';
import 'package:notesapp/pages/HomePage.dart';
import 'package:notesapp/providers/notesprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NotesProvider(),
          ),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ));
  }
}
