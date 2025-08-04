import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextfield extends StatefulWidget {
  final String preIconStr;
  final String? sufIconStr;
  final String hintStr;
  final TextEditingController textEditingController;
  final bool obscureBool;

  const CustomTextfield({
    super.key,
    required this.hintStr,
    required this.obscureBool,
    required this.preIconStr,
    this.sufIconStr,
    required this.textEditingController,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureBool;

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      obscureText: _obscureText,
      style: Theme.of(context).textTheme.labelMedium,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(widget.preIconStr, width: 20, height: 20),
        ),
        suffixIcon: widget.sufIconStr != null
            ? GestureDetector(
                onTap: _toggleObscure,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    widget.sufIconStr!,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : null,
        hintText: widget.hintStr,
        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(
            context,
          ).textTheme.labelMedium?.color?.withOpacity(0.2 ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
