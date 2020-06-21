import 'package:flutter/material.dart';
import 'package:tech_task/core/networking/api_response.dart';
import 'package:tech_task/core/widget/app_error_widget.dart';
import 'package:tech_task/core/widget/app_loading_widget.dart';
import 'package:tech_task/features/fridge/blocs/fridge_bloc.dart';
import 'package:tech_task/features/fridge/models/fridge.dart';

class FridgeScreen extends StatefulWidget {

  @override
  _FridgeScreenState createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  FridgeBloc _fridgeBloc;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    _fridgeBloc = FridgeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fridge')
      ),
      body: Column(
        children: <Widget>[
          Text("Date Now"),
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
                        return FridgeView(fridge: snapshot.data.data);
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
      )
    );
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
        )
        );
      },
    );
  }
}