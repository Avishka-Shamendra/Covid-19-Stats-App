import 'dart:io';
import 'package:path_provider/path_provider.dart';


class CountryStorage{
  Future<String> get _localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async{
    final path= await _localPath;

    return File('$path/default_country.txt');
  }

  Future<String> readCountry() async{
    try{
      final file= await _localFile;
      String content = await file.readAsString();
      if (content=='') {return 'us';}
      else{return content.trim();}
    }catch(e){
      return 'us';
    }
  }

  Future<File> writeCountry(String country) async {
    final file=await _localFile;
    return file.writeAsString('$country');
  }

}
class Defaultcountry{
  final CountryStorage storage=CountryStorage();


  Future<String> getCountry() async {
    String country=await storage.readCountry();
    return country;
  }
  Future<void> setCountry(String country) async{
    storage.writeCountry(country);

  }
}