  import 'package:flutter/material.dart';

  import '../class/product.dart';

  class CategoriesGetir extends StatelessWidget {
    List<Category> getCategories() {
      return [
        Category(
          id: "1",
          name: "Burger",
          src: "https://img.freepik.com/free-photo/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese_90220-1063.jpg?w=826&t=st=1706795257~exp=1706795857~hmac=6931b7fedd64f1af1a96149f66a325d52e997f51f34a989beb159eea7088500a",
          subCategories: ["Birlikte İyi Gider", "Çubuk", "Kutu", "Külah", "Çoklu", "Bar"],
        ),
        Category(
          id: "2",
          name: "Kebap & Türk Mutfağı",
          src: "https://img.freepik.com/free-photo/grilling-fire-green-outside-shish_1203-5476.jpg?w=1380&t=st=1706795633~exp=1706796233~hmac=e6258bcf781936f0747b829d3c62e04b5511e1bd4f1de41b2deba2ff6ac74572",
          subCategories: ["Birlikte İyi Gider", "Çubuk", "Kutu", "Külah", "Çoklu", "Bar"],
        ),
      Category(
        id: "3",
        name: "Döner",
        src: "https://img.freepik.com/free-photo/close-up-lamb-kebab-meat-served-with-flatbread_140725-3906.jpg?w=740&t=st=1706795752~exp=1706796352~hmac=2dabdc18eb3931acaa93818af91f9ac34496490d3434c437103e232173dddb14",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "4",
        name: "Tatlı",
        src: "https://img.freepik.com/free-photo/christmas-cupcakes_74190-1149.jpg?w=740&t=st=1706796046~exp=1706796646~hmac=f574a3f2f2dacc971ea7c7dfdbde087e97fafcbf26308e8fd1e82f894f8770b9",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "5",
        name: "Pizza",
        src: "https://img.freepik.com/free-photo/delicious-italian-pizza-with-tomato-olives-pepperoni-mushrooms-top-view-isolated-white-background-still-life-copy-space_639032-1875.jpg?w=826&t=st=1706796075~exp=1706796675~hmac=d51c08b3bdbc46150b40486e80288677a741a57ae965e7f1dd3b44ea7d394fc0",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "6",
        name: "Çiğ Köfte",
        src: "https://img.freepik.com/free-photo/side-view-vegetarian-steak-tartar-balls-with-slices-lemon-greens-fresh-tomato-plate_141793-5156.jpg?w=1380&t=st=1706796147~exp=1706796747~hmac=9cf6854bbd9c5083ed39a876cc5bb7031557ce50c8712cab7b806f465e5c0476",
        subCategories: [],
      ),
      Category(
        id: "7",
        name: "Kahve",
        src: "https://img.freepik.com/free-photo/hot-chocolate-white-cup-isolated-white-background_123827-26892.jpg?w=1380&t=st=1706796179~exp=1706796779~hmac=b5ead65867c674c07806d58f2f08948764a5e86af38a5127ac8d01752a6a7832",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "8",
        name: "Tantuni",
        src: "https://img.freepik.com/free-photo/tortilla_144627-20837.jpg?w=900&t=st=1706796212~exp=1706796812~hmac=a16fa19f6fb7f7b9937b7310087dea6b43d218eb2ded2b7f4b5031ec20f84d55",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "9",
        name: "Waffle",
        src: "https://img.freepik.com/free-photo/fresh-sweet-chocolate-waffles-with-strawberry_144627-13864.jpg?w=1380&t=st=1706796257~exp=1706796857~hmac=6b804fffe26fdc9a1758d660f9b3aeea1aa18ae4ae2d4378ffc619adbb9c964e",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "10",
        name: "Kokoreç",
        src: "https://img.freepik.com/free-photo/traditional-choripan-argentina-sandwich-with-chorizo-chimichurri-sauce-isolated-white-backg_123827-29680.jpg?w=1380&t=st=1706796321~exp=1706796921~hmac=bb50f2589e8471c38b5bea70fffdf0348175246b39a4c652dbc2fa64a92c04ca",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "11",
        name: "Tavuk",
        src: "https://img.freepik.com/free-photo/arrangement-with-chicken-food-white-background_23-2148308847.jpg?w=826&t=st=1706796369~exp=1706796969~hmac=25740e4a3fcc1d758ba0f3c920f75e41fa6b3ff7d23f82b8e313bbab263deae9",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "12",
        name: "Kumpir",
        src: "https://img.freepik.com/free-photo/turkish-dish-kumpir-with-corn-olives-mayonnaise-potatoes_140725-7472.jpg?w=740&t=st=1706796469~exp=1706797069~hmac=de9d8923a193a9c8fc10cd235ac9941bed7eb7e2e301a4b51fa5af62584a62b5",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "13",
        name: "Deniz Ürünleri",
        src: "https://img.freepik.com/free-photo/background-grilled-nature-delicious-snack_1203-5479.jpg?w=1380&t=st=1706796552~exp=1706797152~hmac=b7769354dc428d4609d124852f32aec8f0f3e8e563456e7ce3ff7372a4cca7b9",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "14",
        name: "Tost & Sandviç",
        src: "https://img.freepik.com/free-photo/panini-sandwich-with-ham-cheese-tomato-arugula-isolated-white-background_123827-27057.jpg?w=1380&t=st=1706796688~exp=1706797288~hmac=b4c2af2fa663cc455986b2e22010005f063912bb4ac5ba1028ce7e292f6d6d0d",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "15",
        name: "Ev Yemekleri",
        src: "https://img.freepik.com/free-photo/delicious-food-white-plate_144627-34691.jpg?w=1380&t=st=1706796777~exp=1706797377~hmac=55f2d918599b31cd3e037fde68a2f90d0fad8a21d76270eb831cfeced38c36c0",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "16",
        name: "Kahvaltı & Börek",
        src: "https://img.freepik.com/free-photo/fried-eggs-with-sausages_23-2147961010.jpg?w=1380&t=st=1706796939~exp=1706797539~hmac=19576d07726220f83905ed02d35b84cbb7afc87ee1a0f2989d89eef9acd944a8",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "17",
        name: "Makarna",
        src: "https://img.freepik.com/free-photo/pasta-with-zucchini-sweet-peppers-with-basil-garlic-dressing_2829-17952.jpg?w=1060&t=st=1706796723~exp=1706797323~hmac=bd0be6dcd9b337146b84ef429cfb044e1b6b55eeb00d8ed6cf7e9f8054d91061",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
      Category(
        id: "18",
        name: "Mantı",
        src: "https://img.freepik.com/free-photo/pasta-yummy-comida-lifestyle-gastronomy_1350-65.jpg?w=1380&t=st=1706796997~exp=1706797597~hmac=08574efe9763648c100ee47e3175ecfa769babb5bb2bff4a529ca4ba811988a5",
        subCategories: [
          "Birlikte İyi Gider",
          "Çubuk",
          "Kutu",
          "Külah",
          "Çoklu",
          "Bar"
        ],
      ),
        Category(
          id: "19",
          name: "Salata",
          src: "https://img.freepik.com/free-photo/salmon-avocado-salad-isolated-white-background_123827-20214.jpg?w=1380&t=st=1706797134~exp=1706797734~hmac=6fcd4b9a05d7ce33b628d0c5738321e95e1f0bab11d308380ed9e4a62c212082",
          subCategories: [
            "Birlikte İyi Gider",
            "Çubuk",
            "Kutu",
            "Külah",
            "Çoklu",
            "Bar"
          ],
        ),
        Category(
          id: "20",
          name: "Pastane & Fırın",
          src: "https://img.freepik.com/free-photo/delicious-bun-bread-slices-front-view_23-2148361641.jpg?w=740&t=st=1706797187~exp=1706797787~hmac=19c58a63ae1e15a92718b707e54f1538a2dd24911463e666ae72d6b1de24ef37",
          subCategories: [
            "Birlikte İyi Gider",
            "Çubuk",
            "Kutu",
            "Külah",
            "Çoklu",
            "Bar"
          ],
        ),
        Category(
          id: "21",
          name: "Pilav",
          src: "https://img.freepik.com/free-photo/wheat-porridge-with-herbs_2829-14438.jpg?w=826&t=st=1706797261~exp=1706797861~hmac=cc2c4c39aec9b9d07d065b85dcbd381a5921343a8aa8962ba836fc431095c165",
          subCategories: [
            "Birlikte İyi Gider",
            "Çubuk",
            "Kutu",
            "Külah",
            "Çoklu",
            "Bar"
          ],
        ),
        Category(
          id: "22",
          name: "Çorba",
          src: "https://img.freepik.com/free-photo/lobster-soup_1339-2173.jpg?w=1380&t=st=1706800315~exp=1706800915~hmac=611ca7500b14d1fbb41121238d8c62c7901a514c9a9627de0649a71dee42a443",
          subCategories: [
            "Birlikte İyi Gider",
            "Çubuk",
            "Kutu",
            "Külah",
            "Çoklu",
            "Bar"
          ],
        ),
      ];
    }

    @override
    Widget build(BuildContext context) {
      return Container();  // You can return any widget here if needed
    }
  }