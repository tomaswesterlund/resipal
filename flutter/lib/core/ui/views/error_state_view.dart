// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ErrorStateView extends StatelessWidget {
  final String errorMessage;
  final Object? exception;

  const ErrorStateView({Key? key, required this.errorMessage, this.exception})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error sate view.'),);
  }
}
