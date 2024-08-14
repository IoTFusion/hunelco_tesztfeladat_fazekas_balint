import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/Result.dart';

class MovieCard extends StatelessWidget{

  Result result;

  @override
  Widget build(BuildContext context) {
    String image = result.posterPath??"";
    return Card(
      child: InkWell(
        onTap: (){
          //This should open the next page
        },
          child:
      Row(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).width/4,
            child: Image(image:  NetworkImage("https://image.tmdb.org/t/p/w500/$image")),
          ),
          SizedBox(width: 10,),
          Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                result.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 5 * 3,
              child: Text(
                result.overview,
                maxLines: 3, // Limit the text to 2 lines
                overflow: TextOverflow.clip, // Use ellipsis (...) for overflow
                softWrap: true, // Enable text wrapping
              ),
              )
            ],
          )
          )
        ],
      ),
    )
    );
  }

  MovieCard(this.result);
}