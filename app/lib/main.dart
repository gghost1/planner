import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'entities/notes/note.dart';
import 'entities/user/user.dart';
import 'screens/main_screen.dart';
import 'screens/activities_list_screen.dart';
import 'screens/notes_list_screen.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NoteAdapter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      //  home: ActivitiyList(),
      // home: NoteList(),
    );
  }
}