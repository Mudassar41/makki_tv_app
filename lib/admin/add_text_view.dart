import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makki_tv_app/app_colors.dart';
import 'package:makki_tv_app/service/firestore_service.dart';

class AddTextView extends StatefulWidget {
  const AddTextView({super.key, this.title, this.docId});

  final String? title;
  final String? docId;

  @override
  State<AddTextView> createState() => _AddTextViewState();
}

class _AddTextViewState extends State<AddTextView> {
  final text = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.title != null) {
      text.text = widget.title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: text,
              style: GoogleFonts.montserrat(),
              maxLines: null,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondary,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (text.text.isNotEmpty) {
                    if (widget.title != null) {
                      await FireStoreService.updateTextAnnouncement(
                        text.text.trim(),
                        widget.docId!,
                      );
                    } else {
                      await FireStoreService.addTextAnnouncementToDb(
                          text.text.trim());
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  widget.title != null ? 'Update' : 'Save',
                  style: GoogleFonts.montserrat(),
                ))
          ],
        ),
      ),
    );
  }
}
