import 'package:flutter/material.dart';
import 'package:gdsc_task/register_screen.dart';
import 'package:gdsc_task/shared/component.dart';

import 'animated_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //size l screen
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: size.height / 3,
                    width: size.width,
                    color: Colors.deepPurple,
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height / 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 10,
                ),
                defaultFormField(
                  controller: emailController,
                  label: 'Email',
                  type: TextInputType.emailAddress,
                  prefix: Icons.email,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your email';
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
                      return 'please enter your password';
                    } else if (value.length < 8) {
                      return 'password must be at least 8 characters';
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
                        navigateAndFinish(context,const AnimatedListScreen());
                      }
                    },
                    label: 'Login',
                    color: Colors.deepPurple),
                SizedBox(
                  height: size.height * .02,
                ),
                defaultElevatedButton(
                    onPressed: () {
                      navigateAndFinish(
                        context,
                        const RegisterScreen(),
                      );
                    },
                    label: 'Register',
                    color: Colors.white),
                SizedBox(
                  height: size.height / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
