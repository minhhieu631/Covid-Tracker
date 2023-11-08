
import 'package:covid_19/home_page/home_page_screen/bloc/home_page_bloc.dart';
import 'package:covid_19/home_page/home_page_screen/bloc/home_page_event.dart';
import 'package:covid_19/home_page/home_page_screen/bloc/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_builder.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

class WorldwidePanel extends StatelessWidget {
  const WorldwidePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(InitHomePage()),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final homePageModels = state.homePageModel;
          if (state.status == BlocStatusEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == BlocStatusEnum.failed) {
            return const Text('loi roi');
          } else {
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2),
              children: [
                StatusPanel(
                  title: 'SỐ CA NHIỄM',
                  panelColor: Colors.red.shade100,
                  textColor: Colors.red,
                  count: '${homePageModels?.cases}',
                ),
                StatusPanel(
                  title: 'ĐANG PHỤC HỒI',
                  panelColor: Colors.blue.shade100,
                  textColor: Colors.blue.shade900,
                  count: '${homePageModels?.active}',
                ),
                StatusPanel(
                    title: 'ĐÃ KHỎI BỆNH',
                    panelColor: Colors.green.shade100,
                    textColor: Colors.green,
                    count: '${homePageModels?.recovered}'),
                StatusPanel(
                    title: 'ĐÃ TỬ VONG',
                    panelColor: Colors.grey.shade400,
                    textColor: Colors.grey.shade900,
                    count: '${homePageModels?.recovered}'),
              ],
            );
          }
        },
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {super.key,
        required this.panelColor,
        required this.textColor,
        required this.title,
        required this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
          Text(count,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor))
        ],
      ),
    );
  }
}
