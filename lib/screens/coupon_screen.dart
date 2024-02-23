import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/class/themes.dart';
import 'package:myapp/components/myDrawer.dart';

class CouponPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kuponlarım'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(data: Theme.of(context), child: CouponWidget(),)
             // CouponWidget'i burada kullanıcıya özel bilgilerle güncelleyebilirsiniz.
          ],
        ),
      ),
    );
  }
}

class CouponWidget extends StatelessWidget {
  // Kullanıcının kupon bilgilerini içeren bir sınıf ekleyebilirsiniz.
  // Örneğin:
  // final UserCoupon userCoupon;

  @override
  Widget build(BuildContext context) {
    // Eğer kullanıcının bir kuponu varsa, bu kısmı kullanıcının bilgileriyle doldurun.
    bool hasCoupon = false; // Kullanıcının kuponu var mı yok mu kontrolü

    return hasCoupon ? buildCouponDetails() : buildNoCoupon();
  }

  Widget buildCouponDetails() {
    // Eğer kullanıcının kuponu varsa, kuponun detaylarını burada gösterin.
    // Örneğin:
    // return Text('Kupon Kodu: ${userCoupon.code}\nİndirim: ${userCoupon.discount}');
    return Container(
      // Kupon detaylarını içeren bir widget
      padding: EdgeInsets.all(16),
      color: Colors.green[100],
      child: Column(
        children: [
          Text(
            'Kuponunuzun Detayları',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          // Kupon detayları burada gösterilebilir.
          Text('Kupon Kodu: ABC123'),
          Text('İndirim Miktarı: 20%'),
          // ...
        ],
      ),
    );
  }

  Widget buildNoCoupon() {
    // Eğer kullanıcının kuponu yoksa, bu kısmı kullanın.
    return Column(
      children: [
        SizedBox(height: 1), // Azaltılan boşluk
        Image.asset(
          'assets/image/coupon.jpg', // Kupon yoksa gösterilecek resim
          height: 150,
        ),
        SizedBox(height: 1), // Azaltılan boşluk
        Text(
          'kuponunuz_yok'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}