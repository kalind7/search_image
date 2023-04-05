import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/provider/provider.dart';

import '../models/models.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.list,
    this.showFav = true,
  });

  final List<dynamic> list;
  final bool showFav;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260,
          crossAxisSpacing: 10,
        ),
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Hit imageDatas = list[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: Hero(
                      tag: imageDatas,
                      transitionOnUserGestures: true,
                      child: CachedNetworkImage(
                        imageUrl: '${imageDatas.largeImageUrl}',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Image.network(
                            'https://cdn.pixabay.com/user/2023/04/03/02-11-23-81_250x250.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  showFav
                      ? Consumer<HomeProvider>(
                          builder: (context, homeProv, child) {
                          return InkWell(
                            onTap: () {
                              if (homeProv.favouriteList.contains(imageDatas)) {
                                homeProv.removeFavourite(imageDatas);
                              } else {
                                homeProv.addFavouriteDatas(imageDatas);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                homeProv.favouriteList.contains(imageDatas)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_sharp,
                                color:
                                    homeProv.favouriteList.contains(imageDatas)
                                        ? Colors.red
                                        : Colors.black,
                              ),
                            ),
                          );
                        })
                      : Consumer<HomeProvider>(builder: (context, prov, child) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                          'Are you sure you to remove ${imageDatas.user} from your wishlist',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        content: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  prov.removeFavourite(
                                                      imageDatas);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        ),
                                      ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                            ),
                          );
                        })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${imageDatas.user}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${imageDatas.imageSize}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
            ],
          );
        });
  }
}
