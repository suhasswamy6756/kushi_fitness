import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kushi_3/components/message.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:pinput/pinput.dart';
import 'package:share_plus/share_plus.dart';

class ReferalPage extends StatefulWidget {
  const ReferalPage({super.key});

  @override
  State<ReferalPage> createState() => _ReferalPageState();
}

class _ReferalPageState extends State<ReferalPage> {
  CollectionReference profileRef =
      FirebaseFirestore.instance.collection("RefernEarn");
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Refer and earn"),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: profileRef
                .where("refCode",
                    isEqualTo: _firestoreService.getCurrentUserId())
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data!.docs[0];
              final earnings = data.get("refEarnings");
              List referalsList = data.get("referrals");
              final refCode = data.get("refCode");
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 40, 20),
                              child: Card(
                                child: ListTile(
                                  title: Text("earnings"),
                                  subtitle: Text("coins $earnings"),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            Card(
                              child: ListTile(
                                title: Text("Referal Code"),
                                subtitle: Text(refCode),
                                trailing: IconButton(
                                    onPressed: () {
                                      ClipboardData data =
                                          ClipboardData(text: refCode);
                                      showMessage(context, "Ref code copied");
                                    },
                                    icon: Icon(Icons.copy)),
                              ),
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            Card(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "invite your friends to our app and earn 2 coins when they regoster with referal code",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        String shareLink =
                                            "Hey! use this app to do and earn 2 coiins worth fo 50 rupees after using my ref code ref code : $refCode ";
                                        Share.share(shareLink);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("referals"),
                                  Text("${referalsList.length}"),
                                ],
                              ),
                            ),
                            if (referalsList.isEmpty) Text("No referrals"),
                            ...List.generate(referalsList.length, (index) {
                              final data = referalsList[index];
                              return Container(
                                height: 50,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(data),
                                ),
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
