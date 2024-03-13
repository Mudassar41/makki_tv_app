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
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/app_icon.png',
                                    fit: BoxFit.cover,
                                    height: 60,
                            
                                    // fit: BoxFit.fitHeight,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MAKKI MASJID',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryLight,
                                          //  color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '& EDUCATION CENTRE',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryLight,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10),
                                  TimeItem(),
                                  DateShowItem(),
                                ],
                              )
                            ],
                          ),
                            
                        const   SizedBox(height: 20),
                          const Expanded(child: PrayersTimeItem()),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 6,right: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const AnnouncementItem(

                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: double.infinity,
              child: BottomTextsSliderItem(
                texts: AppConsts.marqueeText,
                duration: const Duration(seconds: 5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
