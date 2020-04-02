part of 'page_data_bloc.dart';

abstract class PageDataEvent extends Equatable {
  const PageDataEvent();
}
class GetData extends PageDataEvent{
  @override
  List<Object> get props =>[];

}