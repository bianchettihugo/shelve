import 'package:flutter/foundation.dart';

abstract class PageState<L extends Exception, S extends Object?> {
  bool get isSuccess => this is SuccessState;

  bool get isLoading => this is LoadingState;

  bool get isError => this is ErrorState;

  S get data => (this as SuccessState).sdata as S;

  L get error => (this as ErrorState).eerror as L;
}

class InitialState<L extends Exception, S extends Object?>
    extends PageState<L, S> {}

class SuccessState<L extends Exception, S extends Object?>
    extends PageState<L, S> {
  final S sdata;

  SuccessState(this.sdata);
}

class ErrorState<L extends Exception, S extends Object?>
    extends PageState<L, S> {
  final L eerror;

  ErrorState(this.eerror);
}

class LoadingState<L extends Exception, S extends Object?>
    extends PageState<L, S> {}

class ReactiveState<L extends Exception, S>
    extends ValueNotifier<PageState<L, S>> {
  ReactiveState() : super(InitialState<L, S>());

  void changeToLoadingState() {
    value = LoadingState();
  }

  void changeToSuccessState(S data) {
    value = SuccessState(data);
  }

  void changeToErrorState(L error) {
    value = ErrorState(error);
  }

  void changeState(PageState<L, S> state) {
    value = state;
  }

  bool get isLoading => value.isLoading;

  bool get isSuccess => value.isSuccess;

  bool get isError => value.isError;

  S get data => value.data;

  L get error => value.error;

  PageState<L, S> get stateValue => value;
}
