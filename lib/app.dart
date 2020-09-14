import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'classes/menu.dart';
import 'classes/nav_controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<WebViewController> controller =
      Completer<WebViewController>(); // web controller
  final Set<String> _likedUrl = Set<String>(); //<String>{}; //init an empty set
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WebView'),
        actions: [
          NavControllers(webViewController: controller.future),
          Menu(controller.future, () => _likedUrl),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://flutter.dev/',
          onWebViewCreated: (WebViewController webViewController) {
            controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      floatingActionButton: WebViewHelper.bookmarkThisUrl(
          controller: controller, likedUrl: _likedUrl),
    );
  }

//  FutureBuilder<WebViewController> _bookmarkThisUrl() {
//    return FutureBuilder<WebViewController>(
//      future: controller.future,
//      builder: (context, AsyncSnapshot<WebViewController> snapshot) {
//        if (!snapshot.hasData) {
//          return Container();
//        }
//        return FloatingActionButton(
//          onPressed: () async {
//            var url = await snapshot.data.currentUrl();
//            _likedUrl.add(url);
//            Scaffold.of(context).showSnackBar(
//                SnackBar(content: Text('Saved $url for any time to read')));
//          },
//          child: Icon(Icons.favorite),
//        );
//      },
//    );
//  }
}
