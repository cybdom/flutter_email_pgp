import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_flutter/enough_mail_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'global.dart';

class DetailsScreen extends StatelessWidget {
  final MimeMessage message;
  const DetailsScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: AppBar(
        backgroundColor: MyColors.lightBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    message.decodeSubject() ?? "(Empty)",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: MyColors.white),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  color: MyColors.white,
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(),
              title: Text(
                message.fromEmail ?? "(Empty)",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: MyColors.white),
              ),
              subtitle: message.decodeDate() != null
                  ? Text(
                      DateFormat.yMMMd().format(message.decodeDate()!),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: MyColors.darkWhite),
                    )
                  : Container(),
              trailing: IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: MimeMessageViewer(
                enableDarkMode: true,
                mimeMessage: message,
                blockExternalImages: false,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: MyColors.blue)),
                    onPressed: () {},
                    child: Text(
                      "Answer",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: MyColors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: MyColors.blue)),
                    onPressed: () {},
                    child: Text(
                      "Forward",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
