import 'package:dio/dio.dart';
import 'package:search_image/apis/apis.dart';
import 'package:search_image/models/models.dart';

class ApiCall {
  static Future<ImageModel?> getImages(
      {String? searchQuery, int? limit, int? page}) async {
    Dio dio = Dio();
    try {
      var response = await dio.get(Endpoints.mainUrl, queryParameters: {
        'key': '35072865-8f834bc894ef8c859314ff327',
        'image_type': 'photo',
        'limit': limit,
        'page': page,
        'q': searchQuery,
      });

      print('*******RESPONSE*');
      print(response.realUri);
      print(response.data);
      return ImageModel.fromJson(response.data);
    } on DioError catch (e) {
      print('***********8ERROR********');
      print(e.error);
      throw Exception(e.message);
    } catch (e) {
      print('*******null*********');
      print(e);
      return null;
    }
  }
}
