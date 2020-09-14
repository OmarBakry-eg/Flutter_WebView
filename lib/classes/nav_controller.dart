import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavControllers extends StatelessWidget {
  final Future<WebViewController> webViewController;
  const NavControllers({@required this.webViewController})
      : assert(webViewController != null);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      builder: (context, AsyncSnapshot snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController webController = snapshot.data;
        return Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: webViewReady
                    ? () => WebViewHelper.navigate(context, webController,
                        goBack: true)
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: webViewReady
                    ? () => WebViewHelper.navigate(context, webController,
                        goBack: false)
                    : null),
          ],
        );
      },
      future: webViewController,
    );
  }
}
