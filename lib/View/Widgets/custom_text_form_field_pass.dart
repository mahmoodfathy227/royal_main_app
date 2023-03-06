import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormFieldPass extends StatefulWidget {

  final String? text;
  final double fontSize;
  final String? hintText;
  final String? icon;
  final Color? iconColor;
  final fontFamily;
  var validator;
  var keyboardType;
  var onSaved;
  final String? helperText;
  final String initialValue;
  var onEditingCompelete;
  var textInputAction;
  bool obscureText;

  TextEditingController? controller;

  CustomTextFormFieldPass(
      {Key? key, this.text,
        this.hintText,
        this.fontFamily = "SF Pro Display",
        this.fontSize = 14,
        this.validator,
        this.keyboardType,
        this.onSaved,
        this.helperText,
        this.initialValue = "",
        this.onEditingCompelete,
        this.textInputAction,
        this.icon,
        this.iconColor,
        this.controller,
        this.obscureText = true}) : super(key: key);

  @override
  _CustomTextFormFieldPassState createState() => _CustomTextFormFieldPassState();
}

class _CustomTextFormFieldPassState extends State<CustomTextFormFieldPass> {


  void _toggle() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            validator: widget.validator,
            keyboardType: TextInputType.visiblePassword,
            onSaved: widget.onSaved,
            cursorColor: Colors.black,
            obscureText: widget.obscureText,
            obscuringCharacter: "*",
            controller: widget.controller,
            style: TextStyle(
              color: Colors.black,
              fontSize: widget.fontSize,
            ),
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SvgPicture.asset(widget.icon!, color: widget.iconColor ,width: 25.w),
              ),
              suffixIcon: ElevatedButton(
                onPressed: _toggle,
                child: widget.obscureText? Image.asset("assets/icons/hide.png", color: Colors.grey, width: 25.w,):Image.asset("assets/icons/visibility.png", color: Colors.grey,width: 25.w,),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.black45, fontSize: 22.sp, fontWeight: FontWeight.w600,),
              contentPadding: EdgeInsets.all(18.r),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}