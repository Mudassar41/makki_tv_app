import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateShowItem extends StatelessWidget {
  const DateShowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('EEEE dd MMMM yyyy').format(DateTime.now()),
      style: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
