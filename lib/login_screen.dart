import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  IconData suffixIcon = Icons.visibility_outlined;

  bool password = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                height: 230,
                color: Colors.deepPurple,
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    label: 'Full Name',
                    type: TextInputType.text,
                    prefix: Icons.person,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name mustn\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email Address',
                    type: TextInputType.emailAddress,
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email Address mustn\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    label: 'Password',
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                    suffix: suffixIcon,
                    suffixPressed: () {
                      setState(() {
                        suffixIcon = Icons.visibility_off;
                        password = false;
                      });
                    },
                    isPassword: password,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password mustn\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                    isPassword: password,
                    suffix: suffixIcon,
                    suffixPressed: () {
                      setState(() {
                        suffixIcon = Icons.visibility_off;
                        password = false;
                      });
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneNumberController,
                    label: 'Phone Number',
                    type: TextInputType.number,
                    prefix: Icons.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone number mustn\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('success');
                        }
                      },
                      label: 'Register',
                      color: Colors.deepPurple),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onPressed: () {}, label: 'Login', color: Colors.white),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.lineTo(0, h * .75);
    path.quadraticBezierTo(w * 0.2, h * 0.6, w * 0.38, h * 0.7);
    path.quadraticBezierTo(w * 0.8, h, w, h * 0.8);
    path.lineTo(w, h * .5);
    path.lineTo(w, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

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
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        // fillColor: Colors.grey[200],
        filled: true,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      onTap: onTap,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
    );

Widget defaultButton(
        {double width = double.infinity,
        double height = 50.0,
        required Function()? onPressed,
        required String label,
        required Color color}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          // color: Colors.yellow,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.deepPurple)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(
          label,
          style: TextStyle(
              color: color == Colors.white ? Colors.deepPurple : Colors.white),
        ),
      ),
    );
