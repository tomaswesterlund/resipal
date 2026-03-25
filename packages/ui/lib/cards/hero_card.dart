// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final String title;
  final String? description;

  const HeroCard({Key? key, required this.title, required this.description})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green[50],
              child: Icon(
                Icons.home_work_rounded,
                size: 40,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
