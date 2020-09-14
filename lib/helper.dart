import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper {
  static FutureBuilder<WebViewController> bookmarkThisUrl(
      {@required Completer<WebViewController> controller,
      Set<String> likedUrl}) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, AsyncSnapshot<WebViewController> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return FloatingActionButton(
          onPressed: () async {
            var url = await snapshot.data.currentUrl();
            likedUrl.add(url);
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for any time to read')));
          },
          child: Icon(Icons.favorite),
        );
      },
    );
  }

  static void navigate(BuildContext context, WebViewController webController,
      {goBack: false}) async {
    bool canNav = goBack
        ? await webController.canGoBack()
        : await webController.canGoForward();
    if (canNav) {
      goBack ? webController.goBack() : webController.goForward();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('No ${goBack ? 'Back' : 'Forward'} History Item')));
    }
  }

  static void ifCanLaunchingUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
          'mailto:TypeYourEmailHere?subject=Check out new flutter discover&body=$url');
    } else {
      throw 'Could not launch $url';
    }
  }
}
