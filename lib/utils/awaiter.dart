import 'dart:async';

import 'package:flutter/material.dart';
import 'package:makki_tv_app/widgets/loading_dialog.dart';

abstract class Awaiter {
  static Future<T> process<T, U>({
    U? arguments,
    required Future<T> future,
    required BuildContext context,
  }) async {
    await _default.before(context, arguments);
    var result;
    try {
      result = await future;
      await _default.after(context);
    } catch (e) {
      await _default.after(context);
      rethrow;
    }
    return result;
  }

  static const _default = AwaiterBehaviour();
}

class AwaiterBehaviour<T> {
  const AwaiterBehaviour();

  FutureOr<void> after(BuildContext context) {
    Navigator.of(context).pop();
  }

  FutureOr<void> before(BuildContext context, T arguments) {
    LoadingDialog(arguments.toString()).show(context);
  }
}
