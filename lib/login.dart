import 'package:flutter/material.dart';
import 'package:flutter_email_pgp/email.dart';
import 'package:flutter_email_pgp/global.dart';
import 'package:flutter_email_pgp/home.dart';

//
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailFieldController = TextEditingController(),
        passwordFieldController = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Login",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: MyColors.white),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: emailFieldController,
              decoration: const InputDecoration(
                labelText: "Email Address",
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MyColors.white),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: passwordFieldController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MyColors.white),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                EmailClient emailClient = EmailClient();

                await emailClient
                    .connect(
                        email: emailFieldController.text,
                        password: passwordFieldController.text)
                    .then((value) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(emailClient: emailClient),
                          ),
                        ))
                    .onError(
                      (e, stacktrace) => showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          content: Text("Error while trying to login"),
                        ),
                      ),
                    );
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(MyColors.blue),
              ),
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
