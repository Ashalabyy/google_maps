import 'package:flutter/material.dart';
import 'package:google_maps/maps_repo.dart';
import 'package:google_maps/maps_repo_impl.dart';
import 'package:google_maps/maps_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<MapsRepo>.value(
      value: MapsRepoImp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MapsScreen(),
      ),
    );
  }
}
