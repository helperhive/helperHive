import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  final String text;
  final int maxlines;
  final int minlines;

  const ShowMoreText({
    super.key,
    required this.text,
    this.minlines = 3,
    this.maxlines = 10,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _showMore = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.text,
          style: DefaultTextStyle.of(context).style,
        );

        final tp = TextPainter(
          text: span,
          maxLines: widget.minlines,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        bool showSeeMore = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: _showMore ? widget.minlines : widget.maxlines,
              overflow: TextOverflow.ellipsis,
            ),
            if (showSeeMore) const SizedBox(height: 8),
            if (showSeeMore)
              InkWell(
                onTap: () {
                  setState(() {
                    _showMore = !_showMore;
                  });
                },
                child: Text(
                  _showMore ? 'Show More' : 'Show Less',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
