import 'dart:convert';
import 'dart:ui';

import '../model/photo_model.dart';
import '../screens/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<PhotoModel> photoModels = List();

  @override
  void initState() {
    getPhotoData();
    super.initState();
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(52),
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }

  getPhotoData() async {
    var response = await http.get(
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');

    List<dynamic> jsonData = json.decode(response.body);

    jsonData.forEach((element) {
      PhotoModel photoModel = new PhotoModel();
      photoModel = PhotoModel.fromMap(element);
      photoModels.add(photoModel);
    });

    setState(() {});
  }

  selectPhoto(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoScreen(
          imgUrl: photoModels[index].urls.small,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => selectPhoto(context, index),
            child: Hero(
              tag: photoModels[index].urls.small,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        buildContainer(
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 15, right: 10, left: 10),
                            child: Image.network(
                              photoModels[index].urls.small,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 31,
                          left: 31,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text(
                                    photoModels[index].authorName.name == null
                                        ? 'Unknown author'
                                        : 'Author: ' +
                                            photoModels[index].authorName.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text(
                                    photoModels[index].description == null
                                        ? photoModels[index].altDescription
                                        : photoModels[index].description,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: photoModels == null ? 0 : photoModels.length,
      ),
    );
  }
}
