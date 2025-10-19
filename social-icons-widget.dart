import 'dart:io';

import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/data_layer/models/app-config.dart';
import 'package:app/src/data_layer/models/social.dart';
import 'package:app/src/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: appConfigBloc.appConfigStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = (snapshot.data as AppConfig).socialArray;

            return Container(
              height: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildResults(results),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

List<Widget> _buildResults(List<Social> socials) {
  List<Widget> widgets = <Widget>[];

  for (var social in socials) {
    widgets.add(new SocialIconTile(
        name: social.name, imageUrl: social.imgUrl, data: social.data));
  }

  return widgets;
}

class SocialIconTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String data;

  SocialIconTile(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.data})
      : super(key: key);

  _launch(url) async {
    await canLaunch(url) ? launch(url) : print("Not supported");
  }

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow,
      highlightColor: Colors.blue,
      focusColor: Colors.red,
      onTap: () async {
        if (name == "Whatsapp") {
          if (Platform.isIOS) {
            _launch("whatsapp://wa.me/$data/?text=");
          } else {
            _launch('whatsapp://send?text=&phone=' + data);
          }
        }
        if (name == "Facebook") {
          _launchSocial('https://www.facebook.com/' + data,
              'https://www.facebook.com/' + data);

        }
        if (name == "Instagram") {
          _launchSocial(data, data);
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: shadowColor,
                blurRadius: 25.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                      child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      'assets/img/maleh_logo.png',
                      fit: BoxFit.cover,
                    ),
                    imageUrl: this.imageUrl,
                    width: 32,
                    height: 32,
                    fit: BoxFit.fill,
                    fadeInCurve: Curves.linearToEaseOut,
                    fadeOutCurve: Curves.easeInOutBack,
                  )),
                )),
          ),
          Text(name,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
