import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yellow_class_assignment/db/movie_db.dart';
import 'package:yellow_class_assignment/screens/addfile.dart';
import 'package:yellow_class_assignment/components/listviewwidget.dart';
import 'package:yellow_class_assignment/components/nomoviewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yellow_class_assignment/screens/info_dev.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List movies = [];
  bool isLoading = false;
  late bool isVisible;
  late ScrollController hidebutton;

  late FirebaseAuth firebaseAuth;
  bool isAuth = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    super.initState();
    getMovies();
    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        isAuth = false;
      } else {
        setState(() {
          isAuth = true;
        });
      }
    });
    isVisible = true;
    hidebutton = new ScrollController();
    hidebutton.addListener(() {
      if (hidebutton.position.userScrollDirection == ScrollDirection.reverse) {
        if (isVisible == true) {
          print(isVisible);
          setState(() {
            isVisible = false;
          });
        }
      } else if (hidebutton.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isVisible == false) {
          print(isVisible);
          setState(() {
            isVisible = true;
          });
        }
      }
    });
  }

  Future getMovies() async {
    setState(() {
      isLoading = true;
    });

    this.movies = await MovieDB.instance.allMovies();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBFD7EA),
      floatingActionButton: Visibility(
        visible: isVisible ? true : false,
        child: FloatingActionButton(
          onPressed: isAuth
              ? () async {
                  bool val = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddMovie()));
                  if (val) {
                    getMovies();
                  }
                }
              : () async {
                  print(isAuth);
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Google Sign-in is required to add movies to the list. Click on the button below to continue.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(20)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue.shade200),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: 1.0))),
                                  ),
                                  onPressed: () async {
                                    await signInWithGoogle();
                                    Navigator.pop(context);
                                    bool val = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddMovie()));
                                    if (val) {
                                      getMovies();
                                    }
                                  },
                                  child: Text('Sign in With Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black)))
                            ],
                          ),
                        );
                      });
                },
          child: Icon(
            Icons.add_rounded,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: hidebutton,
          slivers: [
            SliverAppBar(
              floating: true,
              centerTitle: false,
              pinned: true,
              expandedHeight: 130,
              collapsedHeight: 72,
              backgroundColor: Color(0xFFBFD7EA),
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoDeveloper()));
                  },
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black,
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsetsDirectional.only(start: 20, end: 20),
                title: Text(
                  isAuth
                      ? "Hey ${firebaseAuth.currentUser!.displayName} 👋🏼\nYour Movie Watchlist"
                      : "Hey 👋🏼\nYour Movie Watchlist",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Mont',
                      fontWeight: FontWeight.w700),
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            isLoading
                ? SliverFillRemaining(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  )
                : movies.isEmpty
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 70),
                          child: NoMovieWidget(),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ListViewWidget(getMovies, movies[index]);
                          },
                          childCount: movies.length,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
