import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPulsePower extends StatefulWidget {
  final String title;
  final String url;

  const WebPulsePower({
    Key? key,
    required this.url,
    required this.title,
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
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
