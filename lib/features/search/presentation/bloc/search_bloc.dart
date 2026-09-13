import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/global_search_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GlobalSearchUsecase _globalSearchUsecase;

  SearchBloc(this._globalSearchUsecase) : super(const SearchState()) {
    on<PerformSearchEvent>(_onPerformSearch);
    on<ClearSearchQueryEvent>(_onClearSearch);
  }

  Future<void> _onPerformSearch(
      PerformSearchEvent event, Emitter<SearchState> emit) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(state.copyWith(query: event.query, isLoading: true));

    final result = await _globalSearchUsecase(query);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false)),
      (data) => emit(state.copyWith(
        isLoading: false,
        rooms: data.rooms,
        messages: data.messages,
        contacts: data.contacts,
      )),
    );
  }

  void _onClearSearch(
      ClearSearchQueryEvent event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}
