import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key,required this.width});

  final LayoutValue<double> width;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
