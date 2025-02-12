import 'package:flutter/material.dart';

class SubScreen extends StatelessWidget {
  String msg;
  SubScreen({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        // automaticallyImplyLeading: false,
        // leading: TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('Back')),
        title: Text('Sub Screen'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.ac_unit_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Drawer Header')),
            ListTile(
                title: Text('Home screen'),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(title: Text('Sub screen'), onTap: () {}),
            ListTile(title: Text('Main screen'), onTap: () {}),
          ],
        ),
      ),
      body: Column(
        children: [
          Center(child: Text('This is Sub Screen')),
          Text(msg),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back to Main Screen'),
          ),
        ],
      ),
    );
  }
}
