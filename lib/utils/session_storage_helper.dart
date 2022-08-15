import 'package:universal_html/html.dart';

class SessionStorageHelper{
  static Storage sessionStorage = window.localStorage;

  static setValue(String name, String value){
    sessionStorage[name] = value;
    return value;
  }

  static String getValue(String name){
    return sessionStorage[name]??'';
  }

  static void removeValue(String name){
    sessionStorage.remove(name);
  }

  static void clearAll(){
    sessionStorage.clear();
  }
}