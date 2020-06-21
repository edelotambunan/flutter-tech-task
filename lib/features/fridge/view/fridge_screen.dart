import 'package:flutter/material.dart';
import 'package:tech_task/core/networking/api_response.dart';
import 'package:tech_task/core/widget/app_error_widget.dart';
import 'package:tech_task/core/widget/app_list_tile.dart';
import 'package:tech_task/core/widget/app_loading_widget.dart';
import 'package:tech_task/features/fridge/blocs/fridge_bloc.dart';
import 'package:tech_task/features/fridge/models/fridge.dart';

class FridgeScreen extends StatefulWidget {

  @override
  _FridgeScreenState createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  FridgeBloc _fridgeBloc;
  Fridge _fridge;
  bool isFirstLoad;

  @override
  void initState() {
    super.initState();
    isFirstLoad = true;
    _fridge = Fridge.empty();
    _fridgeBloc = FridgeBloc();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _selectDate(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fridge')
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text(_fridge.selectedDate.year.toString()
                  + "-" + _fridge.selectedDate.month.toString()
                  + '-' + _fridge.selectedDate.day.toString()),
              onPressed: () => _selectDate(context)
          ),
          const Divider(
            color: Colors.black,
            height: 10,
            thickness: 3,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child:RefreshIndicator(
              onRefresh: () => _fridgeBloc.getFridge(),
              child: StreamBuilder<ApiResponse<Fridge>>(
                stream: _fridgeBloc.fridgeStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return AppLoadingWidget(loadingMessage: snapshot.data.message);
                        break;
                      case Status.COMPLETED:
                        _fridge = snapshot.data.data;
                        return ListView.builder(
                          itemCount: _fridge.ingredientList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: AppListTile(
                                    listTile : ListTile(
                                      title: Text('${_fridge.ingredientList[index].title}'),
                                      subtitle: Text('Usable until: ${_fridge.ingredientList[index].useBy}'),
                                      selected: _fridge.ingredientList[index].isSelected,
                                      onTap: () {
                                        setState(() {
                                          if (_fridge.ingredientList[index].isSelected)
                                            _fridge.ingredientList[index].isSelected = false;
                                          else
                                            _fridge.ingredientList[index].isSelected = true;
                                          });
                                        },
                                        enabled:!_fridge.ingredientList[index].isPastUseBy(_fridge.selectedDate)
                                    ),
                                ),
                            );
                          },
                        );
                        break;
                      case Status.ERROR:
                        return AppErrorWidget(
                          errorMessage: snapshot.data.message,
                          onRetryPressed: () => _fridgeBloc.getFridge(),
                        );
                        break;
                    }
                  }
                  return Container();
                },
              ),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
//        onPressed: () => setState(() => _count++),
        tooltip: 'Find recipes',
        child: const Icon(Icons.search),
      )
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fridge.selectedDate,
        firstDate: DateTime.now(),
        //use this line instead above line for testing backwards date
//        firstDate: DateTime(2000),
        lastDate: DateTime(2200));
    if (picked != null && picked != _fridge.selectedDate)
      setState(() {
        _fridge.selectedDate = picked;
        _fridge.clearSelection();
      });
  }
}

class FridgeView extends StatelessWidget {
  final Fridge fridge;

  const FridgeView({Key key, this.fridge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fridge.ingredientList.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
              title: Text('${fridge.ingredientList[index].title}'),
              subtitle: Text('Usable until: ${fridge.ingredientList[index].useBy}'),
              selected: fridge.ingredientList[index].isSelected,
              onTap: () {
                  if (fridge.ingredientList[index].isSelected)
                    fridge.ingredientList[index].isSelected = false;
                  else
                    fridge.ingredientList[index].isSelected = true;
              },
              enabled:!fridge.ingredientList[index].isPastUseBy(fridge.selectedDate)
            )
        );
      },
    );
  }
}