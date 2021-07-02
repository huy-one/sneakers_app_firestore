import 'package:flutter/material.dart';
class ImageSwipe extends StatefulWidget {
  final List itemList;

  const ImageSwipe({Key? key, required this.itemList}) : super(key: key);


  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage =0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:500,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedPage=num;
              });
            },
            children: [
              for(int i=0;i<widget.itemList.length;i++)
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,50),
                        blurRadius: 70
                      )
                    ]
                  ),
                  child: Image.network(widget.itemList[i],fit: BoxFit.fitWidth),
                ),
            ],
          )
        ],
      ),
    );
  }
}
