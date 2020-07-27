import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvvm/data/model/item.dart';

abstract class IItemRepository {
  Stream<List<Item>> getItems();
}

class ItemRepository implements IItemRepository {
  @override
  Stream<List<Item>> getItems() {
    return Firestore.instance.collection('items').snapshots().map(
        (event) => event.documents
            .map((it) => Item(name: it.data["name"]))
            .toList());
  }
}
