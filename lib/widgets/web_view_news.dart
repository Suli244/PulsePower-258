import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPulsePower extends StatefulWidget {
  final String url;
  final String title;

  const WebPulsePower({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<WebPulsePower> createState() => _WebBlueScopeNewsState();
}

class _WebBlueScopeNewsState extends State<WebPulsePower> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
