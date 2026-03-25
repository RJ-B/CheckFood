import 'package:dio/dio.dart';
import '../../modules/customer/restaurant/domain/entities/google_place.dart';

class GooglePlacesService {
  final Dio _dio;
  final String _apiKey;

  GooglePlacesService({required String apiKey})
      : _apiKey = apiKey,
        _dio = Dio(BaseOptions(
          baseUrl: 'https://places.googleapis.com/v1',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ));

  static const _fieldMask = 'places.id,places.displayName,places.location,'
      'places.rating,places.userRatingCount,places.formattedAddress,'
      'places.photos,places.currentOpeningHours';

  Future<List<GooglePlace>> searchNearby({
    required double latitude,
    required double longitude,
    required double radiusMeters,
    int maxResults = 20,
  }) async {
    final response = await _dio.post(
      '/places:searchNearby',
      data: {
        'includedTypes': ['restaurant'],
        'maxResultCount': maxResults.clamp(1, 20),
        'locationRestriction': {
          'circle': {
            'center': {'latitude': latitude, 'longitude': longitude},
            'radius': radiusMeters.clamp(1, 50000),
          },
        },
        'languageCode': 'cs',
      },
      options: Options(headers: {
        'X-Goog-Api-Key': _apiKey,
        'X-Goog-FieldMask': _fieldMask,
      }),
    );

    return _parsePlaces(response.data);
  }

  Future<List<GooglePlace>> searchText({
    required String query,
    required double latitude,
    required double longitude,
    double radiusMeters = 5000,
    int maxResults = 20,
  }) async {
    final response = await _dio.post(
      '/places:searchText',
      data: {
        'textQuery': query,
        'includedType': 'restaurant',
        'maxResultCount': maxResults.clamp(1, 20),
        'locationBias': {
          'circle': {
            'center': {'latitude': latitude, 'longitude': longitude},
            'radius': radiusMeters.clamp(1, 50000),
          },
        },
        'languageCode': 'cs',
      },
      options: Options(headers: {
        'X-Goog-Api-Key': _apiKey,
        'X-Goog-FieldMask': _fieldMask,
      }),
    );

    return _parsePlaces(response.data);
  }

  List<GooglePlace> _parsePlaces(dynamic responseData) {
    final data = responseData as Map<String, dynamic>;
    final places = data['places'] as List<dynamic>? ?? [];

    return places.map((p) {
      final loc = p['location'] as Map<String, dynamic>;
      final displayName = p['displayName'] as Map<String, dynamic>?;
      final photos = p['photos'] as List<dynamic>?;
      final openingHours =
          p['currentOpeningHours'] as Map<String, dynamic>?;

      String? photoUrl;
      if (photos != null && photos.isNotEmpty) {
        final photoName = photos[0]['name'] as String?;
        if (photoName != null) {
          photoUrl = getPhotoUrl(photoName);
        }
      }

      return GooglePlace(
        id: p['id'] as String,
        name: displayName?['text'] as String? ?? '',
        latitude: (loc['latitude'] as num).toDouble(),
        longitude: (loc['longitude'] as num).toDouble(),
        rating: (p['rating'] as num?)?.toDouble(),
        userRatingCount: p['userRatingCount'] as int?,
        address: p['formattedAddress'] as String?,
        photoUrl: photoUrl,
        isOpen: openingHours?['openNow'] as bool? ?? false,
      );
    }).toList();
  }

  String getPhotoUrl(String photoResourceName, {int maxWidth = 400}) {
    return 'https://places.googleapis.com/v1/$photoResourceName/media'
        '?maxWidthPx=$maxWidth&key=$_apiKey';
  }
}
