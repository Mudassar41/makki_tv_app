import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/service/firestore_service.dart';

class BottomTextsSliderItem extends StatefulWidget {
  const BottomTextsSliderItem({
    super.key,
    required this.texts,
    required this.duration,
  });

  final List<String> texts;
  final Duration duration;

  @override
  State<BottomTextsSliderItem> createState() => _BottomTextsSliderItemState();
}

class _BottomTextsSliderItemState extends State<BottomTextsSliderItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreService.textStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return CarouselSlider.builder(
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 15),
            viewportFraction: 1.0,
            autoPlay: true,
            enlargeCenterPage: false,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index, realIndex) {
            Map<String, dynamic> data =
                snapshot.data!.docs[index].data()! as Map<String, dynamic>;
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.topLeft,
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                data['txt'],
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
