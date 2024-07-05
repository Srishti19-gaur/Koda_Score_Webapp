import 'package:koda_score_webapp/models/dataset.dart';
import 'package:gsheets/gsheets.dart';

class DataSheetApi {
  static const credentials = r'''
{
  "type": "service_account",
  "project_id": "inner-radius-376716",
  "private_key_id": "6ccfd494e5f8217219a7df6fe398455c950c4534",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC1SzmDuOIFtU0a\ngWP7Qyn6f6IKTCBpWQK2lKk0rHphZPrz+GN/S2n/WVjr74GptfjmzPOJNnoJMHey\nVbG9WTfuJgLqoKeVF4yFv/tkZZE/R5M0fUzJE2LhRZL4Qo4tCR6NrgLW73v96PnY\na8JBwYT+31cFTTI5z806B5AMxwzKTTEjYLeBOhy0SFbqUUFFansh7ZeKWBW3DN9a\ndxnORtWHEGNOYbbMYbJyD4JZGb5LL5T3kE+AClLlt5tw6ZOwITjHw0BRW3wXuFqW\nhhNC4FIb1i6TfKp53nMeyPSzpxp5yOgcG+6HIa1c2VA6646E7TpgCYxNwfqu7sFW\ntpnWHFTZAgMBAAECggEAKj1gJaoec1EGKW5LQsAn2DcDpJ2PEayM/shNUjn7e5TB\nCbXuTLrf9AA3wST5E3cUCoZnGampLlnuEY14z5KpfuG5XTxYP1sQwRr1cjNd7534\nFMs66ECNkcoZj6FGKgUNatpHzBdZTtQI3l1hEdwKZi3YQyJ02NZrTSF09R0thDaq\nm0pjLY1LLUm2GI8042mwcTg462Cm6QxKKMwWWmeJm9EkZQMiRdUfMAtYSso0nDN7\nn3NLHxr8jYkIWWOPsv574gB8Mf8GfNkQin0FD8ipudNfjP+Qvf/orXTsa0rWlEOE\nbpIez3v/Ufuk0WLG4PbbdUo9FCz6UB8EwnrF9jyHWQKBgQDbqjcgp1HmjVvDKngv\nTwatJlzcN3CBOOaNT6iRRarNb2d592/npS99cIhiqe9QOSiDceeYrV+bxpYBLnFq\nPGvE/8nwkBr7iHHt6c5FBY9dWgKTGtUFNUaZt9Zf3H3dqvkn1zHG2hiaFCrWc2uU\ndfDhXjwa49NN6tCQdpv1xfxF1QKBgQDTSCyGFBEfr1rWSXQieXPTkS1teu5Qn3WT\nXgjiCT6FqOC+yU0b6g3msRhVASYZB30s85VF/j8v/eJKMG5nKAJ91zUedNb468LE\nbroLADPRTGQvq/A8ZiNm3wlrA/Q8WFhi2+lrVuohLKZ7Xxu3CNzFcYhUZO1IlR5r\nVALtWDeA9QKBgFSSZEceJFovcnThlQQh2OAxNO9UKOyXi6w8TxofSHNvwNckfOEi\np/YTrW7PHmQ0nXR+FjyiA31mJ7qstt3ABX4DPSxxTvIoxjRjIBdS3K+ESBl66yjm\nKhhkvxSJP6xodyTvpSp6LZ6kxRlrtq+h+OvL7DguHtyQ21vDTqiBYW9BAoGAO6n3\nAMnr6AGx6i+F/zJC9izaIj+DyvqszjfQ1Fv97uq4xMe94bMfx9Sc5WxUoN7Ph4El\n10Ur/NZ6L68rji/rPDQoyPf/uP2C28vU98RP3bvv0tKAHd5OAv/a/gB42Q2tsAUg\nDnLV3RZp0Q8TmYWEKrGb6REzPLr3gyGPTg0KZ30CgYBhVlirPTE5I7K1nsTf3saT\npfDS0VH0bv1mpnljBuW1y4S/JZTARCLQPTR5eCgApihrxJE+oKxDO2DzNOmlpM+q\n4+xygMAYpyVHo1kAFwNBa8ekdCoEVIwMpv40FeuqjWuPcnSgF7XQLbmjiu8cwA1/\nNftJk25aG/kDGVkqzA74FQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "igdtuwstudents@inner-radius-376716.iam.gserviceaccount.com",
  "client_id": "104139140435743494385",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/igdtuwstudents%40inner-radius-376716.iam.gserviceaccount.com"
}

''';
  static const spreadsheetId = '167rRydyOC-rbQYSyEY1VhZ7QDQdvnoQvMbZWXiuAtSg';

  static final gsheets = GSheets(credentials);

  static Worksheet? dataSheet;

  static Future init() async {
    try {
      final spreadsheet = await gsheets.spreadsheet(spreadsheetId);
      dataSheet = await getWorksheet(spreadsheet, 'Sheet 1');

      final firstRow = DataSet.getFields();
      dataSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('init error: $e');
    }
  }

  static Future<Worksheet> getWorksheet(
      Spreadsheet spreadsheet, String title) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    dataSheet!.values.map.appendRows(rowList);
  }

  static Future deleteByImagePath(String imagePath) async {
    if (dataSheet == null) return false;

    final index = await dataSheet!.values.rowIndexOf(imagePath);
    if (index == -1) return false;

    return dataSheet!.deleteRow(index);
  }
}
