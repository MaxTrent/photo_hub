import 'package:flutter/material.dart';
import '../models/photos_model.dart';

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
                    imgPath: photoModel.src.portrait,
                  )
                )
              )
            },
          ),
        ),
        );
      }),
    ),
  ),}