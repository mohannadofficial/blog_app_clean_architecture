import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class BaseConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionChecker implements BaseConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionChecker({required this.internetConnection});

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
