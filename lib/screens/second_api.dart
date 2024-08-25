import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/models/photos_model.dart';
import 'package:http/http.dart' as http;

class SecondApi extends StatefulWidget {
  const SecondApi({super.key});

  @override
  State<SecondApi> createState() => _SecondApiState();
}

class _SecondApiState extends State<SecondApi> {
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photosModel = PhotosModel(
            title: i['title'],
            url: i['url'],
            albumId: i['albumId'],
            thumbnailUrl: i['thumbnailUrl']);
        photosList.add(photosModel);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotosApi(),
                builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                  return ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text('Notes Id${snapshot.data![index].id}'),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}
