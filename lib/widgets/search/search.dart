import 'dart:async';
import 'dart:ui';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import './../gmap.dart';
import '../bookcasemodel.dart';
import 'search_model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FloatingSearchBarController? controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer<SearchModel>(
      builder: (context, model, _) => FloatingSearchBar(
        hint: S.current.label_search,
        implicitCurve: Curves.bounceInOut,
        backgroundColor: Theme.of(context).cardColor,
        scrollPadding: const EdgeInsets.only(top: 10, bottom: 100),
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        borderRadius: BorderRadius.circular(12),
        openAxisAlignment: 0.0,
        clearQueryOnClose: true,
        isScrollControlled: false,
        width: isPortrait ? 600 : 500,
        progress: model.isLoading,
        padding: EdgeInsets.only(left: 15, right: 15),
        insets: EdgeInsets.zero,
        textInputAction: TextInputAction.search,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        actions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(Icons.place),
              onPressed: currentLocation,
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) => ExpandableSearchBody(model),
      ),
    );
  }
}

class ExpandableSearchBody extends StatelessWidget {
  ExpandableSearchBody(this.model, {Key? key}) : super(key: key);

  final SearchModel model;

  // Maybe with blur?
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Material(
                color: Theme.of(context).cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                child: ImplicitlyAnimatedList<Map>(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  items: model.suggestions.take(5).toList(),
                  areItemsTheSame: (a, b) => a == b,
                  itemBuilder: (context, animation, bookCase, i) {
                    return SizeFadeTransition(
                      animation: animation,
                      child: ListItem(bookCase, model),
                    );
                  },
                  updateItemBuilder: (context, animation, bookCase) {
                    return FadeTransition(
                      opacity: animation,
                      child: ListItem(bookCase, model),
                    );
                  },
                ),
              ),
            )));
  }
}

class ListItem extends StatelessWidget {
  final Map data;
  final SearchModel model;

  ListItem(this.data, this.model);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context)!.close();
            goToLocation(
              double.parse(data['location'].lat),
              double.parse(data['location'].lon),
            ).then((value) {
              // Dirty workaround as we don't have another way to control it
              Timer(
                  Duration(milliseconds: 1100),
                  () => showModalBottomSheet(
                      backgroundColor:
                          Theme.of(context).cardColor.withOpacity(0.6),
                      context: context,
                      builder: (builder) {
                        return BookCaseModel(data['location']);
                      }));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: data['icon'] == 'asset'
                          ? Image.asset("assets/icons/book_case.png")
                          : Image(
                              image: NetworkImage(data['icon']),
                            )),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data['subtitle'],
                        style: textTheme.bodyText2!
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
