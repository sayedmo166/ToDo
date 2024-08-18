import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../App_Theme.dart';
import '../../Models/task_model.dart';
import 'TasksProvider.dart';
import 'default_elevate_buttom.dart';
import 'default_text_form_filed.dart';
import 'editTask_tab.dart';
import 'firebase_service.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                'Add new Task',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppTheme.black),
              ),
            ),
            DefaultTextFiled(
              taskController: titlecontroller,
              hint: 'Enter task title',
              validate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'task title can not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 18.h,
            ),
            DefaultTextFiled(
              taskController: descriptionController,
              hint: 'Enter task description',
              maxlines: 3,
              validate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'task description can not be empty';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 35.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'select date :',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  InkWell(
                    child: Text(
                      dateFormat.format(selectedDate),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          initialDate: selectedDate,
                          initialEntryMode: DatePickerEntryMode.calendarOnly);

                      if (dateTime != null) {
                        selectedDate = dateTime;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            DefaultButton(
              lable: 'submit',
              onpress: () {
                if (formkey.currentState!.validate()) {
                  addtask();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void addtask() {
    FireBaseService.addtask(TaskModel(
        title: titlecontroller.text,
        description: descriptionController.text,
        date: selectedDate))
        .timeout(Duration(microseconds: 300), onTimeout: () {
      print('task added');
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getalltasks();
      Fluttertoast.showToast(
          msg: "Task added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 18.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed to add Task",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.red,
          textColor: Colors.white,
          fontSize: 18.0);
    });
  }
}