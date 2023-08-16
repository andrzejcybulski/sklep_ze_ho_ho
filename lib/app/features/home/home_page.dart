import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_ze_ho_ho/app/features/home/cart/cart_page.dart';
import 'package:sklep_ze_ho_ho/app/features/home/my_account/my_account_page_content.dart';
import 'package:sklep_ze_ho_ho/app/features/home/products/products_page_content.dart';
import 'package:sklep_ze_ho_ho/app/features/home/settings/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;
  final isFavourite = false;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        //   onWillPop: () async => false,
        //   child:
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 84, 84),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const YourCartPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
        title: Builder(
          builder: (context) {
            if (currentIndex == 0) {
              return const Text('Produkty');
            }
            if (currentIndex == 1) {
              return const Text('Wyszukiwanie');
            }
            if (currentIndex == 2) {
              return const Text('Obserwowane');
            }
            return const Text('Moje konto');
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.grey, height: 0.3),
        ),
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      ),
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const ProductsPageContent();
          }
          if (currentIndex == 1) {
            return const Center(
              child: Text('Szukaj'),
            );
          }

          if (currentIndex == 2) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Coś poszło nie tak');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Ładowanie');
                  }

                  final documents = snapshot.data!.docs;

                  return GridView.count(
                    crossAxisCount: 1,
                    children: [
                      for (final document in documents) ...[
                        if (document['favourite'] == true)
                          SingleProductInListWidget(document: document),
                      ],
                    ],
                  );
                });
          }

          return MyAccountPageContent(email: widget.user.email);
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Sklep',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Szukaj',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: 'Obserwowane',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Konto',
            ),
          ],
        ),
      ),
    );
    // );
  }
}



// class ProductsPageContent extends StatelessWidget {
//   const ProductsPageContent({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       stream: FirebaseFirestore.instance.collection('products').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Coś poszło nie tak');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('Ładowanie');
//         }

//         final documents = snapshot.data!.docs;

//         return GridView.count(
//           crossAxisCount: 2,
//           childAspectRatio: 100 / 165,
//           children: [
//             for (final document in documents) ...[
//               SingleProductInListWidget(document: document),
//             ],
//           ],
//         );
//       },
//     );
//   }
//   // );
// }

// class SingleProductInListWidget extends StatefulWidget {
//   const SingleProductInListWidget({
//     super.key,
//     required this.document,
//   });

//   final QueryDocumentSnapshot<Map<String, dynamic>> document;

//   @override
//   State<SingleProductInListWidget> createState() =>
//       _SingleProductInListWidgetState();
// }

// class _SingleProductInListWidgetState extends State<SingleProductInListWidget> {
//   var isFavourite = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       height: 300,
//       width: 100,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 53, 53, 53),
//         borderRadius: BorderRadius.circular(1),
//       ),
//       margin: const EdgeInsets.all(0.5),

//       // color: Color.fromARGB(255, 53, 53, 53),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 4),
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 width: 187,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('images/produkt1.jpeg'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: FavoriteButton(
//                   isFavorite: false,
//                   valueChanged: (isFavorite) {},
//                 ),

//                 // IconButton(
//                 //   icon: Icon(
//                 //     isFavourite == false
//                 //         ? Icons.favorite_border_outlined
//                 //         : Icons.favorite,
//                 //     color: Colors.grey,
//                 //   ),
//                 //   onPressed: () {
//                 //     if (isFavourite == false) {
//                 //       setState(
//                 //         () {
//                 //           isFavourite = true;
//                 //         },
//                 //       );
//                 //     } else {
//                 //       setState(() {
//                 //         isFavourite = false;
//                 //       });
//                 //     }
//                 //   },
//                 // ),
//               )
//             ],
//           ),
//           const SizedBox(height: 5),
//           Row(
//             children: [
//               Text(
//                 // textAlign: ,
//                 widget.document['name'],
//                 style: GoogleFonts.abel(color: Colors.white, fontSize: 20),
//               ),
//             ],
//           ),
//           Text(
//             widget.document['producent'],
//             style: GoogleFonts.abel(color: Colors.white, fontSize: 15),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             'Cena ${widget.document['price'].toStringAsFixed(2).replaceAll('.', ',')} zł',
//             style: GoogleFonts.abel(color: Colors.white, fontSize: 25),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // }
