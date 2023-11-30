import 'package:flutter/material.dart';

import 'src/modules/blocs/fetch/fetch_universities_bloc.dart';
import 'src/modules/views/home_page.dart';
import 'src/repositories/universities/university_repo.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streamline Health Interview',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
