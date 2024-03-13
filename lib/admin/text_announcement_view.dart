import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/admin/add_text_view.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/service/firestore_service.dart';

class TextAnnouncementsView extends StatefulWidget {
  const TextAnnouncementsView({super.key});

  @override
  State<TextAnnouncementsView> createState() => _TextAnnouncementsViewState();
}

class _TextAnnouncementsViewState extends State<TextAnnouncementsView> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('text_announcements')
      .orderBy('createdAt')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTextView(),
            ),
          );
        },
      ),
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                elevation: 5.0,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          data['txt'],
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTextView(
                                      title: data['txt'],
                                      docId: document.id,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.secondary,
                              )),
                          IconButton(
                              onPressed: () async {
                                await FireStoreService.delTextAnnouncement(
                                    document.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
