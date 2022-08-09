import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Coming Soon...",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          Text(
            "Coming Soon...",
            style: TextStyle(fontSize: 30, color: Colors.blue),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: LinearProgressIndicator(
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
