// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$urlVideoAtom =
      Atom(name: 'HomeStoreBase.urlVideo', context: context);

  @override
  String? get urlVideo {
    _$urlVideoAtom.reportRead();
    return super.urlVideo;
  }

  @override
  set urlVideo(String? value) {
    _$urlVideoAtom.reportWrite(value, super.urlVideo, () {
      super.urlVideo = value;
    });
  }

  late final _$getUrlVideoAsyncAction =
      AsyncAction('HomeStoreBase.getUrlVideo', context: context);

  @override
  Future<void> getUrlVideo() {
    return _$getUrlVideoAsyncAction.run(() => super.getUrlVideo());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
urlVideo: ${urlVideo}
    ''';
  }
}
