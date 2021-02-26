import 'package:carsome_assignment/models/album_model.dart';
import 'package:flutter/material.dart';

class AlbumGrid extends StatelessWidget {
  final List<Photo> photos;
  final double width;
  final double height;

  AlbumGrid({Key key, this.photos, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width < 450 ? 2 : 5,
        crossAxisSpacing: height < 800 ? 5 : 0,
        mainAxisSpacing: 10.0,
        childAspectRatio: height < 800 ? (1.0 / 1.15) : (1.0 / 1.02),
      ),
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      shrinkWrap: true,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Center(
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Image.network(photos[index].thumbnailUrl),
              RichText(
                text: TextSpan(
                  text: photos[index].title,
                  style: TextStyle(color: Colors.black),
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      },
    );
  }
}
