import 'package:carsome_assignment/components/album_button.dart';
import 'package:carsome_assignment/models/album_model.dart';
import 'package:carsome_assignment/models/http_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlbumButton(
                label: '1',
                onPress: () {},
              ),
              AlbumButton(
                label: '2',
                onPress: () {},
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: fetchPhotos(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData ? PhotosList(photos: snapshot.data) : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: EdgeInsets.all(28),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(photos[index].thumbnailUrl),
            Text(
              photos[index].title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      },
    );
  }
}
