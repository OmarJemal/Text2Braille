import 'package:shared_preferences/shared_preferences.dart';

//Preference Handler Class for managing ipAddress and Port settings

class SharedPref {
//static variables to manage s
  static SharedPreferences _prefInstance;

  // Singleton accessor


  Future<SharedPref> init() async {
    await loadPrefences().then((result) {
      _prefInstance = result;
    }).catchError((error) {
      print(error); 
    });
    return SharedPref();
  }


  SharedPref() {

    /*
    loadPrefences().then((result) {
      _prefInstance = result;
    }).catchError((error) {
      print(error);
    });
    */

  }

  Future<SharedPreferences> loadPrefences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // Future asynchronous methods for storing key values for ip Address in the app
  Future<String> setIpAddress(String ipAddress) async {
    _prefInstance.setString("ipAddress", ipAddress);
    return "Changed ip Address";
  }

  // Future asynchronous methods for storing key values for port Number in the app
  Future<String> setPortNumber(String portNumber) async {
    _prefInstance.setString("portNumber", portNumber);
    return "Changed port Number";
  }

  // Future asynchronous methods for storing key values for port Number in the app
  Future<String> setIsTestingMode(bool isTestingMode) async {
    _prefInstance.setBool("isTestingMode", isTestingMode);
    return "Changed isTestingMode";
  }

  // Future asynchronous methods for getting values for ip Address in the app
  Future<String> getIpAddress() async {
    return _prefInstance.getString("ipAddress") ?? "123.123.123.765";
  }

  // Future asynchronous methods for getting values for port Number in the app
  Future<String> getPortNumber() async {
    return _prefInstance.getString("portNumber") ?? "8080";
  }

  Future<bool> getIsTestingMode() async {
    return _prefInstance.getBool("isTestingMode") ?? false;
  }

  Future<String> getAddress() async {
    String ipAddress = await getIpAddress();

    String portNumber = await getPortNumber();

    return ipAddress + ":" + portNumber;
  }

}
