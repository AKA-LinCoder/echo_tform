import 'form_row.dart';

List formValidationErrors(List<TFormRow> rows) {
  List errors = [];
  for (var row in rows) {
    if (row.validator != null) {
      bool isSuccess = row.validator!(row);
      if (!isSuccess) {
        errors.add(row.requireMsg ?? "${row.title.replaceAll("*", "")} 不能为空");
      }
    } else {
      if (row.require ?? false) {
        if (row.value == null ) {
          errors.add(row.requireMsg ?? "${row.title.replaceAll("*", "")} 不能为空");
        }
      }
    }
  }
  return errors;
}


List getValue(List<TFormRow> rows) {
  List errors = [];
  for (var row in rows) {
    print("这是填写的值");
    print(row.value);
  }
  return errors;
}