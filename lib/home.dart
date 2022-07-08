import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallpaper_app/views/category_view.dart';
import 'package:wallpaper_app/views/search_view.dart';
import 'Widgets/widget.dart';
import 'data/data.dart';
import 'models/category_model.dart';
import 'models/photos_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];

  int noOfImagesToLoad = 30;
  List<PhotosModel> photos = [];

  getTrendingWallpaper() async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/curated?per_page=$noOfImagesToLoad&page=1'),
        headers: {"Authorization": apiKEY}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImagesToLoad += 30;
        getTrendingWallpaper();
      }
    });
  }

  _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Photo Hub',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.black54,
          elevation: 0.0,
        ),
        backgroundColor: Colors.amberAccent,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (searchController.text != '') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    height: 80,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imgUrls: categories[index].imgUrl,
                          category: categories[index].categoryName,
                        );
                      },
                    )
                ),
                wallPaper(photos, context),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Photos are gotten from ',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl('https://www.pexels.com/');
                      },
                      child: Container(
                          child: Text(
                            'Pexels',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Overpass',
                            ),
                          )
                      ),
                    )

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrls, category;

  CategoryTile({required this.imgUrls, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(category: category))
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb ? Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                ) : CachedNetworkImage(
                  imageUrl: imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )
            ),

            SizedBox(
              height: 5,
            ),

            Container(
              width: 100,
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Overpass'),
              ),
            ),
          ],
        ) : Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,): CachedNetworkImage(imageUrl: imgUrls,
                height: 50,
                width: 100,
                fit: BoxFit.cover,)),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                category ?? 'Yo Yo',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Overpass'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
