import 'package:flutter/material.dart';

class CutomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isObscure;

  const CutomTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.validator,
    this.controller,
    this.isObscure = false,
  }) : super(key: key);

  @override
  State<CutomTextField> createState() => _CutomTextFieldState();
}

class _CutomTextFieldState extends State<CutomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscure,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          label: Text(widget.label),
          isDense: true,
          suffixIcon: widget.isObscure
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
