import 'package:flutter/material.dart';
import '../configuration.dart';
import './review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie extends StatelessWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: bgPrimeDark,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('New Arrival'),
              background: Image.network(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.fsiGggqFoFp6hQ2lgqtlcgHaEK%26pid%3DApi&f=1',
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('movies').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                            child: InkWell(
                          onTap: () => {},
                          child: Container(
                            color: textSecondDark,
                            child: const Text('Loading'),
                          ),
                        ));
                      },
                      childCount: 1,
                    ),
                  );
                }
                ;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // print(snapshot.data!.docs[1].data());
                      return Container(
                        child: InkWell(
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Review(
                                          mid: snapshot.data!.docs[index].id,
                                          dt: snapshot.data!.docs[index]
                                              .data()),
                                    ),
                                  ),
                                },
                            child: Container(
                                color: textSecondDark,
                                child: Image.network(
                                  snapshot.data!.docs[index]['img'],
                                  fit: BoxFit.cover,
                                ))),
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                );
              })
        ],
      ),
    );
  }
}
