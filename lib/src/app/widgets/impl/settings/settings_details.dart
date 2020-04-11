import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:flutter_settings/models/settings_list_item.dart';
import 'package:flutter_settings/widgets/SettingsIcon.dart';
import 'package:flutter_settings/widgets/SettingsInputField.dart';
import 'package:flutter_settings/widgets/SettingsSelectionList.dart';
import 'package:provider/provider.dart';

class SettingsDetails extends StatefulWidget {
  @override
  _SettingsDetailsState createState() => _SettingsDetailsState();
}

class _SettingsDetailsState extends State<SettingsDetails> {
  String apiKeyValue = '';
  String countryFlagValue = 'ar';
  String caption;
  int chooseIndex = 0;

  List<SettingsSelectionItem<String>> countriesSelection;
  LocalStorageService localStorageService;

  @override
  void initState() {
    localStorageService = Provider.of<LocalStorageService>(
      context,
      listen: false,
    );

    countriesSelection = _buildCountriesSelection();
    localStorageService.getData().then((data) {
      setState(() {
        apiKeyValue = data.apiKey ?? '';
        countryFlagValue = data.countryFlag ?? 'ar';
        caption = _updateCaption();
        chooseIndex = _updateChooseIndex();
      });
    });

    super.initState();
  }

  String _updateCaption() => countriesSelection
      .where((element) => element.value == countryFlagValue)
      .first
      .text;

  int _updateChooseIndex() => countriesSelection
      .indexWhere((element) => element.value == countryFlagValue);

  List<SettingsSelectionItem<String>> _buildCountriesSelection() =>
      localStorageService
          .countries()
          .map((e) => SettingsSelectionItem<String>(e.flag, e.name)).toList();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: _buildWidgetSettingsDetails(mediaQuery),
    );
  }

  Widget _buildWidgetSettingsDetails(MediaQueryData mediaQuery) {
    return Column(
      children: <Widget>[
        SettingsInputField(
          icon: new SettingsIcon(
            icon: Icons.lock_outline,
            color: Colors.blue,
          ),
          dialogButtonText: 'Done',
          title: 'Edit your API Key',
          caption: '$apiKeyValue',
          onPressed: (value) {
            if (value.toString().isNotEmpty) {
              setState(() {
                apiKeyValue = value ?? apiKeyValue;
              });
              localStorageService.setApiKey(apiKeyValue);
            }
          },
          context: context,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: SettingsSelectionList2<String>(
                items: countriesSelection,
                chosenItemIndex: chooseIndex,
                title: 'News Country',
                dismissTitle: 'Cancel',
                caption: caption,
                icon: new SettingsIcon(
                  icon: Icons.flag,
                  color: Colors.blue,
                ),
                onSelect: (value, index) {
                  setState(() {
                    countryFlagValue =
                        countriesSelection.elementAt(index).value;
                    caption = _updateCaption();
                    chooseIndex = _updateChooseIndex();
                  });
                  localStorageService.setCountryFlag(countryFlagValue);
                },
                context: context,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flags.getMiniFlag(countryFlagValue.toUpperCase(), 16, 16),
            ),
          ],
        ),
      ],
    );
  }
}
