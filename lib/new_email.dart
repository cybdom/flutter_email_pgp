import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_pgp/email.dart';
import 'package:flutter_email_pgp/encryption.dart';
import 'package:flutter_email_pgp/global.dart';

class NewEmailScreen extends StatefulWidget {
  final EmailClient emailClient;
  const NewEmailScreen({super.key, required this.emailClient});

  @override
  State<NewEmailScreen> createState() => _NewEmailScreenState();
}

class _NewEmailScreenState extends State<NewEmailScreen> {
  late String publicKey;
  final TextEditingController recepientEmailController =
          TextEditingController(),
      subjectController = TextEditingController(),
      publicKeyController = TextEditingController(),
      contentEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: AppBar(
        backgroundColor: MyColors.lightBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "To:",
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MyColors.white),
              controller: recepientEmailController,
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(
                labelText: "Subject:",
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MyColors.white),
              controller: subjectController,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Import your public key...",
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: MyColors.white),
                    controller: publicKeyController,
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(MyColors.blue),
                  ),
                  child: const Text("Import"),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                    );
                    if (result != null) {
                      final file = File(result.files.first.path!);

                      publicKey = await file.readAsString();
                      publicKeyController.text = publicKey;
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 5,
                controller: contentEmailController,
                decoration: const InputDecoration(
                  labelText: "Content",
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: MyColors.white),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(MyColors.blue),
                ),
                child: const Text("Send"),
                onPressed: () async {
                  Encryption encryption = Encryption();
                  final encryptedMessage = await encryption.encrypt(
                      publicKey, contentEmailController.text);

                  widget.emailClient.sendEmails(
                    message: widget.emailClient.buildMessage(
                      senderEmail: widget.emailClient.mailClient.account.email!,
                      recipientEmail: recepientEmailController.text,
                      content: encryptedMessage,
                      subject: subjectController.text,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
