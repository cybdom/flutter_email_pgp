import 'package:enough_mail/enough_mail.dart';

class EmailClient {
  late MailClient mailClient;
  Future<void> connect(
      {required String email, required String password}) async {
    final config = await Discover.discover(email);

    if (config == null) {
      throw Exception();
    }
    final account = MailAccount.fromDiscoveredSettings(
        'my account', email, password, config);
    mailClient = MailClient(account, isLogEnabled: true);
    try {
      await mailClient.connect();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MimeMessage>> readEmails() async {
    await mailClient.selectInbox();
    return await mailClient.fetchMessages(
        count: 20, fetchPreference: FetchPreference.full);
  }

  Future<void> sendEmails({required MimeMessage message}) async {
    return await mailClient.sendMessage(message);
  }

  MimeMessage buildMessage(
      {required String senderEmail,
      required String recipientEmail,
      String? subject,
      required String content}) {
    return MessageBuilder.buildSimpleTextMessage(MailAddress(null, senderEmail),
        [MailAddress(null, recipientEmail)], content,
        subject: subject);
  }
}
