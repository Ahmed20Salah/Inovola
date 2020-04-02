import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invola_task/repos/data_repo.dart';

part 'page_data_event.dart';
part 'page_data_state.dart';

class PageDataBloc extends Bloc<PageDataEvent, PageDataState> {
  @override
  PageDataState get initialState => PageDataInitial();
  @override
  Stream<PageDataState> mapEventToState(
    PageDataEvent event,
  ) async* {
    var repo = PageRepository();

    if (event is GetData) {
      var re = await repo.getData();
      yield Loading();
      if (re['status']) {
        yield HaveData();
      } else {
        yield Error(re['errors']);
      }
    }
  }
}
