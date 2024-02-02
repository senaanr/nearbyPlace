class Restaurant {
  String ad;
  String telefonNumarasi;
  int yas;
  String cinsiyet;
  String email;
  String konum;
  List<String> yorumlar;
  double puan;
  List<String> acikOlanSaatler;

  Restaurant({
    required this.ad,
    required this.telefonNumarasi,
    required this.yas,
    required this.cinsiyet,
    required this.email,
    required this.konum,
    this.yorumlar = const [],
    this.puan = 0.0,
    this.acikOlanSaatler = const [],
  });
}
