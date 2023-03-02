import 'package:flutter/material.dart';
import 'package:gdsc_task/login_screen.dart';

import 'animated_list_screen.dart';
import 'shared/component.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var phoneNumberController = TextEditingController();
  bool isPassword = true;
  bool isPasswordConfirm = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //size l screen
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: size.height / 3,
                  width: size.width,
                  color: Colors.deepPurple,
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
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
              defaultFormField(
                controller: emailController,
                label: 'Email Address',
                type: TextInputType.emailAddress,
                prefix: Icons.email,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Email Address mustn\'t be Empty';
                  }
                  if (!isValidEmail(emailController.text)) {
                    return 'please enter valid email';
                  }
                  return null;
                },
              ),
              defaultFormField(
                controller: passwordController,
                label: 'Password',
                type: TextInputType.visiblePassword,
                prefix: Icons.lock,
                isPassword: isPassword,
                suffixWidget: IconButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  icon: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Password mustn\'t be Empty';
                  } else if (value.length < 8) {
                    return 'password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              defaultFormField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                type: TextInputType.visiblePassword,
                prefix: Icons.lock,
                isPassword: isPasswordConfirm,
                suffixWidget: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordConfirm = !isPasswordConfirm;
                    });
                  },
                  icon: Icon(
                    isPasswordConfirm ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Password mustn\'t be Empty';
                  } else if (confirmPasswordController.text !=
                      passwordController.text) {
                    return 'Password doesn\'t match';
                  } else if (value.length < 8) {
                    return 'password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              defaultFormField(
                controller: phoneNumberController,
                label: 'Phone Number',
                type: TextInputType.phone,
                prefix: Icons.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'phone number mustn\'t be Empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * .04,
              ),
              defaultElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('success');
                      navigateAndFinish(context, const AnimatedListScreen());
                    }
                  },
                  label: 'Register',
                  color: Colors.deepPurple),
              SizedBox(
                height: size.height * .02,
              ),
              defaultElevatedButton(
                  onPressed: () {
                    navigateAndFinish(
                      context,
                      const LoginScreen(),
                    );
                  },
                  label: 'Login',
                  color: Colors.white),
              SizedBox(
                height: size.height / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class CustomClipPath extends CustomClipper<Path> {
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
 */