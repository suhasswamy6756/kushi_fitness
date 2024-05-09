import 'package:flutter/material.dart';

class ReferalPage extends StatefulWidget {
  const ReferalPage({super.key});

  @override
  State<ReferalPage> createState() => _ReferalPageState();
}

class _ReferalPageState extends State<ReferalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer and earn"),
      ),
        body: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                    child: Card(
                      child: ListTile(
                        title: Text("earnings"),
                        subtitle: Text("2 Coins"),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Referal Code"),
                      subtitle: Text("nfodnioaero9430hgwioh09w"),
                      trailing:
                          IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            "invite your friends to our app and earn 2 coins when they regoster with referal code",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              String shareLink =
                                  "Hey! use this app to do and earn 2 coiins worth fo 50 rupees";
                            },
                            child: Text("share Link"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("referals"),
                        Text("30"),
                      ],
                    ),
                  ),
                  ...List.generate(4, (index) {
                    return Container(
                      height: 50,
                      child: ListTile(
                        leading: CircleAvatar(),
                        title: const Text("email Address"),
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
