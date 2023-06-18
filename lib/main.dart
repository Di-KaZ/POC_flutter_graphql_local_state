import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:isar/isar.dart';
import 'package:poc_graphql_cache_local_state_management/conversation.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/client.dart';
import 'package:poc_graphql_cache_local_state_management/controller.dart';
import 'package:poc_graphql_cache_local_state_management/graphql/isar_store.dart';
import 'package:poc_graphql_cache_local_state_management/service.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = Isar.openSync(
    [GraphqlLookupSchema],
    directory: (await getApplicationDocumentsDirectory()).path,
  );

  runApp(Providers(isar: isar));
}

class Providers extends StatelessWidget {
  final Isar isar;
  const Providers({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => initGraphqlClient(IsarStore(isar)),
      child: Provider(
        create: (ctx) => Service(ctx.read<GraphQLClient>()),
        child: ChangeNotifierProvider(
          create: (ctx) => Controller(ctx.read<Service>()),
          child: const MainApp(),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              UserIdInput(controller: controller),
              const Expanded(child: EventPreviewList()),
            ],
          ),
        ),
      ),
    );
  }
}

class EventPreviewList extends StatelessWidget {
  const EventPreviewList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Controller>();
    return FutureBuilder(
      future: controller.getUserEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No events'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Conversation(id: snapshot.data![index].id),
                    ),
                  );
                },
                title: Text(snapshot.data![index].title),
                subtitle: Text(snapshot.data![index].description),
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class UserIdInput extends StatelessWidget {
  const UserIdInput({
    super.key,
    required this.controller,
  });

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      const Text('User ID: '),
      Expanded(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller.userIdController,
        ),
      ),
    ]);
  }
}
