import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/baycootItemDetails.dart';
import 'package:alternative_new/Screens/itemDetailsScreen.dart';
import 'package:alternative_new/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.Item});

  final GridItemModel Item;



  @override
  Widget build(BuildContext context) {
    void _showDetails(){
      recentlyViewed.add(Item);
      if(Item.isBaycoot == 0)
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => BaycootItemDetails(Item: Item)));
      else
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => ItemDetails(Item: Item)));
    }
    // TODO: implement build
    var smallImage;
    if ( Item.isBaycoot == 0)
      smallImage = 'assets/images/false.png';
    else
      smallImage = 'assets/images/true.png';
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: InkWell(
                    onTap: _showDetails,
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        memCacheHeight: 200,
                        memCacheWidth: 200,

                        imageUrl: Item.image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset('assets/images/logo1.jpg'),
                      ),
                    ),)),
            ),
           Container(
             margin: EdgeInsets.only(left: 0),
             child:  Image.asset(smallImage),
           ),
          ],
        ),
      ),
    );
  }
}
