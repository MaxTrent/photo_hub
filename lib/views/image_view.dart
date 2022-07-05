import 'package:flutter/material.dart';



class ImageView extends StatefulWidget {
  final String imgPath;

  const ImageView({required this.imgPath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

        ],
      ),
    );
  }
}
