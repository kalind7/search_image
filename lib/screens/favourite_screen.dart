import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/provider/provider.dart';
import 'package:search_image/widgets/widgets.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Favourite Page'),
            floating: true,
            snap: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Consumer<HomeProvider>(builder: (context, prov, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
                  //   child: Text(
                  //     'Favourites',
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomGridView(
                    list: prov.favouriteList,
                    showFav: false,
                  )
                ],
              );
            })
          ]))
        ],
      ),
    );
  }
}
