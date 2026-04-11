/// Domain entita pro jednu fotku v galerii restaurace.
class RestaurantPhoto {
  final String id;
  final String url;
  final int sortOrder;

  const RestaurantPhoto({
    required this.id,
    required this.url,
    this.sortOrder = 0,
  });
}
