import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AnnouncementItem extends StatefulWidget {
  const AnnouncementItem({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  State<AnnouncementItem> createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementItem> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 15),
        viewportFraction: 1.0,
        autoPlay: true,
        height: MediaQuery.sizeOf(context).height,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: widget.images
          .map((item) => Container(
                    height: MediaQuery.sizeOf(context).height,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(item),
                      ),
                    ),
                  )
              //
              //     Image.network(
              //   item,
              //   fit: BoxFit.cover,
              //   height: MediaQuery.sizeOf(context).height,
              // ),
              )
          .toList(),
    );
  }
}
