import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lcinephil_dev/globals.dart';
import 'movie_list.dart';

import 'dart:ui' as ui;

class MovieDetail extends StatelessWidget {
  final movie;
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  ///MovieDetail(this.movie);
  ///équivalent à
  ///MovieDetail(movie){
  ///   this.movie = movie;
  ///}
  MovieDetail(this.movie);

  Color mainColor = const Color(0xff3C3261);

  void initMovieFav() {
    movie['fav'] = false;
}


  @override
  Widget build(BuildContext context){
    initMovieFav();
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(image_url+movie['poster_path'], fit: BoxFit.cover,),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.all(20.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.topLeft,
                    child: new IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color(0xffffffff),
                      onPressed: (){
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          SystemNavigator.pop();
                        }
                      },
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Container(width: 400.0, height: 400.0,),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        image: new DecorationImage(image: new NetworkImage(image_url+movie['poster_path']),fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: new Offset(0.0, 10.0)
                        )
                      ]
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(child: new Text(movie['title'], style: new TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'Arvo'),)),
                        new Text('${movie['vote_average']}/10',style: new TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Arvo'),)
                      ],
                    ),
                  ),
                  new Text(movie['overview'], style: new TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                  new Padding(
                      padding: const EdgeInsets.all(10.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      new Expanded(
//                        child: new InkWell(
//                          onTap: null,
//                          child: new Container(
//                            width: 150.0,
//                            height: 60.0,
//                            alignment: Alignment.center,
//                            child: new Text(
//                              'Partager',
//                              style: new TextStyle(
//                                  color: Colors.white,
//                                  fontFamily: 'Arvo',
//                                  fontSize: 20.0
//                              ),
//                            ),
//                            decoration: new BoxDecoration(
//                                borderRadius: new BorderRadius.circular(10.0),
//                                color: const Color(0xaa3C3261)
//                            ),
//                          ),
//                        ),
//                      ),
//                      new Padding(padding: const EdgeInsets.all(16.0),
//                        child: new InkWell(
//                          onTap: null,
//                          child: new Container(
//                            padding: const EdgeInsets.all(16.0),
//                            alignment: Alignment.center,
//                            child: new Icon(
//                              Icons.share,
//                              color: Colors.white,
//                            ),
//                            decoration: new BoxDecoration(
//                                borderRadius: new BorderRadius.circular(10.0),
//                                color: const Color(0xaa3C3261)),
//                          ),
//                        )
//                      ),
                      new Padding(padding: const EdgeInsets.all(16.0),
                        child: new InkWell(
                          onTap: (){
                            if (favoritesFilms.contains(movie['title'])) {
                              movie['fav'] = false;
                              var indexMovieToUnFav = favoritesFilms.indexOf(movie['title']);
                              favoritesFilms.removeAt(indexMovieToUnFav);
                              //print(favoritesFilms.singleWhere((i) => i == movie['title']).indexOf());
                            }else{
                              favoritesFilms.add(movie['title']);
                              //fav = true;
                              movie['fav'] = true;
                            }
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              SystemNavigator.pop();
                            }
                          },
                          child: new Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: new Icon(
                              favoritesFilms.contains(movie['title']) ? Icons.favorite : Icons.favorite_border,
                              //movie['fav'] ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                          ),
                        ),
                      ),
                    ],

                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}