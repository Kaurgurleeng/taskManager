import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_input_field1.dart';
import 'controller.dart';
import 'screen_home.dart';
import 'task_model.dart';

class TaskDetails extends StatefulWidget {
  Task task;
  String id;

  TaskDetails({super.key, required this.task,required this.id});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  var controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () async {
              setState(() {});
              Get.defaultDialog(
                title: 'Add Task',
                barrierDismissible: false,
                content: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Form(
                      key: _formKey,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomInputField1(
                                label: 'Title',
                                hint: 'Task Name',
                                controller: controller.title.value
                                  ..text = widget.task.title,
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
                                controller: controller.Description.value
                                  ..text = widget.task.description,
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


                  if (_formKey.currentState!.validate()) {
                    controller.UpdateTask(widget.id);
                  }
                  Get.offAll(HomeScreen());

                },
              );
            },
            child: Text('Modify'),
          ),
          SizedBox(
            width: 3.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                'Task title',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0.sp),
                width: MediaQuery.of(context).size.width,
                height: 50.sp,
                decoration: BoxDecoration(color: Color(0xfffaf2ee)),
                child: Text(
                  widget.task.title,
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                )),
            Divider(
              thickness: 1.sp,
              // thickness of the line
              // indent: 20, // empty space to the leading edge of divider.
              // endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.black,
              // The color to use when painting the line.
              height: 20, // The divider's height extent.
            ),
            SizedBox(
              height: 5.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                'Task Description',
                textAlign: TextAlign.left,
              ),
            ),
            CustomInputField1(
              margin: EdgeInsets.symmetric(vertical: 0.sp),
              readOnly: true,
              minLines: 1,
              maxLines: 5,
              fillColor: Color(0xfffaf2ee),
              showBorder: false,
              text: widget.task.description,
              textStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
            ),
            Divider(
              thickness: 1.sp,
              // thickness of the line
              // indent: 20, // empty space to the leading edge of divider.
              // endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.black,
              // The color to use when painting the line.
              height: 20, // The divider's height extent.
            ),
            SizedBox(
              height: 5.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                'Due Date',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0.sp),
                width: MediaQuery.of(context).size.width,
                height: 50.sp,
                decoration: BoxDecoration(color: Color(0xfffaf2ee)),
                child: Text(
                  ' ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.task.dueDate))}',
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                )),
            Divider(
              thickness: 1.sp,
              // thickness of the line
              // indent: 20, // empty space to the leading edge of divider.
              // endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.black,
              // The color to use when painting the line.
              height: 20, // The divider's height extent.
            ),
            SizedBox(
              height: 5.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                'Highest Temperature',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0.sp),
                width: MediaQuery.of(context).size.width,
                height: 50.sp,
                decoration: BoxDecoration(color: Color(0xfffaf2ee)),
                child: Text(
                  widget.task.maxTemp,
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                )),
            Divider(
              thickness: 1.sp,
              // thickness of the line
              // indent: 20, // empty space to the leading edge of divider.
              // endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.black,
              // The color to use when painting the line.
              height: 20, // The divider's height extent.
            ),
            SizedBox(
              height: 5.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                'Lowest Temperature',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0.sp),
                width: MediaQuery.of(context).size.width,
                height: 50.sp,
                decoration: BoxDecoration(color: Color(0xfffaf2ee)),
                child: Text(
                  widget.task.minTemp,
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                )),
            Divider(
              thickness: 1.sp,
              // thickness of the line
              // indent: 20, // empty space to the leading edge of divider.
              // endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.black,
              // The color to use when painting the line.
              height: 20, // The divider's height extent.
            ),
          ],
        ),
      ),
    );
  }
}
