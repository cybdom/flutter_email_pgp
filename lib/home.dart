import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_pgp/details.dart';
import 'package:flutter_email_pgp/email.dart';
import 'package:flutter_email_pgp/global.dart';
import 'package:flutter_email_pgp/new_email.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  final EmailClient emailClient;
  const HomeScreen({super.key, required this.emailClient});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MimeMessage>> readEmails;
  @override
  void initState() {
    readEmails = widget.emailClient.readEmails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MyColors.black,
        appBar: AppBar(
          backgroundColor: MyColors.lightBlack,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2016/11/29/03/52/man-1867175_960_720.jpg"),
            )
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "All",
              ),
              Tab(
                text: "Social",
              ),
              Tab(
                text: "Promotions",
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColors.lightBlack,
          selectedItemColor: MyColors.blue,
          unselectedItemColor: MyColors.lighterBlack,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.email), label: "Email"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "To Write"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ],
          onTap: (i) {
            if (i == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewEmailScreen(
                    emailClient: widget.emailClient,
                  ),
                ),
              );
            }
          },
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: readEmails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      message: snapshot.data![index],
                                    ))),
                        contentPadding: const EdgeInsets.all(12.0),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2016/11/29/03/52/man-1867175_960_720.jpg",
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data?[index].fromEmail ?? "no email",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: MyColors.white),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              snapshot.data?[index].decodeSubject() ??
                                  "no content",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: MyColors.white),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeago.format(
                                  snapshot.data?[index].decodeDate() ??
                                      DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: MyColors.darkWhite),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Placeholder(
                  child: Text("2"),
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Placeholder(
                  child: Text("3"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
