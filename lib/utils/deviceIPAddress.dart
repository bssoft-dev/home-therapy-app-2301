import 'dart:io';

Future<List<InternetAddress>> getDeviceIPAddress() async {
  List<InternetAddress> localIPs = await getLocalIPAddresses();

  return localIPs;
}

Future<List<InternetAddress>> getLocalIPAddresses() async {
  List<InternetAddress> addresses = [];

  try {
    List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    for (NetworkInterface interface in interfaces) {
      for (InternetAddress address in interface.addresses) {
        addresses.add(address);
      }
    }
  } catch (e) {
    print('Failed to get local IP addresses: $e');
  }

  return addresses;
}
