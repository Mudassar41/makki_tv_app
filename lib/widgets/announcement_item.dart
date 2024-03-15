import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makki_tv_app/service/firestore_service.dart';

class AnnouncementItem extends StatefulWidget {
  const AnnouncementItem({super.key});

  @override
  State<AnnouncementItem> createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreService.imgStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return CarouselSlider(
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 15),
              viewportFraction: 1.0,
              autoPlay: true,
              height: MediaQuery.sizeOf(context).height,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: [
              ...snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(data);
                return Container(
                  height: MediaQuery.sizeOf(context).height,
                  clipBehavior: Clip.antiAlias,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    image: DecorationImage(
                     fit: BoxFit.fill,
                    // image: AssetImage("assets/images/sample1.png")
                     image: NetworkImage("${data['url']}"),
                    ),
                  ),
                );
              }),
            ]

            // widget.images
            //     .map((item) =>
            //
            //     Container(
            //           height: MediaQuery.sizeOf(context).height,
            //           clipBehavior: Clip.antiAlias,
            //           decoration: BoxDecoration(
            //             borderRadius: const BorderRadius.all(
            //               Radius.circular(10),
            //             ),
            //             image: DecorationImage(
            //               fit: BoxFit.cover,
            //               image: NetworkImage(item),
            //             ),
            //           ),
            //         )
            // )
            //     .toList(),
            );
      },
    );
  }
}
