import 'dart:convert';

import 'package:dio/dio.dart';

class PageRepository {
  PageRepository._internal();
  static final _obj = PageRepository._internal();

  factory PageRepository() {
    return _obj;
  }

  var data;
  List<String> imgs = [];
  var avatar;
  getData() async {
    print('fetch');
    try {
      var dio = Dio(BaseOptions(baseUrl: 'http://skillzycp.com'));
      var re = await dio.get('/api/UserApi/getOneOccasion/389/0');
      var parsedData = jsonDecode(re.data);
      print(parsedData);
      if (!parsedData.isEmpty) {
        data = parsedData;
        updateImages();

        return {"status": true, "errors": null};
      } else {
        return {"status": false, "errors": 'somthing went wrong!'};
      }
    } catch (e) {
      print(e);
      return {"status": false, "errors": 'Please verify your connetion!'};
    }
  }

  updateImages() {
    var _oldImgs = data['img'];
    for (var item in _oldImgs) {
      var _cut = item.split('https');
      var _newLink = 'http${_cut[1]}';
      imgs.add(_newLink);
    }

    var _cut = data['trainerImg'].split('https');
    avatar = 'http${_cut[1]}';
  }
}
