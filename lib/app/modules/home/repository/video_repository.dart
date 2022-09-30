import 'package:teste_seventh/app/modules/home/repository/i_video_repository.dart';
import 'package:teste_seventh/app/shared/config/failure.dart';
import 'package:teste_seventh/app/shared/constants/api_paths.dart';
import 'package:teste_seventh/app/shared/constants/http_methods.dart';
import 'package:teste_seventh/app/shared/dio/http_manager.dart';

class VideoRepository extends IVideoRepository {
  final HttpManager httpManager;

  VideoRepository({
    required this.httpManager,
  });

  @override
  Future<String> getUrlVideo({
    required String token,
  }) async {
    final result = await httpManager.restRequest(
      url: '${ApiPaths.videoUrl}/bunny.mp4',
      method: HttpMethods.get,
      headers: {
        'x-access-token': token,
      },
    );
    if (result.containsKey('url')) {
      return result['url'];
    }
    throw Failure.fromMap(result);
  }
}
