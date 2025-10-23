/// Data models for home screen entities

/// Banner item for hero carousel
class BannerItem {
  final String imagePath;
  final String title;
  final String description;

  const BannerItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

/// Brand model for brands section
class Brand {
  final String name;
  final String logoPath;

  const Brand({
    required this.name,
    required this.logoPath,
  });
}

/// Event model for events section
class Event {
  final String title;
  final String imagePath;
  final DateTime date;
  final String venue;
  final String organizer;
  final bool isFavorite;

  const Event({
    required this.title,
    required this.imagePath,
    required this.date,
    required this.venue,
    required this.organizer,
    this.isFavorite = false,
  });
}

/// Service item for services section
class ServiceItem {
  final String name;
  final String iconPath;

  const ServiceItem({
    required this.name,
    required this.iconPath,
  });
}

/// Activity item for activities section
class ActivityItem {
  final String name;
  final String iconPath;

  const ActivityItem({
    required this.name,
    required this.iconPath,
  });
}

/// Transportation item for transportation section
class TransportationItem {
  final String name;
  final String iconPath;

  const TransportationItem({
    required this.name,
    required this.iconPath,
  });
}

/// Mock data provider for home screen
class HomeMockData {
  static List<BannerItem> get banners => [
    const BannerItem(
      imagePath: 'assets/images/banners/casio_banner.png',
      title: 'Yılların ünlü saat markası Casio',
      description: 'En yeni ürünleriyle Terminal Kadıköy\'de!',
    ),
    const BannerItem(
      imagePath: 'assets/images/banners/promo_banner_2.png',
      title: 'Yeni Mağazalar',
      description: 'Terminal Kadıköy\'de keşfedilmeyi bekleyen yeni deneyimler',
    ),
    const BannerItem(
      imagePath: 'assets/images/banners/promo_banner_3.png',
      title: 'Özel İndirimler',
      description: 'Seçili mağazalarda %50\'ye varan indirimler',
    ),
  ];

  static List<Brand> get brands => [
    const Brand(
      name: 'YEDI DE YEDI',
      logoPath: 'assets/images/brands/yedi_de_yedi.png',
    ),
    const Brand(
      name: 'Afitap Organik',
      logoPath: 'assets/images/brands/afitap.png',
    ),
    const Brand(
      name: 'Brand 3',
      logoPath: 'assets/images/brands/brand_3.png',
    ),
    const Brand(
      name: 'Brand 4',
      logoPath: 'assets/images/brands/brand_4.png',
    ),
  ];

  static List<Event> get events => [
    Event(
      title: 'Rock Müzik Konseri',
      imagePath: 'assets/images/events/rock_concert.png',
      date: DateTime(2024, 12, 17),
      venue: 'Terminal Kadıköy',
      organizer: 'PLATFORM',
    ),
    Event(
      title: 'Sanat Sergisi',
      imagePath: 'assets/images/events/art_exhibition.png',
      date: DateTime(2024, 12, 20),
      venue: 'Terminal Kadıköy',
      organizer: 'ART GALLERY',
    ),
    Event(
      title: 'Çocuk Etkinliği',
      imagePath: 'assets/images/events/kids_event.png',
      date: DateTime(2024, 12, 25),
      venue: 'Terminal Kadıköy',
      organizer: 'FAMILY FUN',
    ),
  ];

  static List<ServiceItem> get services => [
    const ServiceItem(
      name: 'Wifi',
      iconPath: 'assets/icons/services/wifi.png',
    ),
    const ServiceItem(
      name: 'ATM',
      iconPath: 'assets/icons/services/atm.png',
    ),
    const ServiceItem(
      name: 'Hayvan Dostu',
      iconPath: 'assets/icons/services/pet_friendly.png',
    ),
    const ServiceItem(
      name: 'Eczane',
      iconPath: 'assets/icons/services/pharmacy.png',
    ),
    const ServiceItem(
      name: 'Otopark',
      iconPath: 'assets/icons/services/parking.png',
    ),
    const ServiceItem(
      name: 'Güvenlik',
      iconPath: 'assets/icons/services/security.png',
    ),
  ];

  static List<ActivityItem> get activities => [
    const ActivityItem(
      name: 'Bilim',
      iconPath: 'assets/icons/activities/science.png',
    ),
    const ActivityItem(
      name: 'Müzik',
      iconPath: 'assets/icons/activities/music.png',
    ),
    const ActivityItem(
      name: 'Film',
      iconPath: 'assets/icons/activities/movie.png',
    ),
    const ActivityItem(
      name: 'Sergi',
      iconPath: 'assets/icons/activities/exhibition.png',
    ),
    const ActivityItem(
      name: 'Diğer',
      iconPath: 'assets/icons/activities/other.png',
    ),
  ];

  static List<TransportationItem> get transportation => [
    const TransportationItem(
      name: 'Araç',
      iconPath: 'assets/icons/transportation/car.png',
    ),
    const TransportationItem(
      name: 'Otobüs',
      iconPath: 'assets/icons/transportation/bus.png',
    ),
    const TransportationItem(
      name: 'Metrobüs',
      iconPath: 'assets/icons/transportation/metrobus.png',
    ),
    const TransportationItem(
      name: 'Marmaray',
      iconPath: 'assets/icons/transportation/marmaray.png',
    ),
    const TransportationItem(
      name: 'Tramvay',
      iconPath: 'assets/icons/transportation/tram.png',
    ),
  ];
}
