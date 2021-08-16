import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/db/movie_db.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:image_picker/image_picker.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  @override
  Future addMovie() async {
    final movie =
        Movie(movieName: movieName, directorName: directorName, image: bgPath);
    await MovieDB.instance.create(movie);
  }

  String movieName = '';
  String directorName = '';
  String bgPath = '';
  bool isLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                bgPath = image!.path;
                setState(() {});
              },
              child: Center(
                  child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 20,
              )),
            ),
            FloatingActionButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await addMovie();
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context, true);
              },
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(Icons.check),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFBFD7EA),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Add a movie',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Name of the Movie',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          movieName = value;
                        });
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                        color: Colors.black,
                      ))),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Name of the Director',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextField(
                    onChanged: (value) {
                      directorName = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bgPath == ''
                  ? Container(
                      height: 50,
                      child: Center(
                          child:
                              Text('Click on the plus icon to add an image')),
                    )
                  : Container(
                      height: 300,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Image.file(
                              File(bgPath),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                  child: Text(
                                'Movie Poster',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
