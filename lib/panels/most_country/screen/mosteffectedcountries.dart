
import 'package:covid_19/panels/pages/country_screen/bloc/country_bloc.dart';
import 'package:covid_19/panels/pages/country_screen/bloc/country_event.dart';
import 'package:covid_19/panels/pages/country_screen/bloc/country_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_builder.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

class MosteffectedPanel extends StatefulWidget {
  final List? countryData;

  const MosteffectedPanel({super.key, required this.countryData});

  @override
  State<MosteffectedPanel> createState() => _MosteffectedPanelState();
}

class _MosteffectedPanelState extends State<MosteffectedPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryBloc()..add(InitCountry()),
      child: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          final products = state.listCountry ?? [];
          if (state.status == BlocStatusEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (products.isEmpty) {
            return const Center(
              child: Text("Không có sản phẩm nào!"),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Image.network(
                      products[index].countryInfo?.flag ?? '',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      products[index].country ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ĐÃ TỬ VONG ' '${products[index].deaths}',
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
              //?
            },
            itemCount: 5,
          );
        },
      ),
    );
  }
}
