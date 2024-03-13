import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/service/firestore_service.dart';
import 'package:makki_tv_app/utils/awaiter.dart';

class ImageAnnouncementsView extends StatefulWidget {
  const ImageAnnouncementsView({super.key});

  @override
  State<ImageAnnouncementsView> createState() => _ImageAnnouncementsViewState();
}

class _ImageAnnouncementsViewState extends State<ImageAnnouncementsView> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('image_announcements')
      .orderBy('createdAt')
      .snapshots();
  File? _imageFile;
  bool isRemoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _imageFile == null
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () async {
                  try {
                    await Awaiter.process(
                      future: FireStoreService.addImageAnnouncementToDb(
                        _imageFile!,
                        "image_ann",
                      ),
                      context: context,
                      arguments: 'Uploading Image',
                    );

                    _imageFile = null;
                    setState(() {});
                  } catch (e) {}
                },
                child: Text(
                  "Upload",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
        appBar: AppBar(),
        body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: snapshot.data!.docs.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data!.docs.length) {
                    return GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: _imageFile != null
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(_imageFile!.path),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: IconButton.outlined(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                        Colors.white54,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.secondary,
                                    ),
                                    onPressed: () async {
                                      _imageFile = null;
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.secondary,
                                ),
                              ),
                              child: const Icon(Icons.add),
                            ),
                    );
                  } else {
                    Map<String, dynamic> data = snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>;
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                data['url'],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: IconButton.outlined(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.white54,
                              ),
                            ),
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.secondary,
                            ),
                            onPressed: () async {
                              try {
                                isRemoved = true;

                                setState(() {});
                                String link = data['url'];
                                await FireStoreService.delImgAnnouncement(
                                    snapshot.data!.docs[index].id);
                                await FirebaseStorage.instance
                                    .refFromURL(link)
                                    .delete();

                                isRemoved = false;

                                setState(() {});
                              } catch (e) {
                                isRemoved = false;

                                setState(() {});
                              }
                            },
                          ),
                        )
                      ],
                    );

                    Image.network(data['url']);
                  }
                },
              ),
            );
          },
        ));
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }
}
