import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/baycootItemDetails.dart';
import 'package:alternative_new/Screens/itemDetailsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.Item});

  final GridItemModel Item;



  @override
  Widget build(BuildContext context) {
    void _showDetails(){
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
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
              child: InkWell(
                onTap: _showDetails,
                  child: CachedNetworkImage(
                    memCacheHeight: 200,
                    memCacheWidth: 200,

                    imageUrl: Item.image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset('assets/images/logo1.jpg'),
                  ),)),
          Image.asset(smallImage),
        ],
      ),
    );
  }
}
