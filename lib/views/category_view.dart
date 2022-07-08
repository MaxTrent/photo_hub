import 'dart:convert';
import 'package:wallpaper_app/Widgets/widget.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:http/http.dart' as http;


class CategoryView extends StatefulWidget {
  final String category;

  CategoryView({required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<PhotosModel> photos = [];

  getCategoryWallpaper() async{
    await http.get(
    Uri.parse('https://api.pexels.com/v1/search?query=${widget.category}&per_page=1'),
    headers: {'Authorization': apiKEY}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {

      });
    });
  }

  @override
  void initState(){
    getCategoryWallpaper();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Hub'),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: wallPaper(photos, context),
      ),
    );
  }
}
