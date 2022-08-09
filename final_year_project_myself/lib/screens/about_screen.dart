import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Contact extends StatelessWidget {
  String hp =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi4-6Q_0ETxvLnE3OzKig8MyLSAwpzoZN8vg&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 10, 0, 0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 10, 0, 0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Zeeshan Tariq", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("zeeshantariqm7001@gmail.com",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Flutter Developer", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact #",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("+923177431151", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Container(
                height: 5,
                width: 140,
                color: Colors.cyan.withOpacity(0.9),
              ),
              Container(
                height: 5,
                width: 70,
                color: Colors.green.withOpacity(0.9),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(80)),
            // child: Image(
            //   image: CachedNetworkImageProvider(hp),
            //   fit: BoxFit.fill,
            // ),
          ),
        ],
      ),
    );
  }
}
