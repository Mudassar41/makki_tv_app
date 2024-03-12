import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:makki_tv_app/app_colors.dart';

class DateShowItem extends StatelessWidget {
  const DateShowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('EEEE dd MMMM yyyy').format(DateTime.now()),
      style: GoogleFonts.montserrat(
        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryLight,
      ),
    );
  }
}
