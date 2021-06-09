import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  Map<String, List<Book>> items = {"gg": []};
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  var initialBuild = true;

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    var books = await  ApiService().getUserInventory(SharedPrefs().user);

    items = books;
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(initialBuild){
      return Scaffold(
        appBar: AppBar(
          title: Text(S.current.label_inventory),
          actions: <Widget>[],

        ),
        body: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<Map<String, List<Book>>> snapshot) {
          if(snapshot.hasData){
            this.items = snapshot.data!;
            initialBuild = false;
            return _buildSmartRefresher();
          } else {
            return Center(child: SizedBox( width: 60, height: 60, child: CircularProgressIndicator(color: Theme.of(context).accentColor,)));
          }
        },
          future: ApiService().getUserInventory(SharedPrefs().user),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.current.label_inventory),
          actions: <Widget>[],
        ),
        body: _buildSmartRefresher(),
      );
    }

  }

  SmartRefresher _buildSmartRefresher() {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: GroupedListView<Book, String>(
        separator: SizedBox(
        height: 5,
        ),
        itemBuilder: (c, i) {
          return Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: i.thumbnail != null ? Image.network(i.thumbnail!) :  Icon(Icons.book),
            title: Text(i.title!),
          ));
        },
        groupSeparatorBuilder: (String groupByValue) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(groupByValue, style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
        ),
        groupBy: (Book? element) {
          if(items["donated"]!.contains(element)){
            return "Donated";
          } else {
            return "Borrowed";
          }
        },
        elements: items["donated"]! + items["borrowed"]!,
      ),
    );
  }
}
