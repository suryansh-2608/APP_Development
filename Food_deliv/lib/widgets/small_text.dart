import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  double height;
  SmallText({Key? key, this.color = const Color(0xFFccc7c5),required this.text, this.overflow = TextOverflow.ellipsis, this.size=12, this.height=1.2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roberto',
          color: color,
          fontSize: size,
        height: height

      ),
    );
  }
}
