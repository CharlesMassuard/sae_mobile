import 'package:flutter/material.dart';

class InfoButton extends StatefulWidget {
  final String infoText;

  const InfoButton({super.key, required this.infoText});

  @override
  InfoButtonState createState() => InfoButtonState();
}

class InfoButtonState extends State<InfoButton> {
  bool _isDialogOpen = false;

  void _toggleInfoDialog(BuildContext context) {
    if (_isDialogOpen) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Information'),
          content: Text(widget.infoText),
        ),
      ).then((_) {
        _isDialogOpen = false;
      });
    }
    _isDialogOpen = !_isDialogOpen;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () => _toggleInfoDialog(context),
    );
  }
}