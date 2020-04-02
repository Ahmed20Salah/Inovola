part of 'page_data_bloc.dart';

abstract class PageDataState extends Equatable {
  const PageDataState();
}

class PageDataInitial extends PageDataState {
  @override
  List<Object> get props => [];
}

class HaveData extends PageDataState {
  @override
  List<Object> get props => [];
}

class Loading extends PageDataState {
  @override
  List<Object> get props => [];
}

class Error extends PageDataState {
  final String error;
  Error(this.error);
  @override
  List<Object> get props => [];
}
