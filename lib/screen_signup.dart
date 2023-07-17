import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_input_field1.dart';
import '../controller.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Obx(() {
          return CustomProgressWidget(
            loading: controller.laoding.value,
            child: SingleChildScrollView(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SvgPicture.asset(
                      'assets/images/signup.svg',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: CustomInputField1(
                        controller: controller.emailController.value,

                          hint: 'Email',
                          // Pad: EdgeInsets.only(left: 8.sp),
                          label: 'Email',
                        showBorder: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        borderType: InputBorderType1.outline,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "email is required";
                          } else if (value.isEmail) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: CustomInputField1(
                        controller: controller.nameController.value,

                          hint: 'Name',
                          label: 'Name',
                        showBorder: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        borderType: InputBorderType1.outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: CustomInputField1(
                        controller: controller.passwordController.value,

                          hint: 'Password',
                          label: ('Password'),
                        showBorder: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        borderType: InputBorderType1.outline,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: CustomInputField1(
                        controller: controller.confirmPasswordController.value,

                          hint: 'Confirm Password',
                          label: ('Confirm Password'),
                        showBorder: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        borderType: InputBorderType1.outline,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "confirmPassword is required";
                          } else if (value !=
                              controller.passwordController.value.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signup();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.sp, horizontal: 50.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
