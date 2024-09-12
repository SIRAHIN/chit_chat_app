import 'package:chat_app_using_firebase/components/my_text_field_widget.dart';
import 'package:chat_app_using_firebase/modules/home_view/controller/home_view_controller.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/services/auth_services/auth_services.dart';
import 'package:chat_app_using_firebase/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chit - Chat',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              AuthServices service = AuthServices();
              await service.signOut();
              Get.offAllNamed(RoutesName.loginView);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  // color: Colors.teal,
                  child: StreamBuilder(
                    stream: controller.getAllMessage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> listofDocs = snapshot.data!.docs;

                        return ListView.builder(
                          reverse: true,
                          itemCount: listofDocs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // get each individul doc
                            DocumentSnapshot documentSnapshot =
                                listofDocs[index];
                            String DocID = documentSnapshot.id;

                            // get note from each doc
                            Map<String, dynamic> featchMessages =
                                documentSnapshot.data() as Map<String, dynamic>;

                            bool isMyMessage = featchMessages['user-email'] ==
                                controller.auth.currentUser!.email;

                            return Column(
                              crossAxisAlignment: isMyMessage == true
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:  isMyMessage == true ? Colors.deepPurple : Colors.orangeAccent,
                                        borderRadius: isMyMessage == true
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))
                                            : null),
                                    padding: const EdgeInsets.all(10),
                                    //color: Colors.deepPurple,
                                    child: Text(
                                      '${featchMessages['message']}',
                                      style: customTextStyle(
                                          fontColor: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.waiting ||
                          snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Text('No Notes Founds');
                      }
                    },
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 40,
                    child: my_txt_field(
                      controller: controller.messageController,
                      isobscureText: false,
                      hintText: 'Type Something....',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(0),
                      color: Colors.deepPurple,
                      onPressed: () {
                        controller.sendMesaage();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.telegram,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
