import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_input_field1.dart';
import 'package:task_manager/task_details.dart';

import '../controller.dart';
import 'helper.dart';
import 'screen_login.dart';
import 'task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Task List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //titlePadding: EdgeInsets.zero,
                      //actionsPadding: EdgeInsets.symmetric(horizontal: 25.sp),
                      title: Text(
                        "Confirm Logout",
                        style: TextStyle(fontFamily: "myfont"),
                      ),
                      content: Text("Are you sure you want ot logout"),
                      actions: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "myfont",
                                  fontSize: 16.sp),
                            )),
                        SizedBox(
                          width: 14.sp,
                        ),
                        GestureDetector(
                            onTap: () async {
                              Get.back();
                              var currentUser = FirebaseAuth.instance;
                              currentUser.signOut().then((value) {
                                // _prefs.clear();
                                controller.laoding.value = false;
                                Get.offAll(LoginScreen());
                              });
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "myfont",
                                  fontSize: 16.sp),
                            )),
                      ],
                    );
                  });
            },
            child: Text('LogOut'),
          ),
          SizedBox(
            width: 3.w,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsRef.where('uid',isEqualTo: uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator.adaptive(
                    // color: Colors.purpleAccent,
                    ));
          }
          // var posts = snapshot.data!.docs.map((e) => Posts.fromMap(e.data() as Map<String, dynamic>)).toList();
          var task = snapshot.data!.docs
              .map((e) => Task.fromMap(e.data() as Map<String, dynamic>))
              .toList();
          task.sort((a, b) {
            DateTime dueDateA = DateTime.parse(a.dueDate);
            DateTime dueDateB = DateTime.parse(b.dueDate);
            return dueDateA.compareTo(dueDateB);
          });
          return (task.isNotEmpty)
              ? ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (BuildContext context, int index) {
                    var pst = task[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                      ),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.green.withOpacity(0.2)),
                        child: ListTile(
                          onTap: () {
                            Get.to(TaskDetails(task: pst, id: pst.uniqueKey,));
                          },
                          title: Text(
                            "Title: ${pst.title}",
                            // style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          subtitle: Text(
                            'Due Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(pst.dueDate))}',
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                postsRef.doc(pst.uniqueKey).delete();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.requestLocationPermission();
          if (controller.lat != null) {
            Get.defaultDialog(
              title: 'Add Task',
              barrierDismissible: false,
              content: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomInputField1(
                              label: 'Title',
                              hint: 'Task Name',
                              controller: controller.title.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Title is required";
                                } else {
                                  return null;
                                }
                              },
                              showBorder: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              borderType: InputBorderType1.outline,
                            ),
                            CustomInputField1(
                              label: 'Description',
                              hint: 'About Task',
                              controller: controller.Description.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Description is required";
                                } else {
                                  return null;
                                }
                              },
                              showBorder: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              borderType: InputBorderType1.outline,
                            ),
                            GestureDetector(
                              onTap: () async {
                                DateTime? dates = (await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2090)))!;
                                controller.dueDate = dates;
                                print(dates.toString());
                                setState(() {});
                              },
                              child: CustomInputField1(
                                onTap: () async {
                                  DateTime? dates = (await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      Duration(days: 14),
                                    ),
                                  ))!;
                                  controller.dueDate = dates;
                                  print(dates.toString());
                                  setState(() {});
                                },
                                label: 'Date',
                                // hint: 'About Task',
                                readOnly: true,
                                showBorder: true,
                                controller: TextEditingController(
                                  text: controller.dueDate != null
                                      ? '${DateFormat('yyyy,MM,dd').format(DateTime.tryParse(controller.dueDate.toString())!)}'
                                      : 'Select Date',
                                ),

                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                borderType: InputBorderType1.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                setState(() {});
                print(
                    'longitude: ${controller.lng},,, latitude: ${controller.lat}');
                if (_formKey.currentState!.validate()) {
                  if (controller.dueDate != null) {
                    controller.getWeatherDetails();
                  } else {
                    Get.snackbar("Alert", "Please Pick Date");
                  }
                }
                Get.back();
              },
            );
          } else {}
          // controller.checkLocationPermission();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
