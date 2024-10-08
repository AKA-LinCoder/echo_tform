import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:fluttertoast/fluttertoast.dart';



void showToast(String text,BuildContext context) {
  FToast fToast = FToast()..init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black87,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: 2),
  );
}

Future<String> showPicker(List options, BuildContext context) async {
  String? result;
  await Picker(
      height: 220,
      itemExtent: 38,
      adapter: PickerDataAdapter<String>(pickerData: options),
      onConfirm: (Picker picker, List value) {
        result = options[value.first];
      }).showModal(context);
  return result ?? "";
}

Future<String> showPickerDate(BuildContext context) async {
  String? result;
  await Picker(
      height: 220,
      itemExtent: 38,
      adapter: DateTimePickerAdapter(),
      onConfirm: (Picker picker, List value) {
        result = formatDate((picker.adapter as DateTimePickerAdapter).value??DateTime.now(),
            [yyyy, '-', mm, '-', dd]);
        print((picker.adapter as DateTimePickerAdapter).value.toString());
      }).showModal(context);
  return result ?? "";
}
