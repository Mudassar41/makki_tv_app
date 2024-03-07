import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/consts.dart';
import 'package:makki_tv_app/widgets/announcement_item.dart';
import 'package:makki_tv_app/widgets/bottom_text_slider.dart';
import 'package:makki_tv_app/widgets/date_show_item.dart';
import 'package:makki_tv_app/widgets/prayers_time_item.dart';
import 'package:makki_tv_app/widgets/time_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: AppColors.primary,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 4,
                                        right: 8,
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      child: Image.asset(
                                        'assets/images/app_icon.png',
                                        fit: BoxFit.fitHeight,
                                        height: 80,
                                        width: double.infinity,
                                        // fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'MAKKI MASJID & EDUCATION CENTRE',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10.0,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: const Column(
                                      children: [
                                        DateShowItem(),
                                        TimeItem(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Expanded(child: PrayersTimeItem()),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const AnnouncementItem(
                        images: [
                          'https://t4.ftcdn.net/jpg/04/26/04/61/360_F_426046170_Bshw7CccMbBLIFd9PCdLdKv3XRSkgFMh.jpg',
                          'https://t4.ftcdn.net/jpg/04/26/04/61/360_F_426046170_Bshw7CccMbBLIFd9PCdLdKv3XRSkgFMh.jpg'
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: BottomTextsSliderItem(
                  texts: AppConsts.marqueeText,
                  duration: const Duration(seconds: 5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
