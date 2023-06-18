import 'package:graphql/client.dart';
import 'package:poc_graphql_cache_local_state_management/constant.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/__generated/schema.graphql.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/fragments/extensions.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/client_directive_handler_link.dart';

GraphQLClient initGraphqlClient(Store store) => GraphQLClient(
      link: ClientDirectiveLink().concat(
        Link.split(
          (request) => request.isSubscription,
          WebSocketLink(wsendpoint),
          HttpLink(httpendpoint),
        ),
      ),
      cache: GraphQLCache(
        possibleTypes: possibleTypesMap,
        store: store,
        typePolicies: {
          'Message': Fragment$ChatMessage$Utils.localStatePolicy,
        },
      ),
    );
