import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList>
    with TickerProviderStateMixin {
  Map<String, List<Book>> items = {"": []};
  RefreshController _refreshControllerDonated =
      RefreshController(initialRefresh: false);
  RefreshController _refreshControllerBorrowed =
      RefreshController(initialRefresh: false);
  late TabController _tabController;
  var initialBuild = true;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    var books = await ApiService().getUserInventory(SharedPrefs().user);

    items = books;

    // just refresh both
    _refreshControllerDonated.refreshCompleted();
    _refreshControllerBorrowed.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    if (initialBuild) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.current.label_inventory),
          actions: <Widget>[],
          bottom: TabBar(
            controller: _tabController,
            tabs: [Tab(text: "Borrowed"), Tab(text: "Donated")],
          ),
        ),
        body: FutureBuilder(
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, List<Book>>> snapshot) {
            if (snapshot.hasData) {
              this.items = snapshot.data!;
              initialBuild = false;
              return TabBarView(
                controller: _tabController,
                children: [
                  _buildSmartRefresher("b", _refreshControllerBorrowed),
                  _buildSmartRefresher("d", _refreshControllerDonated),
                ],
              );
            } else {
              return Center(
                  child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      )));
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
            bottom: TabBar(
              controller: _tabController,
              tabs: [Tab(text: "Borrowed"), Tab(text: "Donated")],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildSmartRefresher("b", _refreshControllerBorrowed),
              _buildSmartRefresher("d", _refreshControllerDonated),
            ],
          ));
    }
  }

  SmartRefresher _buildSmartRefresher(
      String type, RefreshController _refreshController) {
    if (type == "d") {
      return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: items['donated']!.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: items['donated']![index].thumbnail != null
                              ? Image.network(
                                  items['donated']![index].thumbnail!)
                              : Icon(Icons.book),
                          title: Text(items['donated']![index].title!),
                        ))),
              ),
            );
          },
        ),
      );
    } else {
      return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: items['borrowed']!.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: items['borrowed']![index].thumbnail != null
                              ? Image.network(
                                  items['borrowed']![index].thumbnail!)
                              : Icon(Icons.book),
                          title: Text(items['borrowed']![index].title!),
                        ))),
              ),
            );
          },
        ),
      );
    }
    ;
  }
}
