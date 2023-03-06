import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../contants.dart';
import '../Widgets/custom_button.dart';

class RescheduleDialog extends StatefulWidget {
  const RescheduleDialog({Key? key}) : super(key: key);

  @override
  State<RescheduleDialog> createState() => _RescheduleDialogState();
}

class _RescheduleDialogState extends State<RescheduleDialog> {

  DateTime _currentDateTo = DateTime.now();
  DateTime _currentTimeTo = DateTime.now();

  getDateTo(){
    String? date;
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(_currentDateTo);
    });
    return date;
  }

  getTimeTo(){
    String? time;
    time = DateFormat('h:mm a').format(_currentTimeTo);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10.r),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 430.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            padding: EdgeInsets.fromLTRB(15.r, 15.r, 15.r, 15.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reschedule To",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        dateDurationTo();
                      },
                      child: SizedBox(
                        width: 150.w,
                        height: 65.h,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/Date_icon.svg",
                                    width: 30.w,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    getDateTo(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        timeDurationTo();
                      },
                      child: SizedBox(
                        width: 150.w,
                        height: 65.h,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/Clock_icon.svg",
                                    width: 20.w,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    getTimeTo(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                TextFormField(
                  //onSaved: onSave,
                  //validator: validator,
                  maxLines: 4,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Add  Description",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.all(20.r),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: CustomButton(
                    text: "Submit",
                    onPressed: () {

                    },
                  ),
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future dateDurationTo(){
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors().defaultColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        getDateTo();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  backgroundColor: Colors.white,
                  onDateTimeChanged: (DateTime newdate) {
                    print(newdate);
                    _currentDateTo = newdate;
                  },
                  maximumDate: DateTime(2050, 12, 30),
                  minimumYear: 2010,
                  maximumYear: 2050,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ]);
      },
    );
  }

  Future timeDurationTo(){
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              backgroundColor: Colors.white,
              onDateTimeChanged: (DateTime newdate) {
                print(newdate);
                setState(() {
                  _currentTimeTo = newdate;
                });
              },
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.time,
            ),
          ),
        );
      },
    );
  }
}