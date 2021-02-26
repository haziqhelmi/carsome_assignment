import 'package:carsome_assignment/components/album_button.dart';
import 'package:carsome_assignment/components/album_grid.dart';
import 'package:carsome_assignment/models/album_model.dart';
import 'package:carsome_assignment/models/http_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Album { one, two }

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Album selectedAlbum = Album.one;
    bool apiCall = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlbumButton(
                label: '1',
                onPress: () {
                  setState(() {
                    // fetchPhotos(http.Client(), 'https://jsonplaceholder.typicode.com/photos?albumId=2');
                    selectedAlbum = Album.one;
                    apiCall = true;
                  });
                },
              ),
              AlbumButton(
                label: '2',
                onPress: () {
                  setState(() {
                    // fetchPhotos(http.Client(), 'https://jsonplaceholder.typicode.com/photos?albumId=2');
                    selectedAlbum = Album.two;
                    apiCall = true;
                  });
                },
              ),
            ],
          ),
          Flexible(
            child: selectedAlbum == Album.one
                ? BuildAlbumGrid(
                    width: _width,
                    height: _height,
                    url: 'https://jsonplaceholder.typicode.com/photos?albumId=1',
                    apiCall: apiCall,
                  )
                : BuildAlbumGrid(
                    width: _width,
                    height: _height,
                    url: 'https://jsonplaceholder.typicode.com/photos?albumId=2',
                    apiCall: apiCall,
                  ),
          ),
        ],
      ),
    );
  }
}

class BuildAlbumGrid extends StatelessWidget {
  const BuildAlbumGrid({
    Key key,
    @required double width,
    @required double height,
    this.url,
    this.apiCall,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;
  final String url;
  final bool apiCall;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: fetchPhotos(http.Client(), url),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        if (apiCall == true || snapshot.hasData) {
          return AlbumGrid(photos: snapshot.data, width: _width, height: _height);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
