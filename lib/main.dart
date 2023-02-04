import 'package:app_share/image_show.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = "";
  String subject = "";
  List<String> imagePaths = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: "Text:", hintText: "Enter your text here"),
              onChanged: (val) {
                setState(() {
                  text = val;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Subject:", hintText: "Enter your subject here"),
              onChanged: (val) {
                setState(() {
                  subject = val;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageShowcase(
              imagePaths: imagePaths,
              onDelete: delete,
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add image"),
              onTap: () async {
                final imagePicker = ImagePicker();
                final pickFile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (pickFile != null) {
                  setState(() {
                    imagePaths.add(pickFile.path);
                  });
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed:
                    text.isEmpty && imagePaths.isEmpty ? null : () => share(),
                child: const Text("Share"))
          ],
        ),
      ),
    );
  }

  void share() async {
    if (imagePaths.isEmpty) {
      await Share.share(text, subject: subject);
    } else {
      await Share.shareFiles(imagePaths, text: text, subject: subject);
    }
  }

  void delete(int position) {
    setState(() {
      imagePaths.removeAt(position);
    });
  }
}
