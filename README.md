# poc_graphql_cache_local_state_management

This is a poc about using graphql flutter client to use local state and cache management all in the graphql cache

![demo gif](./demo.gif)


The code is documented to explain what I do and why

Here you will find :
- Custom Graphql client sotre implementation using Isar 3.0 to persist data
- custom graphql link to handle the *@client* directive on graphql files
- how to manage a local state along with the network one in the graphql cache
- optimisticly update a query cache on local before network response

## Run the mock graphql api
`npm i`
`npm run start`
By default server lsiten on port 3000 and pre-populated with limited dataset

> SERVER DATA IS NOT PERSISTENT IF YOU CLOSE THE SERVER ALL NEW DATA WILL BE DELETED


> modify the ip of server if you dont use an emulator to point to your local machien in *constant.dart* 

you can erase the flutter app cache by uncomenting a line in the *main.dart* file

