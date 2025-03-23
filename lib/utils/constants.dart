import 'package:url_launcher/url_launcher.dart';

const String baseUrl = "https://0xfkg6v0-3001.inc1.devtunnels.ms/api/v1";
// const String baseUrl = "https://care-connect-backend-one.vercel.app/api/v1";

makingPhoneCall(String number) async {
  var url = Uri.parse("tel:$number");
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
