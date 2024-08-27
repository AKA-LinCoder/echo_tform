import 'package:flutter/material.dart';

class TFormSelectorPage extends StatefulWidget {
  TFormSelectorPage(
      {Key? key,
      required this.options,
      required this.isMultipleSelector,
      required this.title, required this.needSearch})
      : super(key: key);

  final String title;
  final List<TFormOptionModel> options;
  final bool isMultipleSelector;
  final bool needSearch;

  @override
  State<TFormSelectorPage> createState() => _TFormSelectorPageState();
}

class _TFormSelectorPageState extends State<TFormSelectorPage> {


  TextEditingController searchController = TextEditingController();

  List<TFormOptionModel> originalList = []; // 假设这是你原始的数据
  List<TFormOptionModel> filteredList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    originalList = widget.options;
    filteredList.addAll(originalList);
  }

  void filterSearchResults(String query) {
    List<TFormOptionModel> dummySearchList = [];
    dummySearchList.addAll(originalList);
    if (query.isNotEmpty) {
      List<TFormOptionModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.value.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredList.clear();
        filteredList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(originalList);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Container(),
        actions: [
          widget.isMultipleSelector
              ? TextButton(
                  child: const Text(
                    "完成",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    String values = widget.options
                        .where((element) => element.selected)
                        .map((e) => e.value)
                        .toList()
                        .join(",");
                    Navigator.of(context).pop(values);
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: widget.needSearch?ListView.builder(
        itemCount: filteredList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              height: 50,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child:  Center(
                child: Row(children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "搜索",
                      border: InputBorder.none,
                      isDense: false,
                    ),
                    textInputAction: TextInputAction.search,
                        onChanged: filterSearchResults,
                        // onTap: ,
                        onSubmitted: filterSearchResults,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.search),
                ]),
              ),
            );
          } else {
            return LTListTitle(
              isMultipleSelector: widget.isMultipleSelector,
              model: filteredList[index - 1],
              options: filteredList,
            );
          }
        },
      ):ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return LTListTitle(
            isMultipleSelector: widget.isMultipleSelector,
            model: filteredList[index],
            options: filteredList,
          );
        },
      ),
    );
  }
}

class LTListTitle extends StatefulWidget {
  LTListTitle(
      {Key? key,
      required this.model,
      required this.isMultipleSelector,
      required this.options})
      : super(key: key);
  final TFormOptionModel model;
  final bool isMultipleSelector;
  final List<TFormOptionModel> options;

  @override
  _LTListTitleState createState() => _LTListTitleState();
}

class _LTListTitleState extends State<LTListTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.isMultipleSelector) {
          setState(() {
            widget.model.selected = !widget.model.selected;
          });
        } else {
          widget.options.map((e) => e.selected = false).toList();
          widget.model.selected = true;
          Navigator.of(context).pop(widget.model.value);
        }
      },
      selected: widget.model.selected,
      title: Text(widget.model.value),
      trailing: widget.isMultipleSelector && widget.model.selected
          ? const Icon(Icons.done)
          : const SizedBox.shrink(),
    );
  }
}

class TFormOptionModel {
  final int? index;
  final String value;
  bool selected;

  TFormOptionModel({required this.value, this.selected = false, this.index});
}
