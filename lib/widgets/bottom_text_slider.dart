import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomTextsSliderItem extends StatefulWidget {
  const BottomTextsSliderItem({
    Key? key,
    required this.texts,
    required this.duration,
  }) : super(key: key);

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
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 10),
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
      ),
      itemCount: widget.texts.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.topLeft,
          width: MediaQuery.sizeOf(context).width,
          child: Text(
            widget.texts[index],
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
