import 'package:flutter/material.dart';

class MyShapes extends Shapes {
  @override
  ShapeBorder small = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );

  @override
  ShapeBorder medium = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );

  @override
  ShapeBorder large = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0),
  );
}

final Shapes myShapes = MyShapes();
