import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../contants.dart';
import 'custom_button.dart';
class DeleteDialog extends StatelessWidget {
   DeleteDialog({Key? key, required this.DeleteFunction}) : super(key: key);
final VoidCallback DeleteFunction;
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
            height: 230.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            padding: EdgeInsets.fromLTRB(15.r, 15.r, 15.r, 15.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Are you sure to Delete ?",
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Center(
                        child: SizedBox(
                          width: 100.w,
                          height: 60.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:  Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.r))),
                            ),
                            onPressed: () async{
DeleteFunction();

                            },
                            child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ),
                     SizedBox(width: 5,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Center(
                        child: SizedBox(
                          width: 100.w,
                          height: 60.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffF5F7FE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.r))),
                            ),
                            onPressed: () async{
Navigator.of(context).pop();

                            },
                            child: Text(
                                "No",
                                style: TextStyle(
                                  color: AppColors().defaultColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),




              ],
            ),
          ),
        ],
      ),
    );
  }
}
