// ignore_for_file: implementation_imports

import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';
import 'package:gql/src/ast/transformer.dart';

const _clientDirective = DirectiveNode(
  name: NameNode(value: 'client'),
);

/// filter function to remove all FieldNode with @client directive
bool _stripClientField(SelectionNode element) {
  if (element is FieldNode) {
    final isLocal =
        element.directives.any((element) => element == _clientDirective);
    return !isLocal;
  }
  return true;
}

/// helper function to remove all FieldNode with @client directive
SelectionSetNode _stripClientFields(SelectionSetNode node) {
  return SelectionSetNode(
    selections: node.selections.where(_stripClientField).toList(),
  );
}

/// transformer to handle @client directive
/// It will remove all fields with @client directive from OperationDefinitionNode
/// and FragmentDefinitionNode
/// Those fields will be handled in [GraphQLCache.typePolicies] locally
class _HandleClientDirectiveTransformer extends TransformingVisitor {
  @override
  OperationDefinitionNode visitOperationDefinitionNode(
    OperationDefinitionNode node,
  ) {
    return super.visitOperationDefinitionNode(
      OperationDefinitionNode(
        name: node.name,
        type: node.type,
        variableDefinitions: node.variableDefinitions,
        directives: node.directives,
        selectionSet: _stripClientFields(node.selectionSet),
      ),
    );
  }

  @override
  FragmentDefinitionNode visitFragmentDefinitionNode(
    FragmentDefinitionNode node,
  ) {
    return super.visitFragmentDefinitionNode(
      FragmentDefinitionNode(
        name: node.name,
        typeCondition: node.typeCondition,
        directives: node.directives,
        selectionSet: _stripClientFields(node.selectionSet),
      ),
    );
  }
}

/// link to handle @client directive
/// It will remove all fields with @client directive from the query
class ClientDirectiveLink extends Link {
  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    yield* forward!(
      Request(
        operation: Operation(
          document: transform(
            request.operation.document,
            [_HandleClientDirectiveTransformer()],
          ),
        ),
        variables: request.variables,
        context: request.context,
      ),
    );
  }
}
