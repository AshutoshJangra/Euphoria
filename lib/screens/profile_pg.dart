import 'package:euphoria/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: bgPrimeDark,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: textPrimeDark.withOpacity(0.1)),
            height: 200,
            padding: EdgeInsets.only(bottom: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL.toString()),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.displayName.toString(),
                  style: TextStyle(color: textPrimeDark, fontSize: 16),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: TextStyle(color: textSecondDark, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.email.toString(),
                      style: TextStyle(color: textPrimeDark, fontSize: 16),
                    ),
                  ],
                ),
                Divider(),
                TextButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.pink[400]),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
