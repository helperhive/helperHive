import 'package:flutter/material.dart';

class Review {
  final String reviewerName;
  final double rating;
  final String comment;

  Review(
      {required this.reviewerName,
      required this.rating,
      required this.comment});
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.reviewerName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
