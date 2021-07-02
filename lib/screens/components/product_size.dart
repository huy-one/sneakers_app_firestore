import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List itemList;
  final Function(String) onSelected;
  const ProductSize({Key? key, required this.itemList, required this.onSelected}) : super(key: key);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected =0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Size',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              for(var i=0;i<widget.itemList.length;i++)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      widget.onSelected('${widget.itemList[i]}');
                      setState(() {
                        _selected =i;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selected== i?   Colors.blueAccent: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      alignment: Alignment.center,
                      child: Text(widget.itemList[i],style: TextStyle(
                        fontSize: 20,
                        color: _selected==i ? Colors.white :Colors.black
                      ),),
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
