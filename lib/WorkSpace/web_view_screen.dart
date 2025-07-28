// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({super.key, required this.url});
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          gradient: const LinearGradient(
              colors: [Color(0xff958b8d), Color(0xffd0c4bc)]),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "GooseNews",
              style: TextStyle(
                  color: Color(0xff241a17),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              width: 2,
            ),
            SvgPicture.asset(
              "images/Goose.svg",
              width: 30,
              height: 30,
              // ignore: deprecated_member_use
              color: const Color(0xff241a17),
            )
          ]),
          centerTitle: true,
        ),
        body: WebViewWidget(
            controller: WebViewController()..loadRequest(Uri.parse(url!))));
  }
}
