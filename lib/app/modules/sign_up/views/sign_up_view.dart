import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 252, 253),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.width * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/casual.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome! Please sign up first to enjoyed our incredible app\'s.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Color.fromARGB(255, 131, 131, 131)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Input your email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 206, 222, 255),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xff6789c6),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ))),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Input your name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 206, 222, 255),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xff6789c6),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ))),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Input your password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 206, 222, 255),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xff6789c6),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xff6789c6),
                                  ),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(15)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  )),
                              onPressed: () {
                                controller.registerUser(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text);
                              },
                              child: controller.isLoading.isTrue
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
