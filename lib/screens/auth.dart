import 'package:euphoria/configuration.dart';
import 'package:euphoria/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Euphoria',
                    style: TextStyle(
                        fontSize: 22,
                        color: textPrimeDark,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: Text(
                    'Create Your Own Multi Realities With Interactive Titles with Twilight Of The Bots',
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondDark,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: bgPrimeDark,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: textPrimeDark,
                  ),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  icon: Icon(Icons.gesture_rounded),
                  label: Text('Sign Up with Google'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Facing Issues ? Click Here',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondDark,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
