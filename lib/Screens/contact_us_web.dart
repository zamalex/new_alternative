import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsWeb extends StatelessWidget {
  const ContactUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/5c13c5e5-7a8b-4813-aabe-fc8e2ce911d9'));

    return Scaffold(
      appBar: AppBar(title: const Text('Contact us')),
      body: WebViewWidget(controller: controller),
    );
  }
}
