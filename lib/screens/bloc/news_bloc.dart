import 'package:bloc/bloc.dart';
import 'package:flutter_application_4/screens/data/models/news_model.dart';
import 'package:flutter_application_4/screens/data/service/news_service.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      try {
        emit(NewsLoading());
        News? newsData = await NewsService().fetchNews(event.key);
        emit(NewsFetched(newsData));
      } catch (e) {
        emit(NewsError());
      }
    });
  }
}
