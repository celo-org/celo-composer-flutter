import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: const Center(
        child: CeloLinkText(),
      ),
    );
  }
}

class CeloLinkText extends StatelessWidget {
  const CeloLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          const TextSpan(text: 'Developed with 🖤 by the '),
          TextSpan(
            text: 'Celo',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL('https://celo.org');
              },
          ),
          const TextSpan(text: ' DevRel team.'),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
