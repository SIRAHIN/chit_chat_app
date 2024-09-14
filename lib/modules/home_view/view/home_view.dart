import 'package:chat_app_using_firebase/components/my_text_field_widget.dart';
import 'package:chat_app_using_firebase/modules/home_view/controller/home_view_controller.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/services/auth_services/auth_services.dart';
import 'package:chat_app_using_firebase/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0.8,
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Chit - Chat - Room',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              AuthServices service = AuthServices();
              await service.signOut();
              Get.offAllNamed(RoutesName.loginView);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 16,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://preview.redd.it/o67iakxcon571.jpg?width=640&crop=smart&auto=webp&s=7a02178fce4a64e6e752cccca754fec2aaae04de'))),
        child: Column(
          children: [
            Expanded(
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
                        DocumentSnapshot documentSnapshot = listofDocs[index];
                        String DocID = documentSnapshot.id;

                        // get note from each doc
                        Map<String, dynamic> featchMessages =
                            documentSnapshot.data() as Map<String, dynamic>;

                        // chekcing is this my message or not //
                        bool isMyMessage = featchMessages['user-email'] ==
                            controller.auth.currentUser!.email;

                        // is Message or Image //
                        final imageUrl = featchMessages['imageUrl'] as String?;

                        return Column(
                          crossAxisAlignment: isMyMessage == true
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: imageUrl == null
                                  ? InkWell(
                                      onLongPress: () {
                                        // Only show the delete option if the message is from the current user
                                        if (isMyMessage) {
                                          Get.defaultDialog(
                                            onConfirm: () async {
                                              // Perform the delete operation
                                              controller.deleteMessage(DocID);

                                              Get.back();
                                            },
                                            title: 'Delete Message',
                                            middleText:
                                                'Are You Sure?',
                                            textCancel: 'Cancel',
                                            textConfirm: 'Yes',
                                            confirmTextColor: Colors.white,
                                            onCancel: () {
                                              // Optional: Handle cancel action if needed
                                              Get.back();
                                            },
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'You cannot delete someone else\'s message.',
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: isMyMessage == true
                                                  ? Colors.deepPurple
                                                  : Colors.green,
                                              borderRadius: isMyMessage == true
                                                  ? const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10))
                                                  : const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10))),
                                          padding: const EdgeInsets.all(10),
                                          //color: Colors.deepPurple,
                                          child: Text(
                                            '${featchMessages['message']}',
                                            style: customTextStyle(
                                                fontColor: Colors.white),
                                          )),
                                    )
                                  : Container(
                                      height: 230,
                                      width: 230,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageUrl),
                                        ),
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
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
                  IconButton(
                      onPressed: () {
                        controller.handleSendImage(ImageSource.camera);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(0),
                        color: Colors.deepPurple,
                        onPressed: () {
                          controller.handleSendMessage();
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
