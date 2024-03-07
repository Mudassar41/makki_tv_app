import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PrayersTimeItem extends StatefulWidget {
  const PrayersTimeItem({Key? key}) : super(key: key);

  @override
  State<PrayersTimeItem> createState() => _PrayersTimeItemState();
}

class _PrayersTimeItemState extends State<PrayersTimeItem> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrayerItem(
              iconUrl: 'assets/images/fajr.svg',
              prayerName: 'Fajr',
              startTime: '05:11',
              jamaatTime: '05:12',
            ),
            PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: 'Dhuhr',
              startTime: '05:11',
              jamaatTime: '05:12',
            ),

            PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: 'Asr',
              startTime: '05:11',
              jamaatTime: '05:12',
            ),
            PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: 'Maghrib',
              startTime: '05:11',
              jamaatTime: '05:12',
            ),

            PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: "'Ishā",
              startTime: '05:11',
              jamaatTime: '05:12',
            ),
            // PrayersTimeItem(),
            // PrayersTimeItem(),
          ],
        ),
      ),
    );
  }
}

class PrayerItem extends StatelessWidget {
  const PrayerItem({
    Key? key,
    required this.iconUrl,
    required this.prayerName,
    required this.startTime,
    required this.jamaatTime,
  }) : super(key: key);
  final String iconUrl;
  final String prayerName;
  final String startTime;
  final String jamaatTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              iconUrl,
              height: 30,
              width: 30,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            prayerName,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,

              //    color: AppColors.secondary,
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
              // color: current.Fajr_Jamaah ==
              //     prev.Fajr_Jamaah
              //     ? AppColors.secondary
              //     : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
