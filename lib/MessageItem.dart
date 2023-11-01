import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  // const MessageItem({Key? key}) : super(key: key);
  const MessageItem(
      {Key? key, this.name, required this.sentByMe, required this.message})
      : super(key: key);

  final String? name;
  final bool sentByMe;
  final String message;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  double leftmargin = 0;
  double rightmargin = 0;

  @override
  void initState() {
    leftmargin = widget.sentByMe ? 150 : 10;
    rightmargin = widget.sentByMe ? 10 : 150;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            widget.sentByMe ? 0 : 8,
          ),
          topLeft: Radius.circular(
            widget.sentByMe ? 8 : 0,
          ),
          bottomLeft: const Radius.circular(8),
          bottomRight: const Radius.circular(8),
        ),
        color: widget.sentByMe ? Colors.white : Colors.purple,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .75),
      // , right: rightmargin, left: leftmargin),

      // child: Column(
      //   children: [
      //     // TextSpan(
      //     //   text: "",
      //     // ),
      //     RichText(
      //       text: TextSpan(
      //         text: widget.name.toString(),
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //           color: widget.sentByMe ? Colors.purple : Colors.white,
      //         ),
      //       ),
      //     ),
      //     RichText(
      //       text: TextSpan(
      //         text: widget.message.toString(),
      //         style: TextStyle(
      //           // fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //           color: widget.sentByMe ? Colors.purple : Colors.white,
      //         ),
      //       ),
      //     ),
      //     RichText(
      //       text: TextSpan(
      //         text: "1:10 am",
      //         style: TextStyle(
      //           // fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //           color: widget.sentByMe ? Colors.purple : Colors.white,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      child: RichText(
        // textAlign: Tex,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        // textBaseline: TextBaseline.alphabetic,
        // children: [
        text: TextSpan(
          text: "${widget.name.toString()} : ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: widget.sentByMe ? Colors.purple : Colors.white,
          ),
          // ),
          children: [
            TextSpan(
              text: widget.message,
              // maxLines: 10,
              style: TextStyle(
                fontSize: 18,
                color: widget.sentByMe ? Colors.purple : Colors.white,
              ),
            ),
            // SizedBox(
            //   width: 5,
            // ),
            // TextAlignVertical.top
            TextSpan(
              text: "  1:10 am",
              style: TextStyle(
                fontSize: 10,
                color: (widget.sentByMe ? Colors.purple : Colors.white)
                    .withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
