import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

Future<IOClient> ioClient() async {
  final sslCert = await rootBundle.load('packages/core/assets/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
  return IOClient(client);
}