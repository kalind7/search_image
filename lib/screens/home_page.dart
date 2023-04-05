import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/provider/provider.dart';
import 'package:search_image/screens/screens.dart';
import 'package:search_image/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var autoFocus = context.watch<HomeProvider>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // autoFocus.toggleAutoFocus(false);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Search Page'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FavouriteScreen()));
                    },
                    icon: const Icon(
                      Icons.favorite_outline_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Consumer<HomeProvider>(
                            builder: (context, homeProv, child) {
                          return NotificationListener<ScrollNotification>(
                            onNotification: homeProv.loadMoreData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customTextField(context,
                                    formKey: formKey, homeProv: homeProv),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 7.5),
                                  child: Text(
                                    'Suggestions',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                homeProv.hitList.isEmpty
                                    // ||
                                    //         homeProv.autoFocus == false
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : (homeProv.isLoading
                                        ? const Center(
                                            child: Text('No Datas'),
                                          )
                                        : CustomGridView(
                                            list: homeProv.hitList,
                                          )),
                                if (homeProv.paginationLoading)
                                  const Center(
                                      child: Text('Loading more data ....'))
                              ],
                            ),
                          );
                        }),
                    childCount: 1)),
          ],
        ),
      ),
    );
  }
}
