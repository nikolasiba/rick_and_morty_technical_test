import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/location/model/location.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/locations/view_model/locations_vm.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_loading.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_text_field.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final locationViewModel = Provider.of<LocationViewModel>(context);
      locationViewModel.getCharacters(1);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationViewModel = Provider.of<LocationViewModel>(context);
    final sizePage = MediaQuery.of(context).size;

    final Debouncer onSearchDebouncer =
        Debouncer(delay: const Duration(milliseconds: 500));

    return Scaffold(
      backgroundColor: ConstColors.background,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'Locations',
          style:
              TextStyle(color: ConstColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              textEditingController: locationViewModel.searchController,
              hintText: 'Search',
              onChanged: (value) async {
                onSearchDebouncer(() => locationViewModel.searchLocations(1));
                // await Future.delayed(const Duration(milliseconds: 800),
                //     () => locationViewModel.searchLocations(1));
              },
            ),
          ),
          locationViewModel.locationListList.isNotEmpty
              ? Flexible(
                  fit: FlexFit.tight,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: locationViewModel.locationListList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _customCard(
                          locationViewModel.locationListList[index]);
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'there are no locations',
                    style: TextStyle(
                        color: ConstColors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
          SizedBox(
            height: sizePage.height * .05,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: locationViewModel.numPages,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    CustomLoading(context, title: '');
                    locationViewModel.searchController.text.isEmpty
                        ? await locationViewModel.getCharacters(index + 1)
                        : await locationViewModel.searchLocations(index + 1);
                    Future.delayed(const Duration(milliseconds: 500),
                        () => Navigator.pop(context));
                  },
                  child: Container(
                    height: sizePage.height * .2,
                    width: sizePage.width * .2,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text('${index + 1}',
                          style: locationViewModel.currentePage == index + 1
                              ? TextStyle(color: ConstColors.purple)
                              : TextStyle(color: ConstColors.greyUnknown)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _customCard(Location location) {
    final sizePage = MediaQuery.of(context).size;
    final TextStyle primaryTextStyle =
        TextStyle(color: ConstColors.purple, fontWeight: FontWeight.bold);
    final TextStyle secondTextStyle =
        TextStyle(color: ConstColors.white, fontWeight: FontWeight.bold);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: sizePage.height * .2,
          width: sizePage.width * .4,
          decoration: BoxDecoration(
            color: ConstColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: 'Nombre: ',
                      style: primaryTextStyle,
                      children: [
                    TextSpan(text: location.name, style: secondTextStyle)
                  ])),
              RichText(
                  text: TextSpan(
                      text: 'Type: ',
                      style: primaryTextStyle,
                      children: [
                    TextSpan(text: location.type, style: secondTextStyle)
                  ])),
              RichText(
                  text: TextSpan(
                      text: 'Dimension: ',
                      style: primaryTextStyle,
                      children: [
                    TextSpan(text: location.dimension, style: secondTextStyle)
                  ])),
            ],
          ),
        ));
  }
}
