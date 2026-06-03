// import 'package:flutter/material.dart';
//
// class Videoplay extends StatefulWidget {
//    Videoplay({Key? key}) : super(key: key);
//
//   @override
//   State<Videoplay> createState() => _VideoplayState();
// }
//
// class _VideoplayState extends State<Videoplay> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Videoplay extends StatefulWidget {
  final fileName;
  const Videoplay({super.key, required this.fileName});

  @override
  _VideoplayState createState() => _VideoplayState();
}

class _VideoplayState extends State<Videoplay> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
