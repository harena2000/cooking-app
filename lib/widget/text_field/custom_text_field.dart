import 'package:animate_do/animate_do.dart';
import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final double? size;
  final IconData icon;
  final IconData? suffixIcon;
  final Color? hintColor;
  final Color? textColor;
  final Color? backgroundColor;
  final TextInputType? inputType;
  final bool? obscureText;
  final bool? onExit;
  final int? duration;
  final bool? enableInput;
  final String? Function(String?)? validator;
  final void Function(String value)? onChange;
  final TextEditingController? controller;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.hintColor,
      this.textColor,
      this.backgroundColor,
      this.size,
      this.inputType,
      this.obscureText = false,
      this.onExit = false,
      this.duration,
      this.onChange,
      this.suffixIcon,
      this.enableInput = true,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return !widget.onExit!
        ? FadeInLeft(
            duration: Duration(milliseconds: widget.duration ?? 350),
            child: TextFormField(
              controller: widget.controller,
              scrollPhysics: const BouncingScrollPhysics(),
              validator: (value) => widget.validator!(value),
              onChanged: (value) => widget.onChange!(value),
              keyboardType: widget.inputType ?? TextInputType.text,
              obscureText:
                  widget.obscureText! ? passwordVisible : widget.obscureText!,
              enabled: widget.enableInput,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  color: widget.hintColor ?? AppColor.lightGrey,
                ),
                suffixIcon: widget.obscureText!
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: passwordVisible
                            ? Icon(
                                FontAwesomeIcons.eye,
                                size: 14,
                                color: widget.hintColor ?? AppColor.lightGrey,
                              )
                            : Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 14,
                                color: widget.hintColor ?? AppColor.lightGrey,
                              ))
                    : null,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.hintColor ?? AppColor.lightGrey,
                    fontSize: widget.size ?? 13),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(50),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, style: BorderStyle.solid, color: Colors.red),
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                filled: true,
                fillColor: widget.backgroundColor ?? AppColor.grey,
              ),
              style: TextStyle(
                  color: widget.enableInput!
                      ? (widget.textColor ?? AppColor.darkBlue)
                      : AppColor.lightGrey,
                  fontSize: widget.size ?? 13),
            ))
        : FadeOutRight(
            duration: Duration(milliseconds: widget.duration ?? 350),
            child: TextFormField(
              keyboardType: widget.inputType ?? TextInputType.text,
              obscureText: widget.obscureText!,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  color: widget.hintColor ?? AppColor.lightGrey,
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.hintColor ?? AppColor.lightGrey,
                    fontSize: widget.size ?? 13),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                isDense: true,
                filled: true,
                fillColor: widget.backgroundColor ?? AppColor.grey,
              ),
              style: TextStyle(
                  color: widget.textColor ?? AppColor.darkBlue,
                  fontSize: widget.size ?? 13),
            ));
  }
}
