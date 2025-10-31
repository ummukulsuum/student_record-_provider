import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// ✅ Safe image picker (renames file to avoid emoji/special char errors)
Future<File?> pickImage() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked == null) return null;

  // Rename file to avoid crash when displaying (no emoji in name)
  final directory = Directory.systemTemp;
  final newPath =
      '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  final safeFile = await File(picked.path).copy(newPath);

  return safeFile;
}

/// ✅ Show error dialog
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.teal)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}

/// ✅ Reusable text field widget
Widget buildTextField(
  TextEditingController controller,
  String hint,
  IconData icon, {
  bool isNumber = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.teal, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    ),
  );
}
