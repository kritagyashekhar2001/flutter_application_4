part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsFetched extends NewsState {
  final News? news;

  NewsFetched(this.news);
}

final class NewsError extends NewsState {}

final class NewsLoading extends NewsState {}
