import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/model/item.dart';
import 'package:flutter_mvvm/data/repository/item_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'home_model.freezed.dart';

@freezed
abstract class HomeModel with _$HomeModel {
  const factory HomeModel({@Default([]) List<Item> items}) =
      _HomeModel;
}

class HomeStateNotifier extends StateNotifier<HomeModel> {
  final IItemRepository _itemRepository;

  HomeStateNotifier(this._itemRepository) : super(HomeModel()) {
    _getItems();
  }

  _getItems() {
    _itemRepository.getItems().listen((it) {
      state = state.copyWith(items: it.toList());
    });
  }
}
