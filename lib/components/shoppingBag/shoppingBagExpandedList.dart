import 'package:flutter/material.dart';

class ShoppingBagExpandedList extends StatefulWidget {
  final Map<dynamic, dynamic> item;
  final Function (String colorName) colorList;
  final Function (Map items) openParticularItem;
  final Function (BuildContext context, Map item) removeItemAlertBox;

  ShoppingBagExpandedList(this.item, this.colorList, this.openParticularItem, this.removeItemAlertBox);
  @override
  _ShoppingBagExpandedListState createState() => _ShoppingBagExpandedListState();
}

class _ShoppingBagExpandedListState extends State<ShoppingBagExpandedList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Size',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.item['selectedSize'].toString().length == 0 ? 'None':widget.item['selectedSize'],
                          style: TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 1.0
                          ),
                        )
                      ],
                    )
                ),
              ),
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Color',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.colorList(widget.item['selectedColor']),
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        )
                      ],
                    )
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "${widget.item['quantity']}",
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 7.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigoAccent, width: 4.0),
                      color: Colors.indigo[900],
                      shape: BoxShape.circle
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      widget.openParticularItem(widget.item);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.edit,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4.0),
                      color: Colors.red[900],
                      shape: BoxShape.circle
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      widget.removeItemAlertBox(context,widget.item);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.remove_shopping_cart,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
