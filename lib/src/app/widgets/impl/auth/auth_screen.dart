import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

///
/// ACTIONS
///
class AuthLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        key:Key('logout'),
        title: Text(
          'Sign Out',
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppTheme.darkText,
          ),
          textAlign: TextAlign.left,
        ),
        trailing: Icon(
          Icons.power_settings_new,
          color: Colors.red,
        ),
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(AuthFailedEvent());
        },
      ),
    );
  }
}

class AuthLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      label: Text('Sign in with Google',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
      color: Colors.redAccent,
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(AuthLoginWithGoogleEvent());
      },
    );
  }
}

///
/// EFFECTIVE SCREEN
///


class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      // color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          // backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/helpImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Image.asset(
                  'assets/images/img_sl_logo_full.png',
                  width: 200,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'The Breaking News App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: const Text(
                  'It looks like you want to use our news application.  Have fun and let\'s get in touch with us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: AuthLoginButton(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
