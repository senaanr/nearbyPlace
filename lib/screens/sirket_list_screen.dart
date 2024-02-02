/*import 'package:flutter/material.dart';
import 'package:myapp/class/sirket.dart';
import 'package:myapp/screens/favsirketlist_screen.dart';


class SirketListScreen extends StatefulWidget {
  @override
  State<SirketListScreen> createState() => _SirketListScreenState();
}

class _SirketListScreenState extends State<SirketListScreen> {
  final List<Sirket> lawyers = [
    Sirket(
      name: 'A.CANBOLAT İNŞ. OFİS',
      rating: 2.6,
      openingHours: 'Pzt 08:00',
      phone: '03624330733',
      address: 'BALAÇ MAH, 1026.SOKAK, 55200 Atakum/Samsun',
      imageUrl: 'https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=FzQOzvsW3TUqWvvcISKVbw&cb_client=search.gws-prod.gps&w=408&h=240&yaw=303.4899&pitch=0&thumbfov=100',
      comments: [
        Comment(
          commentText: 'Daire aldım kendisinden yarım bıraktı tamamlamadı. Muhattap bulamiyorum. Yazık. Önermiyorum.',
          commenterName: 'Serhat İnceoğlu',
          commenterRating: 1.5,
          commentDate: '1 ay önce'
        ),
        Comment(
          commentText: 'Bu dolandiricilardan ev alinmaz. Biz aldik 5 senedir bitemedi hala yarim. Yuzu burada yalan desin',
          commenterName: 'Selim Gürkan',
          commenterRating: 2.0,
          commentDate: '2 sene önce'
        ),
        Comment(
          commentText: 'Ofis hoş ve büyük, manzarası güzel',
          commenterName: 'Meki Kaya',
          commenterRating: 4.0,
          commentDate: '7 ay önce'
        ),
      ],
    ),

    Sirket(
        name: 'Şamsofisi',
        rating: 0.0,
        phone: '05317246003',
        address: 'Cumhuriyet, 28. Sk. 20-34, 55200 Atakum/Samsun',
        imageUrl: 'https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=U1RAmUbGMYwafezTEdeY3Q&cb_client=search.gws-prod.gps&w=408&h=240&yaw=264.9409&pitch=0&thumbfov=100',
        comments: []
    ),
    Sirket(
        name: 'CITYCALL',
        address: 'Cumhuriyet, Lozan Cd. No:41, 55200 Atakum/Samsun',
        imageUrl: 'https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=sAPzHA4lkiCW6x_AxMUelg&cb_client=search.gws-prod.gps&w=408&h=240&yaw=10.030806&pitch=0&thumbfov=100',
        comments: [
          Comment()
        ]
    ),
    Sirket(
      name: 'Ekom Tanıtım Samsun Ofis',
      rating: 3.7,
      openingHours: 'Pzt 08:00',
      website: 'http://www.ekomtanitim.com/',
      phone: '03624375021',
      address: 'Cumhuriyet Mahallesi 52. Sokak No: 6 Ömürevleri, 55200 Atakum/Samsun',
      imageUrl: 'https://lh5.googleusercontent.com/p/AF1QipM3PGgmGR-l_RGaB-DdU5cltSTkeVOUtKK8mWDe=w408-h544-k-no',
      comments: [
        Comment(
          commentText: 'Bildiğin adam kazık atıyor dikkatli olun hesap konusunda',
          commenterName: 'Ali Keleş',
          commenterRating: 1.5,
          commentDate: '4 ay önce'
        ),
        Comment(
          commentText: 'Geç',
          commenterName: 'Fırat Arar',
          commenterRating: 2.0,
          commentDate: '1 sene önce'
        ),
      ],
    ),

  ];

  List<Sirket> _filteredLawyers = [];
  Set<Sirket> _favoriteLawyers = {};

  @override
  void initState() {
    super.initState();
    _filteredLawyers.addAll(lawyers);
  }

  void _filterLawyers(String query) {
    List<Sirket> filtered = lawyers.where((lawyer) {
      return lawyer.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredLawyers.clear();
      _filteredLawyers.addAll(filtered);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yakınındaki Şirketler'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Buraya tıklandığında yapılmasını istediğiniz işlemleri ekleyebilirsiniz.
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Şirket arayın...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 12.0),
              ), style: TextStyle(fontSize: 16.0),
              onChanged: (value) => _filterLawyers(value),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFilterOptions();
        },
        child: Icon(Icons.sort),
        tooltip: 'Filtrele',
      ),
      body:ListView.builder(
        itemCount: _filteredLawyers.length,
        itemBuilder: (context, index) {
          final lawyer = _filteredLawyers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2.0,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    lawyer.imageUrl,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  lawyer.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        buildRatingStars(lawyer.rating),
                        SizedBox(width: 3.0),
                        Text('${lawyer.rating}', style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    SizedBox(height: 2.0),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Yorum Yap', style: TextStyle(fontSize: 12.0)),
                        ),
                        SizedBox(width: 5.0),
                        TextButton(
                          onPressed: () {},
                          child: Text('Randevu Al', style: TextStyle(fontSize: 12.0)),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: _favoriteLawyers.contains(lawyer)
                      ? Icon(Icons.favorite, color: Colors.red, size: 24.0)
                      : Icon(Icons.favorite_border, size: 24.0),
                  onPressed: () {
                    setState(() {
                      if (_favoriteLawyers.contains(lawyer)) {
                        _favoriteLawyers.remove(lawyer);
                      } else {
                        _favoriteLawyers.add(lawyer);
                      }
                    });
                  },
                ),
                onTap: () => _showDetails(context, lawyer),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Avukatlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
        ],
        onTap: (index) {
          if (index == 1) { // Favori sekmesine tıklanırsa
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FavoriteSirketScreen(
                      favoriteLawyers: _favoriteLawyers,
                    ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars > 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.yellow, size: 20.0);
        } else if (hasHalfStar && index == fullStars) {
          return Icon(Icons.star_half, color: Colors.yellow, size: 20.0);
        } else {
          return Icon(Icons.star_border, color: Colors.yellow, size: 20.0);
        }
      }),
    );
  }

  void _showDetails(BuildContext context, Sirket lawyer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(lawyer.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    lawyer.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Açılış Zamanı: ${lawyer.openingHours}'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Telefon: ${lawyer.phone}'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Adres: ${lawyer.address}'),
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Website: ${lawyer.website}'),
              ),
              // Yorumlar için bölüm
              Divider(),
              Text(
                'Yorumlar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              lawyer.comments.isNotEmpty
                  ? Column(
                children: lawyer.comments.map((comment) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.commenterName),
                            buildRatingStars(comment.commenterRating),
                          ],
                        ),
                        Text(comment.commentDate),
                      ],
                    ),
                    subtitle: Text(comment.commentText),
                  );
                }).toList(),
              )
                  : Center(
                child: Text('Yorum bulunmamaktadır.'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Kapat'),
          ),
        ],
      ),
    );
  }
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Puana Göre Sırala'),
                onTap: () {
                  // Puana göre sıralama işlevi burada tanımlanabilir.
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Açılış Zamanına Göre Sırala'),
                onTap: () {
                  // Açılış zamanına göre sıralama işlevi burada tanımlanabilir.
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.comment),
                title: Text('Yorum Sayısına Göre Sırala'),
                onTap: () {
                  // Açılış zamanına göre sıralama işlevi burada tanımlanabilir.
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
*/