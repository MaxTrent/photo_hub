import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      Uri.parse('api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1'),
      headers: {'Authorization': apiKEY}).then((value){
        print(value.body);

        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData['photos'].forEach((element) {
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
  Widget build(BuildContext context) {
    return Container();
  }
}
