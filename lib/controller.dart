import 'dart:convert';

// import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/screen_login.dart';

import 'helper.dart';
import 'screen_home.dart';
import 'task_model.dart';
import 'user_model.dart';

class RegistrationController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final title = TextEditingController().obs;
  final Description = TextEditingController().obs;
  DateTime? dueDate;
  RxBool laoding = false.obs;
  bool hasLocationPermission = false;
  double? lat;
  double? lng;
  RxString minTemp = ''.obs;
  RxString maxTemp = ''.obs;

  void signup() async {
    var email = emailController.value.text.trim();
    var password = passwordController.value.text.trim();
    try {
      laoding.value = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user!.sendEmailVerification();
        var id = value.user!.uid;
        Users user = Users(
          id: id,
          name: nameController.value.text.trim(),
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim(),
          timeStamp: DateTime.now().millisecondsSinceEpoch,
        );
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.id)
            .set(user.toMap())
            .then((value) async {
          laoding.value = false;
          Get.offAll(LoginScreen());
          Get.snackbar("Alert", "User Register");
        });
      });
    } on FirebaseAuthException catch (e) {
      laoding.value = false;
      switch (e.code) {
        case 'invalid-email':
          Get.snackbar('Alert', 'invalid email',
              backgroundColor: Colors.transparent,
              colorText: Colors.white,
              overlayBlur: 2.0,
              overlayColor: Colors.red.withOpacity(0.3));
          break;
        case 'email-already-in-use':
          Get.snackbar('Alert', 'email is already in use',
              backgroundColor: Colors.transparent,
              colorText: Colors.white,
              overlayBlur: 2.0,
              overlayColor: Colors.red.withOpacity(0.3));
          break;
        default:
          Get.snackbar('Alert', e.toString(),
              backgroundColor: Colors.transparent,
              colorText: Colors.white,
              overlayBlur: 2.0,
              overlayColor: Colors.red.withOpacity(0.3));
      }
    }
  }

  void login() async {
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        laoding.value = true;
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
              (value) async {
            if (value.user!.emailVerified) {
              print("LogIn");
              laoding.value = false;

              Get.offAll(HomeScreen());
            } else {
              laoding.value = false;
              Get.snackbar('Alert', 'First verify Email',
                  backgroundColor: Colors.transparent,
                  colorText: Colors.black,
                  overlayBlur: 2.0,
                  overlayColor: Colors.red.withOpacity(0.2));
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        laoding.value = false;
        switch (e.code) {
          case 'user-not-found':
            Get.snackbar('Email not registered', '',
                backgroundColor: Colors.transparent,
                colorText: Colors.black,
                overlayBlur: 2.0,
                overlayColor: Colors.red.withOpacity(0.2));
            break;
          case 'wrong-password':
            Get.snackbar('Wrong Password', '',
                backgroundColor: Colors.transparent,
                colorText: Colors.black,
                overlayBlur: 2.0,
                overlayColor: Colors.red.withOpacity(0.2));
            break;
          default:
        }
      }
    }
  }

  void addTask() {
    String Title = title.value.text.trim();
    String desc = Description.value.text.trim();
    Task post = Task(
      title: Title,
      description: desc,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      uniqueKey: UniqueKey().toString(),
      dueDate: dueDate!.toString(),
      maxTemp: maxTemp.value,
      minTemp: minTemp.value, uid: uid,
    );
    postsRef.doc(post.uniqueKey.toString()).set(post.toMap()).then((value) {
      laoding.value = false;
    });
  }

  void UpdateTask(String id) {
    String Title = title.value.text.trim();
    String desc = Description.value.text.trim();
    postsRef.doc(id).update({'title': Title, 'description': desc});
  }

  Future<dynamic> fetchWeatherDetails(
      double latitude, double longitude, DateTime date) async {
    final baseUrl = 'https://api.weatherapi.com/v1/forecast.json';
    final apiKey =
        '97b9d748d1c34762aa0161212230807'; // Replace with your WeatherAPI API key

    final response = await http.get(Uri.parse(
        '$baseUrl?key=$apiKey&q=$latitude,$longitude&dt=${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final forecastList =
      jsonResponse['forecast']['forecastday'] as List<dynamic>;
      final weatherDetails = forecastList.firstWhere(
              (item) => DateTime.parse(item['date']).isAtSameMomentAs(date),
          orElse: () => null);

      return weatherDetails;
    } else {
      throw Exception('Failed to fetch weather details');
    }
  }

  void getWeatherDetails() async {
    final latitude = lat;
    final longitude = lng;
    final specificDate = dueDate;

    try {
      laoding.value = true;
      final weatherDetails =
      await fetchWeatherDetails(latitude!, longitude!, specificDate!);
      if (weatherDetails != null) {
        maxTemp.value =
        ('Hi Temperature: ${weatherDetails['day']['maxtemp_c']}°C');
        minTemp.value =
        ('Low Temperature: ${weatherDetails['day']['mintemp_c']}°C');
        addTask();
        // Get.back();
        print('Weather details for $specificDate:');
        print('Temperature: ${weatherDetails['day']['avgtemp_c']}°C');
        print('Max Temperature: ${weatherDetails['day']['maxtemp_c']}°C');
        print('Min Temperature: ${weatherDetails['day']['mintemp_c']}°C');
        print('Description: ${weatherDetails['day']['condition']['text']}');
      } else {
        laoding.value = false;
        print('No weather details found for $specificDate');
      }
    } catch (e) {
      laoding.value = false;
      print('Error fetching weather details: $e');
    }
  }

  Future<void> checkLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude;
      lng = position.longitude;
      hasLocationPermission = true;
      position = position;
      RegistrationController().update();
      hasLocationPermission = true;
    }
    if (permission == LocationPermission.denied) {
      requestLocationPermission();
    }
  }

  void requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      hasLocationPermission = true;
    } else if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      Get.defaultDialog(
          title: 'Alert',
          content: Text(
            'Please Allow Location to use App',
          ),
          onCancel: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          },
          onConfirm: () {
            openAppSettings();
          },
          barrierDismissible: false);
    }
  }

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLocationPermission();
    requestLocationPermission();
  }

  void openAppSettings() {
    // AppSettings.openAppSettings();
  }
}
