import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/models/detail.dart';

class PrayersTimeItem extends StatefulWidget {
  const PrayersTimeItem({super.key});

  @override
  State<PrayersTimeItem> createState() => _PrayersTimeItemState();
}

class _PrayersTimeItemState extends State<PrayersTimeItem> {
  Details current = Details(
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    '00:00',
  );
  Details prev = Details("", "", "", "", "", "", "", "", "", "", "", "", '');
  Details neww = Details("", "", "", "", "", "", "", "", "", "", "", "", '');
  List<Details> fsDataList = [];
  late Timer timer;
  bool _shiftStart = false;
  String _theDay = "Today";
  int j = 0;
  static String english = DateFormat('EEEE, dd MMM y').format(DateTime.now());
  String date = english;

  @override
  void initState() {
    super.initState();
    fsDataLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const PrayerItem(
              isMainHeading: true,
              iconUrl: '',
              prayerName: '',
              startTime: 'START',
              jamaatTime: 'JAMAAT',
              iconColor: Colors.blueGrey,
              startColor: AppColors.secondary,
              jamaatColor: AppColors.secondary,
            ),
            PrayerItem(
              iconUrl: 'assets/images/fajr.svg',
              prayerName: 'FAJR',
              startTime: current.Fajr_Start,
              jamaatTime: current.Fajr_Jamaah,
              iconColor: Colors.blueGrey,
              startColor: current.Fajr_Start == prev.Fajr_Start
                  ? AppColors.secondary
                  : AppColors.primary,
              jamaatColor: current.Fajr_Jamaah == prev.Fajr_Jamaah
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
            PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: 'DHUHR',
              startTime: current.Duhr_Start,
              jamaatTime: current.Duhr_Start,
              iconColor: const Color(0xffab9b4a),
              startColor: current.Duhr_Start == prev.Duhr_Start
                  ? AppColors.secondary
                  : AppColors.primary,
              jamaatColor: current.Duhr_Jamaah == prev.Duhr_Jamaah
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
            PrayerItem(
              iconUrl: 'assets/images/sunset.svg',
              prayerName: 'ASR',
              startTime: current.Asr_Start,
              jamaatTime: current.Asr_Jamaah,
              iconColor: Colors.black26,
              startColor: current.Asr_Start == prev.Asr_Start
                  ? AppColors.secondary
                  : AppColors.primary,
              jamaatColor: current.Asr_Jamaah == prev.Asr_Jamaah
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
            PrayerItem(
              iconUrl: 'assets/images/maghrib.svg',
              prayerName: 'MAGHRIB',
              startTime: current.Maghrib_Jamaah,
              jamaatTime: current.Maghrib_Jamaah,
              iconColor: Colors.black54,
              startColor: AppColors.secondary,
              jamaatColor: current.Maghrib_Jamaah == prev.Maghrib_Jamaah
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
            PrayerItem(
              iconUrl: 'assets/images/isha.svg',
              prayerName: "'ISHA",
              startTime: current.Eisha_Start,
              jamaatTime: current.Eisha_Jamaah,
              iconColor: Colors.black54,
              startColor: current.Eisha_Start == prev.Eisha_Start
                  ? AppColors.secondary
                  : AppColors.primary,
              jamaatColor: current.Eisha_Jamaah == prev.Eisha_Jamaah
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
            const Divider(
              color: AppColors.primary,
              thickness: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'SEHRI END',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                    //   SizedBox(height: 5),
                    Text(
                      current.Subh_Sadiq,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.secondaryLight
                          // color: current.Subh_Sadiq ==
                          //         prev.Subh_Sadiq
                          //     ? AppColors.primary
                          //     : AppColors.secondary,
                          ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'IFTAAR',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                    //  SizedBox(height: 5),
                    Text(
                      current.Maghrib_Jamaah,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.secondaryLight
                          // color: current.Sunrise == prev.Sunrise
                          //     ? AppColors.primary
                          //     : AppColors.secondary,
                          ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> fsDataLoad() async {
    fsDataList = [];
    try {
      if (fsDataList.isEmpty) {
        await FirebaseFirestore.instance
            .collection('prayerTime')
            .get()
            .then((snap) {
          // snap.documents.f
          final List<DocumentSnapshot> documents = snap.docs;
          // print("${documents.first.}");
          for (var e in documents) {
            // print("${e['date']}");
            var detail = Details(
                e['date'],
                e['subhSadiq'],
                e['fajarStart'],
                e['fajarJamaah'],
                e['sunrise'],
                e['zawaal'],
                e['duhrStart'],
                e['duhrJamaah'],
                e['asrStart'],
                e['asrJamaah'],
                e['magrib'],
                e['eishaStart'],
                e['eishaJamaah']);
            fsDataList.add(detail);
            print('${e['fajarStart']}');
          }
          Comparator<Details> sortDate = (a, b) => a.Date.compareTo(b.Date);
          fsDataList.sort(sortDate);
          // print("Data Loaded:${fsDataList.length}");
          // final docList = snap.;
          // docList.forEach((e) {
          //   print("${e['date']}");
          // });
        });
        if (_shiftStart == false) {
          GetTodays();
          // start_timer();
          change_times();
          _shiftStart = true;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  GetTodays() {
    for (Details i in fsDataList) {
      if (i.Date == DateFormat('dd/MM/y').format(DateTime.now())) {
        prev = i;
        DateTime.now().add(const Duration(days: 1));
        String _tomorrow = DateFormat('dd/MM/y')
            .format(DateTime.now().add(const Duration(days: 1)));
        neww = fsDataList.firstWhere((element) => element.Date == _tomorrow);
        print("Today:${prev.Date},Tomorrow:${neww.Date}");
        current = prev;
      }
    }
  }

  change_times() {
    timer = Timer.periodic(const Duration(seconds: 5), (time) {
      if (j % 2 == 0) {
        setState(() {
          current = neww;
          //   date = _today.toFormat("MMMM, dd yyyy");
          _theDay = "Tomorrow";
        });
      } else {
        setState(() {
          date = english;
          current = prev;
          _theDay = "Today";
        });
      }
      j++;
    });
  }
}

class PrayerItem extends StatelessWidget {
  const PrayerItem({
    super.key,
    required this.iconUrl,
    required this.prayerName,
    required this.startTime,
    required this.jamaatTime,
    required this.iconColor,
    this.isMainHeading = false,
    required this.startColor,
    required this.jamaatColor,
  });

  final String iconUrl;
  final String prayerName;
  final String startTime;
  final String jamaatTime;
  final Color iconColor;

  final bool isMainHeading;
  final Color startColor;
  final Color jamaatColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          if (isMainHeading)
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 30,
                width: 30,
              ),
            )
          else
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  iconUrl,
                  height: 30,
                  width: 30,
                  color: iconColor,
                ),
              ),
            ),
          if (isMainHeading)
            const Expanded(flex: 2, child: SizedBox())
          else
            Expanded(
              flex: 2,
              child: Text(
                prayerName,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.secondaryLight,
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              startTime,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: startColor,
                // color: current.Fajr_Jamaah ==
                //     prev.Fajr_Jamaah
                //     ? AppColors.secondary
                //     : AppColors.primary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.end,
              jamaatTime,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: jamaatColor,
                // color: current.Fajr_Jamaah ==
                //     prev.Fajr_Jamaah
                //     ? AppColors.secondary
                //     : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
