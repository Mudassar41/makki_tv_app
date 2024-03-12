import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/app_colors.dart';

class PrayersTimeItem extends StatefulWidget {
  const PrayersTimeItem({Key? key}) : super(key: key);

  @override
  State<PrayersTimeItem> createState() => _PrayersTimeItemState();
}

class _PrayersTimeItemState extends State<PrayersTimeItem> {
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
        //  vertical: 10.0,
        ),
        child: Column(
       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
       mainAxisSize: MainAxisSize.max,
          children: [
      
      
          const PrayerItem(
      isMainHeading: true,
              iconUrl: '',
              prayerName: '',
              startTime: 'Start',
              jamaatTime: 'Jamaat',
              iconColor: Colors.blueGrey,
            ),
      
            const PrayerItem(
              iconUrl: 'assets/images/fajr.svg',
              prayerName: 'Fajr',
              startTime: '05:11',
              jamaatTime: '05:12',
              iconColor: Colors.blueGrey,
            ),
            
            const PrayerItem(
              iconUrl: 'assets/images/sun.svg',
              prayerName: 'Dhuhr',
              startTime: '05:11',
              jamaatTime: '05:12',
              iconColor: Color(0xffab9b4a),
            ),
            const PrayerItem(
              iconUrl: 'assets/images/sunset.svg',
              prayerName: 'Asr',
              startTime: '05:11',
              jamaatTime: '05:12',
              iconColor: Colors.black26,
            ),
            PrayerItem(
              iconUrl: 'assets/images/maghrib.svg',
              prayerName: 'Maghrib',
              startTime: '05:11',
              jamaatTime: '05:12',
              iconColor: Colors.redAccent.shade100.withOpacity(0.5),
            ),
            const PrayerItem(
              iconUrl: 'assets/images/isha.svg',
              prayerName: "'Ishā",
              startTime: '05:11',
              jamaatTime: '05:12',
              iconColor: Colors.black54,
            ),
           const Divider(color: AppColors.primary,thickness: 0.5,),
      
      
      SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Column(
                children: [
                  Text(
                    'Sehri End',
                    style:
                       GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                  ),
               //   SizedBox(height: 5),
                  Text(
                   '11:00',
                    style:
                        GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
                                    'Iftaar',
                                    style:
                                           GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                //  SizedBox(height: 5),
                                  Text(
                                   '22:00',
                                    style:
                                        GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      // color: current.Sunrise == prev.Sunrise
                                      //     ? AppColors.primary
                                      //     : AppColors.secondary,
                                    ),
                                  )
                                ],
                              ),],
            )
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
    required this.iconColor,  this.isMainHeading=false,
  }) : super(key: key);
  final String iconUrl;
  final String prayerName;
  final String startTime;
  final String jamaatTime;
  final Color iconColor;

  final bool isMainHeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          if(isMainHeading)Expanded(
            flex: 1,
            child: SizedBox(
              height: 30,
              width: 30,
            ),)
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


               if(isMainHeading)Expanded(flex: 2,child: SizedBox())else
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
      ),
    );
  }
}
