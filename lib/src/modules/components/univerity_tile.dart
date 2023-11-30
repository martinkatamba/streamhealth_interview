import 'package:flutter/material.dart';

import '../utils/launch_page.dart';

class UniversityTile extends StatelessWidget {
  String name;
  String country;
  String url;
  UniversityTile(
      {super.key,
      required this.name,
      required this.country,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            color: Colors.deepPurple[100],
            child: ListTile(
                leading: const Icon(Icons.school),
                title: Text(name),
                subtitle: Text(country),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: GestureDetector(
                    onTap: () {
                      try {
                        launchPage(Uri.parse(url));
                      } catch (e) {}
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Read More"),
                    ),
                  ),
                ))),
      ),
    );
  }
}
