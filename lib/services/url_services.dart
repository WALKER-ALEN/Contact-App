import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launchUrl(emailUri);
}

Future<void> launchPhone(String phoneNumber) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(phoneUri);
}

Future<bool> requestLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
    status = await Permission.location.request();
  }

  if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}
