import 'package:flutter/material.dart';

import './basic/form_page.dart';

import 'dynamic/form_dynamic_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("示例"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("基本使用"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("动态表单"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormDynamicPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
