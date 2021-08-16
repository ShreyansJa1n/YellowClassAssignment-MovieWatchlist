import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_class_assignment/db/movie_db.dart';
import 'package:yellow_class_assignment/model/movie.dart';

class EditMovie extends StatefulWidget {
  Movie movie;
  EditMovie(this.movie);

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  Future editMovie() async {
    final movie = Movie(
        id: widget.movie.id,
        movieName: movieName == '' ? widget.movie.movieName : movieName,
        directorName:
            directorName == '' ? widget.movie.directorName : directorName,
        image: bgPath);
    await MovieDB.instance.updateMovie(movie);
  }

  String movieName = '';
  String directorName = '';
  String bgPath = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bgPath = widget.movie.image!;
    movieName = widget.movie.movieName;
    directorName = widget.movie.directorName;
  }

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
                // Directory appDocDir = await getApplicationDocumentsDirectory();
                // bgPath =
                //     appDocDir.uri.resolve("${getRandomString(10)}.jpg").path;
                // await image!.saveTo(bgPath);
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
                await editMovie();
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name of the Movie',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextFormField(
                initialValue: widget.movie.movieName,
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
              Text(
                'Name of the Director',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextFormField(
                initialValue: widget.movie.directorName,
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
