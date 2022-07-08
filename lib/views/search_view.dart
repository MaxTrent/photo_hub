import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/Widgets/widget.dart';
import 'package:wallpaper_app/models/photos_model.dart';

import '../data/data.dart';

class SearchView extends StatefulWidget {
  String search;

  SearchView({required this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = new TextEditingController();

  getSearchWallpaper(String searchQuery) async {
    await http.get(
        Uri.parse(
            'api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1'),
        headers: {'Authorization': apiKEY}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData['photos'].forEach((element) {
        print(element);

        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {});
    });
  }

  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Photo Hub')),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Photo',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        getSearchWallpaper(searchController.text);
                      },
                      child: Container(child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              wallPaper(photos, context),
            ],
          ),
        ),
      ),
    );
  }
}
