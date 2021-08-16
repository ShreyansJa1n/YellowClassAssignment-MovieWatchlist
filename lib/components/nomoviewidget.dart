import 'package:flutter/material.dart';

class NoMovieWidget extends StatelessWidget {
  const NoMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'The movie list has not been created. Click on the plus button to get started.',
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 26, fontFamily: 'Mont'),
      ),
    );
  }
}
