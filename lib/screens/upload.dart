import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoria/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController icontroller = TextEditingController();
    final TextEditingController tcontroller = TextEditingController();
    final TextEditingController gcontroller = TextEditingController();
    final TextEditingController scontroller = TextEditingController();
    final TextEditingController pcontroller = TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;

    CollectionReference threads =
        FirebaseFirestore.instance.collection('threads');

    Future<void> addThread() {
      return threads.add({
        'img': icontroller.text,
        'name': tcontroller.text,
        'root': pcontroller.text,
        'text': scontroller.text,
        'genre': gcontroller.text,
      }).then((value) {
        final snackBar = SnackBar(content: Text('New Story Added'));
        icontroller.text = "";
        tcontroller.text = "";
        pcontroller.text = "";
        scontroller.text = "";
        gcontroller.text = "";
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((err) => print(err));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
        elevation: 0,
        leading: const Icon(Icons.create_rounded),
        backgroundColor: bgPrimeDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  TextField(
                    controller: icontroller,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: 'Image URL',
                      fillColor: textPrimeDark.withOpacity(0.2),
                      focusColor: textSecondDark,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: textSecondDark,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimeDark,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: tcontroller,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: 'Thread Title',
                      fillColor: textPrimeDark.withOpacity(0.2),
                      focusColor: textSecondDark,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: textSecondDark,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimeDark,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: gcontroller,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: 'Genre or Preffered Theme',
                      fillColor: textPrimeDark.withOpacity(0.2),
                      focusColor: textSecondDark,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: textSecondDark,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimeDark,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: scontroller,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: 'Summary',
                      fillColor: textPrimeDark.withOpacity(0.2),
                      focusColor: textSecondDark,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: textSecondDark,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimeDark,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: pcontroller,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: 'Write Something...',
                      fillColor: textPrimeDark.withOpacity(0.2),
                      focusColor: textSecondDark,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: textSecondDark,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimeDark,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: addThread,
                    icon: Icon(Icons.file_upload_rounded),
                    label: Text('Upload'),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10)),
                      backgroundColor: MaterialStateProperty.all(bgPrimeDark),
                      foregroundColor: MaterialStateProperty.all(textPrimeDark),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
