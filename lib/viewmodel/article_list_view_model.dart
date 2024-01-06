import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/articles.dart';
import 'package:flutter_application_1/services/news.service.dart';
import 'package:flutter_application_1/viewmodel/article_view_model.dart';

enum Status {
  initial,
  loading,
  loaded,
}

class ArticleListViewModel extends ChangeNotifier {
  ArticleViewModel viewModel = ArticleViewModel('general', []);
  Status status = Status.initial;

  ArticleListViewModel() {
    getNews('general');
  }

  Future<void> getNews(String category) async {
    status = Status.loading;
    notifyListeners();
    viewModel.articles = await NewsService().fetchNews(category);
    status = Status.loaded;
    notifyListeners();
  }
}
