import 'package:flutter/material.dart';
import 'package:tech_task/core/networking/api_response.dart';
import 'package:tech_task/core/widget/app_error_widget.dart';
import 'package:tech_task/core/widget/app_loading_widget.dart';
import 'package:tech_task/features/recipes/blocs/recipe_bloc.dart';
import 'package:tech_task/features/recipes/models/recipe.dart';

class RecipeScreen extends StatefulWidget {
  final String selectedIngredients;

  const RecipeScreen({
    Key key,
    @required this.selectedIngredients,
  }) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState(selectedIngredients);
}

class _RecipeScreenState extends State<RecipeScreen> {
  final String selectedIngredients;
  RecipeBloc _recipeBloc;
  List<Recipe> _recipeList;

  _RecipeScreenState(this.selectedIngredients);

  @override
  void initState() {
    super.initState();
    _recipeBloc = RecipeBloc(selectedIngredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Recipes')
        ),
        body: RefreshIndicator(
          onRefresh: () => _recipeBloc.getRecipe(),
          child: StreamBuilder<ApiResponse<List<Recipe>>>(
            stream: _recipeBloc.recipeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return AppLoadingWidget(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    _recipeList = snapshot.data.data;
                    return ListView.builder(
                      itemCount: _recipeList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('${_recipeList[index].title}'),
                            subtitle: Text('Ingredients : ${_recipeList[index].getIngredientsString()}'),
                          ),
                        );
                      },
                    );
                    break;
                  case Status.ERROR:
                    return AppErrorWidget(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () => _recipeBloc.getRecipe(),
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ),
    );
  }
}