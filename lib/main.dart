import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/repository/item_repository.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'data/model/item.dart';
import 'home/home_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    Provider<IItemRepository>.value(value: ItemRepository()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text("Flutter MVVM")),
          body: StateNotifierProvider<HomeStateNotifier, HomeModel>(
              create: (_) => HomeStateNotifier(context.read()),
              child: _ItemsWidget())),
    );
  }
}

class _ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Item> items =
        context.select((HomeModel model) => model.items);

    return ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text(items[index].name));
        },
        separatorBuilder: (_, __) {
          return const Divider();
        });
  }
}
