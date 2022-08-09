import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController{

  SharedPrefController._intiInstance();
  static final SharedPrefController _instance = SharedPrefController._intiInstance();
  late SharedPreferences _sharedPreferences ;

  factory SharedPrefController(){
    return _instance ;
    // return SharedPrefController._intiInstance();
  }

  void initSharedPref() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setStringData({required String key,required String value})async{
    bool b = await _sharedPreferences.setString(key, value);
    return b;
  }

  Future<bool> setListStringData({required String key,required List<String> value})async{
    bool b = await _sharedPreferences.setStringList(key, value);
    return b;
  }

  String getStringData({required String key}){
    String b = _sharedPreferences.getString(key) ?? " ";
    return b;
  }

  dynamic getListStringData({required String key}){
    var b = _sharedPreferences.getStringList(key) ?? " ";
    return b;
  }

  Future<bool> ClearData() async {
   return await _sharedPreferences.clear();
  }

  Future<bool> removeData(String key) async {

    return await _sharedPreferences.remove(key);
  }

}