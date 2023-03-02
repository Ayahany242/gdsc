import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required TextInputType type,
  Function()? onTap,
  String? text,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function()? suffixPressed,
  required String? Function(String?)? validate,
  double padding = 15.0,
  Widget? suffixWidget,
}) =>
    Padding(
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          /*    suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null, */
          suffixIcon: suffixWidget != null ? suffixWidget : null,
          border: const OutlineInputBorder(),
        ),
        onTap: onTap,
        keyboardType: type,
        validator: validate,
        obscureText: isPassword,
      ),
    );

Widget defaultElevatedButton(
        {double width = double.infinity,
        double height = 50.0,
        required Function()? onPressed,
        required String label,
        required Color color}) =>
    Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: const BorderSide(color: Colors.deepPurple, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: color == Colors.white ? Colors.deepPurple : Colors.white),
        ),
      ),
    );

Widget defaultOutlinedButton({
  double width = double.infinity,
  double height = 50.0,
  required Function()? onPressed,
  required String label,
}) =>
    OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
        side: const BorderSide(color: Colors.deepPurple, width: 1),
        textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple),
      ),
      child: Text(
        label,
      ),
    );

class MyClipper extends CustomClipper<Path> {
  @override

  /*  
   Path getClip(Size size) {
   final path = Path();
    path.lineTo(0, size.height / 1.25);
    path.cubicTo(size.width / 2 * 0.6, size.height * .5, size.width * .6,
        size.height * 1.4, size.width * 1.2, size.height * 1.5);
    path.lineTo(size.width, 0);
     return path;*/

  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.lineTo(0, h * .75);
    path.quadraticBezierTo(w * 0.2, h * 0.6, w * 0.38, h * 0.7);
    path.quadraticBezierTo(w * 0.8, h, w, h * 0.8);
    path.lineTo(w, h * .5);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: ((context) => widget),
    ),
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
  );
}


bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }