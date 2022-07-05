import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/photos_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../views/image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      crossAxisCount: 3,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(4.0),
      childAspectRatio: 1,
      shrinkWrap: true,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: listPhotos.map((PhotosModel photoModel){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgPath: photoModel.src!.portrait,
                  )
                )
              );
            },
            child: Hero(
            tag: photoModel.src!.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb ? Image.network(
                    photoModel.src!.portrait,
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  ) : CachedNetworkImage(
                      imageUrl: photoModel.src!.portrait,
                    placeholder: (context, url) => Container(
                      color: Colors.grey,
                    ),
                    fit: BoxFit.cover,
                  )
                ),
              ),
          ),
        ),
        );
      }).toList(),
    ),
  );}