import 'package:flutter/material.dart';
import '../components/components.dart';

class ReloadScreen extends StatelessWidget {
  final String error;
  final Future<void> Function() reload;

  const ReloadScreen({required this.error, required this.reload, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(
              fontSize: 16,
              color: AppColorsDark.withColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: AppColorsDark.buttonStyle,
            onPressed: reload,
            child: const Text('Recarregar'),
          ),
        ],
      ),
    );
  }
}
