import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/admin/image_ann_view.dart';
import 'package:makki_tv_app/admin/text_announcement_view.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/models/admin_item.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final items = [
    AdminItem(
      title: "Image Announcements",
      page: const ImageAnnouncementsView(),
    ),
    AdminItem(
      title: "Text Announcements",
      page: const TextAnnouncementsView(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            "Makki Tv Admin",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5.0,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => items[index].page,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        items[index].title,
                        style: GoogleFonts.montserrat(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
