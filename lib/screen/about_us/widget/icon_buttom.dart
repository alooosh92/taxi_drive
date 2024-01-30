import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class IconButtonDef extends StatelessWidget {
  const IconButtonDef({
    super.key,
    required this.icon,
    required this.url,
  });
  final IconData icon;
  final String url;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          launchUrl(
            Uri.parse(url),
          );
        },
        icon: FaIcon(icon));
  }
}
