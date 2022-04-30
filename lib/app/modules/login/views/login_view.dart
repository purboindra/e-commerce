import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
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
                        "assets/3d.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Sign In",
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
                  "Welcome! enter your email and password below to sign in.",
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
                Obx(() => TextField(
                    obscureText: controller.isHidden.value,
                    controller: passwordController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.isHidden.toggle();
                          },
                          icon: controller.isHidden.isTrue
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
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
                        )))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(() => Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (value) {
                                controller.rememberMe.toggle();
                              },
                            )),
                        Text(
                          "Keep me logged in",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xff6789c6),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                )
                                // backgroundC: Color.fromARGB(255, 238, 146, 26),
                                ),
                            onPressed: () {
                              LoginController.instance
                                  .signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                      controller.rememberMe.value);
                            },
                            child: controller.isLoading.isTrue
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => controller.googleSignInMethod(),
                      child: Container(
                        child: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.cover,
                          width: 72,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        controller.facebookSignInMethod();
                      },
                      child: Container(
                        child: Image.asset(
                          "assets/Facebook3d.png",
                          fit: BoxFit.cover,
                          width: 78,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      child: Text(
                        "Sign Up",
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
