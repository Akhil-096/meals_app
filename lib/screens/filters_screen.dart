import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters, {Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;


  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian']as bool;
    _vegan = widget.currentFilters['vegan']as bool;
    _lactoseFree = widget.currentFilters['lactose']as bool;
  }

  Widget _buildSwitchListTile(
      String title, String subTitle, bool value, Function(dynamic) function) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        value: value,
        onChanged: function);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [IconButton(onPressed: (){
          final selectedFilters = {
            'gluten':_glutenFree,
            'vegetarian':_vegetarian,
            'vegan':_vegan,
            'lactose':_lactoseFree,

          };
          widget.saveFilters(selectedFilters);
        }, icon: const Icon(Icons.save))],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-Free', 'Only includes gluten free food', _glutenFree,
                  (value) {
                setState(() {
                  _glutenFree = value;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only includes vegetarian food', _vegetarian,
                  (value) {
                setState(() {
                  _vegetarian = value;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only includes vegan food', _vegan,
                  (value) {
                setState(() {
                  _vegan = value;
                });
              }),
              _buildSwitchListTile('Lactose-Free',
                  'Only includes lactose free food', _lactoseFree, (value) {
                setState(() {
                  _lactoseFree = value;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
