import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';


class ImageView extends StatefulWidget {
  final String imgPath;

  const ImageView({required this.imgPath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

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
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: kIsWeb ? Image.network(
                widget.imgPath, fit: BoxFit.cover,
              ) : CachedNetworkImage(
                imageUrl: widget.imgPath,
                placeholder: (context, url) =>
                    Container(
                      color: Color(0xfff5f8fd),
                    ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (kIsWeb) {
                      _launchUrl(widget.imgPath);
                    }
                    else {
                      _save();
                    }
                  },
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(
        widget.imgPath, options: Options(responseType: ResponseType.bytes));

    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
    quality: 60,
    );
    print(result);
    print('Image Saved');
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      await Permission.photos.request().isGranted;
  } else{
      await Permission.storage.status;
    }
  }
}
