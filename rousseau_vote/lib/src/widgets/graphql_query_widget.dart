import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_configuration.dart';

// callback function called to render a widget in case of query error
typedef GraphqlErrorWidgetBuilder = Widget Function(List<GraphQLError> errors);

// callback function called to render a widget in case of query success
typedef GraphqlSuccessWidgetBuilder = Widget Function(dynamic data);

// callback function called to render a widget while a graphql query is loading
typedef GraphqlLoadingWidgetBuilder = Widget Function();

class GraphqlQueryWidget extends StatelessWidget {
  GraphqlQueryWidget(
      {@required this.query,
      @required this.builderSuccess,
      @required this.builderError,
      @required this.builderLoading,
      this.variables,
      GraphQLConfiguration graphQLConfiguration})
      : client = graphQLConfiguration != null
            ? graphQLConfiguration.client
            : GraphQLConfiguration().client;

  final ValueNotifier<GraphQLClient> client;
  final String query;
  final Map<String, dynamic> variables;
  final GraphqlSuccessWidgetBuilder builderSuccess;
  final GraphqlErrorWidgetBuilder builderError;
  final GraphqlLoadingWidgetBuilder builderLoading;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: Query(
          options: QueryOptions(document: query, variables: variables),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.errors != null) {
              return builderError(result.errors);
            }

            if (result.loading) {
              return builderLoading();
            }

            return builderSuccess(result.data);
          },
        ),
      ),
    );
  }
}
