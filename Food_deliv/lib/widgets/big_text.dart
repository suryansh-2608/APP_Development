import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
   BigText({Key? key, this.color = const Color(0xFF332d2b),required this.text, this.overflow = TextOverflow.ellipsis, this.size=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roberto',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400
      ),
    );
  }
}
