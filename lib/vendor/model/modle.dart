import 'dart:html';

import 'package:flutter/material.dart';

class HHHH extends StatelessWidget {
  const HHHH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Column(
            // image
          ),
          Column(
            children: [
              Row(
                children: [
                  Text("قاعات/ ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text("شمس",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),


            ],
          ),

        ],
      ),
    );
  }
}
