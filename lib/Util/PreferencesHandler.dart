import 'package:shared_preferences/shared_preferences.dart';

//Preference Handler Class for managing ipAddress and Port settings

class SharedPref{

//static variables to manage s

  static final SharedPref _singleton = SharedPref._();
  static SharedPreferences _prefInstance;

  // Singleton accessor
  static SharedPref get instance => _singleton;

  SharedPref._() {
    loadPrefences().then((result){
      _prefInstance = result;
    }).catchError((error){
      print(error);
    });
  }
  
  Future<SharedPreferences> loadPrefences() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // Future asynchronous methods for storing key values for ip Address in the app
  Future<String> setIpAddress(String ipAddress) async{
    _prefInstance.setString("ipAddress", ipAddress);
    return "Changed ip Address";
  }

  // Future asynchronous methods for storing key values for port Number in the app
  Future<String> setPortNumber(String portNumber) async{
    _prefInstance.setString("portNumber", portNumber);
    return "Changed port Number";
  }

  // Future asynchronous methods for getting values for ip Address in the app
  Future<String> getIpAddress() async{
    return _prefInstance.getString("ipAddress") ?? "123.123.123.12";
  }

  // Future asynchronous methods for getting values for port Number in the app
  Future<String> getPortNumber() async{
    return _prefInstance.getString("portNumber") ?? "8080";
  }


}