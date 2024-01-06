import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Category> categoiries = [
    Category('business'),
    Category('entertainment'),
    Category('general'),
    Category('health'),
    Category('science'),
    Category('sports'),
    Category('technology'),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haberler'), //appbar
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getCategoriesTab(vm),
            ),
          ),
          getWidgetByStatus(vm)
        ],
      ),
    );
  }

  List<GestureDetector> getCategoriesTab(ArticleListViewModel vm) {
    List<GestureDetector> list = [];
    for (int i = 0; i < categoiries.length; i++) {
      list.add(GestureDetector(
        onTap: () => vm.getNews(categoiries[i].key),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            categoiries[i].key,
            style: const TextStyle(fontSize: 16),
          ),
        )),
      ));
    }
    return list;
  }

  Widget getWidgetByStatus(ArticleListViewModel vm) {
    switch (vm.status.index) {
      case 2:
        return Expanded(
            child: ListView.builder(
                itemCount: vm.viewModel.articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(vm.viewModel.articles[index].urlToImage ??
                            ''), // resimlerin çekilmesi.
                        ListTile(
                          title: Text(
                            vm.viewModel.articles[index].title ?? '',
                            style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold), // başlıkların çekilmesi.
                          ),
                          subtitle: Text(
                              vm.viewModel.articles[index].description ??
                                  ''), //açıklama kısmının çekilmesi.
                        ),
                        ButtonBar(
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(
                                    vm.viewModel.articles[index].url ??
                                        '')); //Haber detay çekilmesi.
                              },
                              child: const Text(
                                'Habere Git',
                                style: TextStyle(
                                    color: Colors.blue), //detay açım buton.
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }));
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
