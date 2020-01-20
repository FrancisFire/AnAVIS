import 'package:anavis/views/widgets/painter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MessagePainter extends StatefulWidget {
  final bool isGood;
  final String positiveTitle;
  final String positiveMsg;
  final String negativeTitle;
  final String negativeMsg;
  final Function onPressed;
  const MessagePainter({
    @required this.isGood,
    this.positiveMsg,
    this.negativeMsg,
    this.positiveTitle,
    this.negativeTitle,
    @required this.onPressed,
  });

  @override
  _MessagePainterState createState() => _MessagePainterState();
}

class _MessagePainterState extends State<MessagePainter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: Painter(
          first: widget.isGood ? Colors.green[200] : Colors.red[200],
          second: widget.isGood ? Colors.green[300] : Colors.red[300],
          background: widget.isGood ? Colors.green : Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                widget.isGood
                    ? this.widget.positiveTitle
                    : this.widget.negativeTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  backgroundColor:
                      widget.isGood ? Colors.green[900] : Colors.red[900],
                  color: Colors.white,
                  fontSize: 64,
                ),
                maxLines: 1,
              ),
              SizedBox(
                height: 16,
              ),
              AutoSizeText(
                widget.isGood
                    ? this.widget.positiveMsg
                    : this.widget.negativeMsg,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        hoverElevation: 22,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: this.widget.isGood ? Colors.green : Colors.red,
          size: 42,
        ),
        onPressed: this.widget.onPressed,
      ),
    );
  }
}
