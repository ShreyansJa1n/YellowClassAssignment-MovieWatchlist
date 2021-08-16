import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/db/movie_db.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/editscreen.dart';

class ListViewWidget extends StatefulWidget {
  Function getMovies;
  Movie movie;
  ListViewWidget(this.getMovies, this.movie);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
      child: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.movie.image != ''
                ? Container(
                    width: 60,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: FileImage(File(widget.movie.image!)),
                    ),
                  )
                : Container(
                    width: 60,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF2B2D42),
                      radius: 25,
                      child: Center(
                        child:
                            Text('${widget.movie.movieName[0].toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 25,
                                )),
                      ),
                    ),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    '${widget.movie.movieName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    '${widget.movie.directorName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                bool val = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditMovie(widget.movie)));
                if (val) {
                  widget.getMovies();
                }
              },
              icon: Icon(Icons.edit_outlined, color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                await MovieDB.instance.deleteMovie(widget.movie.id!);
                setState(() {
                  widget.getMovies();
                });
              },
              icon: Icon(
                Icons.delete_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFF728083), borderRadius: BorderRadius.circular(17)),
        width: double.infinity,
      ),
    );
  }
}
