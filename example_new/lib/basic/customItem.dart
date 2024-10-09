import 'dart:convert';

import 'package:echo_tform/echo_tform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// FileName customItem
///
/// @Author LinGuanYu
/// @Date 2024/8/27 17:00
///
/// @Description TODO

class CustomItem extends StatefulWidget {
  const CustomItem({super.key});

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {

  List<ChildItem> children = [];

  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = children.length;
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    children.add( ChildItem(index: children.length+1,));
                    setState(() {

                    });
                  },
                  child: const Row(children: [Text("点击加号添加"),Icon(Icons.add_circle_outline)])),
              ...children
            ]
        )
    );
  }


}

class ChildItem extends StatefulWidget {
  final int index;
  final VoidCallback? onDelete;
  const ChildItem({super.key, required this.index, this.onDelete});

  @override
  State<ChildItem> createState() => _ChildItemState();
}

class _ChildItemState extends State<ChildItem> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
            Text("第${widget.index}"),
            const Expanded(child: TextField()),
            IconButton(onPressed: (){

            }, icon: const Icon(Icons.close,color: Colors.red,))
          ]
        ),
      ),
    );
  }
}

class AddBill extends StatefulWidget {
  const AddBill({super.key, required this.row});
  final TFormRow row;
  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {

  final List<TextEditingController> _items = [];

  final _formKey = GlobalKey<FormState>();


  addItem(){

    submit();
    setState(() {
      _items.add(TextEditingController());
    });
  }

  deleteItem(int i ){

    setState(() {
      _items.removeAt(i);
    });
  }

  void submit(){
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    _formKey.currentState!.save();
    // Formd
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: (){
              addItem();
            },
            child: const Row(children: [Text("点击加号添加"),Icon(Icons.add_circle_outline)])),
        Form(
          key: _formKey,
          child: Column(
            children: [
              for(int i=0;i<_items.length;i++)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _items[i],
                            // validator: ,
                            onFieldSubmitted: (text){
                              widget.row.state[i] = text;
                              print("hahahah");
                              print(widget.row.state);
                            },

                            // onFieldSubmitted: (text){
                            //   widget.row.state[i]["picurl"] = text;
                            // },
                          ),
                        ),
                        InkWell(
                            child: const Icon(Icons.remove_circle,color: Colors.red,),
                            onTap: (){
                              deleteItem(i);
                            }
                        ),
                      ]
                    )
                  ]
                )
            ],
          )
        )
      ],
    );
  }
}
