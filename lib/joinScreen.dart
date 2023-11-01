import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class joinScreen extends StatefulWidget {
  const joinScreen({Key? key}) : super(key: key);

  @override
  State<joinScreen> createState() => _joinScreenState();
}

class _joinScreenState extends State<joinScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Container(
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.purple,
              controller: nameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // sendName(nameController.text);
                      print(nameController.text);
                      nameController.text = "";
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
