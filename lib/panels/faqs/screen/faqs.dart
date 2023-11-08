import 'package:covid_19/datasource/datasorce.dart';
import 'package:flutter/material.dart';

class FAQS extends StatelessWidget {
  const FAQS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CÁC CÂU HỎI VỀ COVID-19'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              DataSource.questionAnswers[index]['question'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(DataSource.questionAnswers[index]['answer']))
            ],
          );
        },
        itemCount: DataSource.questionAnswers.length,
      ),
    );
  }
}
