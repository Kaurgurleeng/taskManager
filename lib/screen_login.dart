import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_input_field1.dart';

import '../controller.dart';
import 'screen_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var controller = Get.put(RegistrationController());

  bool _hasLocationPermission = false;

  @override


  Future<void> _checkLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final Position position = await Geolocator.getCurrentPosition();
      setState(() {
        controller.lat = position.latitude;
        controller.lng = position.longitude;
        _hasLocationPermission = true;
      });
    }
    else {
      Get.defaultDialog(
          title: 'Alert', content: Text('Allow location or app will closed '),
          onConfirm: (){
            _requestLocationPermission();
            if(_hasLocationPermission == true){
              Get.back();
            }
          },onCancel: (){Get.back();});

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return CustomProgressWidget(
            loading: controller.laoding.value,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SvgPicture.asset(
                      'assets/images/login.svg',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
                      child: CustomInputField1(
                        controller: controller.emailController.value,
                        hint: 'Email',
                        label: ('Email'),
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
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                          _checkLocationPermission();

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
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                        child: Text('New User | SignUp'))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      setState(() {
        _hasLocationPermission = true;
      });
    } else {
      Get.defaultDialog(
          title: 'Alert', content: Text('Allow location or app will closed '),
      onConfirm: (){
            _requestLocationPermission();
            if(_hasLocationPermission == true){
              Get.back();
            }
      },onCancel: (){Get.back();});

    }
  }
}
