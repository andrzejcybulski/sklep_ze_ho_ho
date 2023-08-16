import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sklep_ze_ho_ho/app/home/products/cubit/products_cubit.dart';

class ProductsPageContent extends StatelessWidget {
  const ProductsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..start(),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                'Coś poszło nie tak: ${state.errorMessage}',
              ),
            );
          }

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          final documents = state.documents;

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 100 / 165,
            children: [
              for (final document in documents) ...[
                SingleProductInListWidget(document: document),
              ],
            ],
          );
        },
      ),
    );
  }
  // );
}

class SingleProductInListWidget extends StatefulWidget {
  const SingleProductInListWidget({
    super.key,
    required this.document,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  State<SingleProductInListWidget> createState() =>
      _SingleProductInListWidgetState();
}

class _SingleProductInListWidgetState extends State<SingleProductInListWidget> {
  var isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      height: 300,
      width: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 53, 53, 53),
        borderRadius: BorderRadius.circular(1),
      ),
      margin: const EdgeInsets.all(0.5),

      // color: Color.fromARGB(255, 53, 53, 53),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 200,
                width: 187,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/produkt1.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: FavoriteButton(
                  isFavorite: false,
                  valueChanged: (isFavorite) {},
                ),

                // IconButton(
                //   icon: Icon(
                //     isFavourite == false
                //         ? Icons.favorite_border_outlined
                //         : Icons.favorite,
                //     color: Colors.grey,
                //   ),
                //   onPressed: () {
                //     if (isFavourite == false) {
                //       setState(
                //         () {
                //           isFavourite = true;
                //         },
                //       );
                //     } else {
                //       setState(() {
                //         isFavourite = false;
                //       });
                //     }
                //   },
                // ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                // textAlign: ,
                widget.document['name'],
                style: GoogleFonts.abel(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          Text(
            widget.document['producent'],
            style: GoogleFonts.abel(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 15),
          Text(
            'Cena ${widget.document['price'].toStringAsFixed(2).replaceAll('.', ',')} zł',
            style: GoogleFonts.abel(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
// }
