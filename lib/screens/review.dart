import 'package:euphoria/configuration.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Review extends StatefulWidget {
  final String mid;
  final dynamic dt;
  const Review({Key? key, required this.mid, required this.dt})
      : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final rcontroller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    rcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dt["name"]),
        backgroundColor: bgPrimeDark,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('movies')
                      .doc(widget.mid)
                      .collection('reviews')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs[i]['photo']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: Container(
                                          width: 200,
                                          child: Text(
                                            snapshot.data!.docs[i]['text'],
                                            style: TextStyle(
                                                color: textPrimeDark,
                                                fontSize: 16),
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: textPrimeDark),
                    decoration: InputDecoration(
                      fillColor: textPrimeDark.withOpacity(0.3),
                      filled: true,
                      focusColor: textPrimeDark,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          borderSide: BorderSide(width: 0)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          borderSide: BorderSide(width: 0)),
                    ),
                    controller: rcontroller,
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('movies')
                          .doc(widget.mid)
                          .collection("reviews")
                          .add({
                        "name": user.displayName,
                        "text": rcontroller.text,
                        "photo": user.photoURL.toString()
                      });
                      rcontroller.text = "";
                    },
                    child: Text('Send')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
