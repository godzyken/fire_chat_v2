import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatefulWidget {
  FormInputFieldWithIcon(
      {this.controller,
      this.iconPrefix,
      this.labelText,
      this.onValidator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.onChanged,
      this.onSaved});

  final TextEditingController? controller;
  final IconData? iconPrefix;
  final String? labelText;
  final String? Function(String?)? onValidator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  @override
  State<FormInputFieldWithIcon> createState() => _FormInputFieldWithIconState();
}

class _FormInputFieldWithIconState extends State<FormInputFieldWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(widget.iconPrefix),
          labelText: widget.labelText,
        ),
        controller: widget.controller,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        validator: widget.onValidator,
      ),
    );
  }
}
