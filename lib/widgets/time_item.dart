import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:makki_tv_app/app_colors.dart';

class TimeItem extends StatefulWidget {
  const TimeItem({Key? key}) : super(key: key);

  @override
  State<TimeItem> createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {
  String timeStarter = DateFormat.Hms().format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeStarter,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        color: AppColors.secondaryLight,
        fontWeight: FontWeight.w700,
      ),
      // style: const TextStyle(
      //   fontFamily: AppFonts.digital,
      //   fontSize: 30,
      //   fontWeight: FontWeight.bold,
      // ),
    );
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (time) {
      if (mounted) timeStarter = DateFormat.Hms().format(DateTime.now());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
