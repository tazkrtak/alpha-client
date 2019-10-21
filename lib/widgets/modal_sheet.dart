import 'package:flutter/material.dart';
import 'package:tazkrtak/widgets/modal_tile.dart';

class ModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ModalTile(
            textKey: 'switch_language',
            icon: Icons.language,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ModalTile(
            textKey: 'switch_theme',
            icon: Icons.invert_colors,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ModalTile(
            textKey: 'help',
            icon: Icons.help_outline,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ModalTile(
            textKey: 'send_feedback',
            icon: Icons.feedback,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

}