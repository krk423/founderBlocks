import 'package:flutter/material.dart';
import 'package:founderblocks/loginPage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeScreenAfterLogin extends StatefulWidget {
  const HomeScreenAfterLogin({Key? key}) : super(key: key);

  @override
  _HomeScreenAfterLoginState createState() => _HomeScreenAfterLoginState();
}

class _HomeScreenAfterLoginState extends State<HomeScreenAfterLogin> {
  ParseUser? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: getStartUp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var x = snapshot.data.toString();
              return Text(x);
            } else {
              return const Text("Loading");
            }
          },
        ),
        backgroundColor: const Color(0XFF161635),
      ),
      body: FutureBuilder<List?>(
        future: getStepsWithBlocks(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 25,
                      child: TextButton(
                        child: const Text('Logout'),
                        onPressed: () => loginPage(),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color(0XFF161635)),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (_, int position) {
                          final item = snapshot.data![position];
                          //get your item data here ...

                          return Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 18,
                                child: Text(
                                  snapshot.data![position]['blockName']
                                      .toString(),
                                ),
                                color: snapshot.data![position]['showStatus'] ==
                                        'N'
                                    ? Color(0XFF666666)
                                    : snapshot.data![position]['showStatus'] ==
                                            'Y'
                                        ? Color(0XFF33FF66)
                                        : Color(0XFF3366FF),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                height: 80,
                                color: snapshot.data![position]['showStatus'] ==
                                        'N'
                                    ? Color(0XFF666666)
                                    : snapshot.data![position]['showStatus'] ==
                                            'Y'
                                        ? Color(0XFF33FF66)
                                        : Color(0XFF3366FF),
                                child:
                                    //    Text(snapshot.data![position]['steps']
                                    //         .toString()),
                                    ListView.builder(
                                        itemCount: snapshot
                                            .data![position]['steps'].length,
                                        itemBuilder: (_, int position1) {
                                          final itemSteps =
                                              snapshot.data![position]['steps'];
                                          return Column(
                                            children: [
                                              SizedBox(height: 10),
                                              Container(
                                                  child: Text(snapshot
                                                      .data![position]['steps']
                                                          [position1]
                                                      .toString()))
                                            ],
                                          );
                                        }),
                              ),
                              Container(
                                height: 80,
                                color: snapshot.data![position]['showStatus'] ==
                                        'N'
                                    ? Color(0XFF666666)
                                    : snapshot.data![position]['showStatus'] ==
                                            'Y'
                                        ? Color(0XFF33FF66)
                                        : Color(0XFF3366FF),
                                child: ListView.builder(
                                    itemCount: snapshot
                                        .data![position]['goals'].length,
                                    itemBuilder: (_, int position1) {
                                      final itemSteps =
                                          snapshot.data![position]['goals'];
                                      return Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                              child: Text(snapshot
                                                  .data![position]['goals']
                                                      [position1]
                                                  .toString()))
                                        ],
                                      );
                                    }),
                              ),
                              // Container(
                              //   child: ListView.builder(
                              //       itemCount:
                              //           snapshot.data![position].get('steps'),
                              //       itemBuilder: (_, int position1) {
                              //         final itemSteps =
                              //             snapshot.data![position].get('steps');
                              //         return Column(
                              //           children: [
                              //             SizedBox(height: 10),
                              //             Container(
                              //                 child: Text(snapshot
                              //                     .data![position]
                              //                     .get('steps')
                              //                     .toString()))
                              //           ],
                              //         );
                              //       }),
                              // )
                            ],
                          );
                          // return Card(
                          //   child: ListTile(
                          //     title: Text("Block : " +
                          //         snapshot.data![position]
                          //             .get('nameOfTheBlock')
                          //             .toString()),
                          //     subtitle: Text(getStepsProgress(
                          //             snapshot.data![position].get('objectId'))
                          //         .toString()),
                          //   ),
                          // );
                        },
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      // FutureBuilder<ParseUser?>(
      //     future: getUser(),
      //     builder: (context, snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //         case ConnectionState.waiting:
      //           return Center(
      //             child: Container(
      //                 width: 100,
      //                 height: 100,
      //                 child: CircularProgressIndicator()),
      //           );
      //         default:
      //           return Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 //    Center(child: Text('Show Progress')),
      //                 Center(child: Text(getString(snapshot.data!.objectId))),
      //                 SizedBox(
      //                   height: 16,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   child: TextButton(
      //                     child: const Text('Logout'),
      //                     onPressed: () => loginPage(),
      //                     style: TextButton.styleFrom(
      //                         primary: Colors.white,
      //                         backgroundColor: Color(0XFF3366FF)),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 16,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   child: TextButton(
      //                     child: const Text('Show Progress'),
      //                     onPressed: () => getGoalsProgress('mhk2cNaGMo'),
      //                     style: TextButton.styleFrom(
      //                         primary: Colors.white,
      //                         backgroundColor: Color(0XFF3366FF)),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           );
      //       }
      //     })
    );
  }

  void loginPage() async {
    var response = await currentUser!.logout();
    if (response.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    print('inside get user');
    print(currentUser.toString());
    print('inside get user function which needs testing');
    return currentUser;
  }

  Future<String?> getUserStartUp() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser?.username.toString();
  }

  String? getUserString() {
    Future current = getUserStartUp();

    current.then((data) {
      print('get user string');
      print(data['username'].toString());
      return data['username'].toString();
    }, onError: (e) {
      return 'I love you';
    });
  }

  String getString(String? x) {
    if (x == null) {
      return 'i love you';
    } else {
      return x;
    }
  }

  Future<String?> getStartUp() async {
    print('getCurrentUser');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      x = currentUser!.username.toString();
    }

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        final QueryBuilder<ParseObject> parseQuery =
            QueryBuilder<ParseObject>(ParseObject('StartUp'));
        parseQuery.whereContains('objectId', startUpPointer);
        final ParseResponse startUpResponse = await parseQuery.query();
        if (startUpResponse.success && startUpResponse.results != null) {
          for (var o in startUpResponse.results!) {
            return o.get('startUpName');
          }
        }
      }
    } else {
      return 'No Startup';
    }
  }

  Future<List?> getBlocks() async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Blocks'));
    parseQuery.keysToReturn(['objectId', 'nameOfTheBlock', 'blockSequence']);
    parseQuery.orderByAscending('blockSequence');
    final ParseResponse blocksResponse = await parseQuery.query();
    if (blocksResponse.success && blocksResponse.results != null) {
      for (var o in blocksResponse.results!) {
        print((o as ParseObject).toString());
      }
      return blocksResponse.results;
    } else {
      return [];
    }
  }

  Future<List?> getStepsProgress(String blockId) async {
    print('getCurrentUser');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      print('inside get steps');
      x = currentUser!.username.toString();
    }

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        print(startUpPointer);
        final QueryBuilder<ParseObject> parseQuery =
            QueryBuilder<ParseObject>(ParseObject('StepsProgress'));
        parseQuery.whereContains('startUpId', startUpPointer);
        parseQuery.whereContains('blockId', blockId);
        final ParseResponse stepsResponse = await parseQuery.query();
        if (stepsResponse.success && stepsResponse.results != null) {
          for (var o in stepsResponse.results!) {
            print((o as ParseObject).toString());
          }
          return stepsResponse.results as List<ParseObject>;
        }
      }
    }
    return [];
  }

  Future<List?> getStepsWithBlocks() async {
    print('getCurrentUser inside getStepsWithBlocks');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      print('inside get steps');
      x = currentUser!.username.toString();
    }
    var resultList = [];

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        print(startUpPointer);

        final QueryBuilder<ParseObject> blocksQuery =
            QueryBuilder<ParseObject>(ParseObject('Blocks'));
        blocksQuery.orderByAscending('blockSequence');
        final ParseResponse blocksResponse = await blocksQuery.query();
        print(blocksResponse.count);
        print("block pointer");
        for (var blocks in blocksResponse.results!) {
          var widgetBlock = Map();
          print(blocks.get('blockSequence'));
          var stepsList = [];
          var stepsStatusList = [];
          var goalsList = [];
          var goalStatusList = [];
          var stepStatusNCount = 0;
          var stepStatusPCount = 0;
          var stepStatusYCount = 0;
          var goalStatusNCount = 0;
          var goalStatusYCount = 0;
          var showGoalsStatus;
          final QueryBuilder<ParseObject> stepsQuery =
              QueryBuilder<ParseObject>(ParseObject('Steps'));
          //  stepsQuery.whereContains('startUpId', startUpPointer);
          stepsQuery.whereContains('blockId', blocks.get('objectId'));
          stepsQuery.orderByAscending('stepNumber');
          final ParseResponse stepsResponse = await stepsQuery.query();
          for (var steps in stepsResponse.results!) {
            final QueryBuilder<ParseObject> stepsProgressQuery =
                QueryBuilder<ParseObject>(ParseObject('StepsProgress'));
            stepsProgressQuery.whereContains('startUpId', startUpPointer);
            stepsProgressQuery.whereContains('blockId', blocks.get('objectId'));
            stepsProgressQuery.whereContains('stepId', steps.get('objectId'));
            final ParseResponse stepsProgressResponse =
                await stepsProgressQuery.query();
            for (var stepsProgress in stepsProgressResponse.results!) {
              stepsList.add(steps.get('stepDescription'));
              stepsStatusList.add(stepsProgress.get('stepStatus'));
            }
            widgetBlock['blockName'] = blocks.get('nameOfTheBlock');
            widgetBlock['steps'] = stepsList;
            widgetBlock['stepStatus'] = stepsStatusList;
          }
          print('testing goals');
          final QueryBuilder<ParseObject> goalsQuery =
              QueryBuilder<ParseObject>(ParseObject('Goals'));
          goalsQuery.whereContains('blockId', blocks.get('objectId'));
          goalsQuery.orderByAscending('goalNumber');
          print('testing goals');
          final ParseResponse goalsResponse = await goalsQuery.query();
          for (var goals in goalsResponse.results!) {
            final QueryBuilder<ParseObject> goalsProgressQuery =
                QueryBuilder<ParseObject>(ParseObject('GoalProgress'));
            goalsProgressQuery.whereContains('startUpId', startUpPointer);
            goalsProgressQuery.whereContains('blockId', blocks.get('objectId'));
            goalsProgressQuery.whereContains('goalId', goals.get('objectId'));
            final ParseResponse goalProgressResponse =
                await goalsProgressQuery.query();
            var numberOfGoals = goalProgressResponse.count;
            for (var goalsProgress in goalProgressResponse.results!) {
              goalsList.add(goals.get('goalDescription'));
              goalStatusList.add(goalsProgress.get('goalStatus'));
              if (goalsProgress.get('goalStatus') == 'N') {
                print('goalStatus');
                goalStatusNCount++;
              } else {
                goalStatusYCount++;
              }
            }
            if (numberOfGoals == goalStatusNCount) {
              showGoalsStatus = 'N';
            } else if (numberOfGoals == goalStatusYCount) {
              showGoalsStatus = 'Y';
            } else {
              showGoalsStatus = 'P';
            }
            widgetBlock['goals'] = goalsList;
            widgetBlock['goalStatus'] = goalStatusList;
            widgetBlock['showStatus'] = showGoalsStatus;
          }

          print(blocks.get('nameOfTheBlock'));
          resultList.add(widgetBlock);
        }
      }
    }
    print("komala is bad girl");
    print(resultList);
    return resultList;
  }

  Future<List?> getStepProgressBlockWise() async {
    print('getRakeshUltimate');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      print('inside get steps');
      x = currentUser!.username.toString();
    }
    var resultList = [];

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        print(startUpPointer);

        final QueryBuilder<ParseObject> blocksQuery =
            QueryBuilder<ParseObject>(ParseObject('Blocks'));
        blocksQuery.orderByAscending('blockSequence');
        final ParseResponse blocksResponse = await blocksQuery.query();
        print('blocksResponse');

        for (var blocks in blocksResponse.results!) {
          var widgetBlock = new Map();
          var stepsList = [];
          var goalsList = [];
          var stepStatusNCount = 0;
          var stepStatusPCount = 0;
          var stepStatusYCount = 0;
          var goalStatusNCount = 0;
          var goalStatusYCount = 0;
          var showGoalsStatus;
          final QueryBuilder<ParseObject> stepsQuery =
              QueryBuilder<ParseObject>(ParseObject('Steps'));
          //  stepsQuery.whereContains('startUpId', startUpPointer);
          stepsQuery.whereContains('blockId', blocks.get('objectId'));
          stepsQuery.orderByAscending('stepNumber');
          final ParseResponse stepsResponse = await stepsQuery.query();
          print(blocks.get('objectId'));
          for (var steps in stepsResponse.results!) {
            print('inside stpes block');
            final QueryBuilder<ParseObject> stepsProgressQuery =
                QueryBuilder<ParseObject>(ParseObject('StepsProgress'));
            stepsProgressQuery.whereContains('startUpId', startUpPointer);
            stepsProgressQuery.whereContains('blockId', blocks.get('objectId'));
            stepsProgressQuery.whereContains('stepId', steps.get('objectId'));
            print('inside step for loop');
            final ParseResponse stepsProgressResponse =
                await stepsProgressQuery.query();
            for (var stepsProgress in stepsProgressResponse.results!) {
              stepsList.add(steps.get('stepDescription'));
              stepsList.add(stepsProgress.get('stepStatus'));
            }
            widgetBlock['blockName'] = blocks.get('nameOfTheBlock');
            widgetBlock['steps'] = stepsList;
          }
          final QueryBuilder<ParseObject> goalsQuery =
              QueryBuilder<ParseObject>(ParseObject('Goals'));
          //  stepsQuery.whereContains('startUpId', startUpPointer);
          goalsQuery.whereContains('blockId', blocks.get('objectId'));
          goalsQuery.orderByAscending('goalNumber');
          final ParseResponse goalsResponse = await goalsQuery.query();
          print(blocks.get('objectId'));
          for (var goals in goalsResponse.results!) {
            print('inside stpes block');
            final QueryBuilder<ParseObject> goalsProgressQuery =
                QueryBuilder<ParseObject>(ParseObject('GoalProgress'));
            goalsProgressQuery.whereContains('startUpId', startUpPointer);
            goalsProgressQuery.whereContains('blockId', blocks.get('objectId'));
            goalsProgressQuery.whereContains('goalId', goals.get('objectId'));
            print('inside step for loop');
            final ParseResponse goalsProgressResponse =
                await goalsProgressQuery.query();
            var numberOfGoals = goalsProgressResponse.count;
            for (var goalsProgress in goalsProgressResponse.results!) {
              goalsList.add(goals.get('goalDescription'));
              goalsList.add(goalsProgress.get('goalStatus'));
              if (goalsProgress.get('goalStatus') == 'N') {
                print('goalStatus');
                goalStatusNCount++;
              } else {
                goalStatusYCount++;
              }
            }
            if (numberOfGoals == goalStatusNCount) {
              showGoalsStatus = 'N';
            } else if (numberOfGoals == goalStatusYCount) {
              showGoalsStatus = 'Y';
            } else {
              showGoalsStatus = 'P';
            }
            print('show goal status');
            print(showGoalsStatus);
            widgetBlock['goals'] = goalsList;
            widgetBlock['showStatus'] = showGoalsStatus;
          }

          resultList.add(widgetBlock);
        }
      }
    }
    print('rakesh is a good boy');
    print(resultList);
    return resultList;
  }

  Future<List?> getGoalsProgress(String blockId) async {
    print('getCurrentUser');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      print('inside get steps');
      x = currentUser!.username.toString();
    }

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        print(startUpPointer);
        final QueryBuilder<ParseObject> parseQuery =
            QueryBuilder<ParseObject>(ParseObject('GoalProgress'));
        parseQuery.whereContains('startUpId', startUpPointer);
        parseQuery.whereContains('blockId', blockId);
        final ParseResponse goalsResponse = await parseQuery.query();
        if (goalsResponse.success && goalsResponse.results != null) {
          for (var o in goalsResponse.results!) {
            print((o as ParseObject).toString());
          }
          return goalsResponse.results as List<ParseObject>;
        }
      }
    }
    return [];
  }

  Future<List<ParseObject?>> getSteps() async {
    print('getCurrentUser');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
      print(currentUser!.username.toString());
      print('inside get steps');
      x = currentUser!.username.toString();
    }

    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    queryUsers.whereContains(ParseUser.keyUsername, x);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var a in apiResponse.results! as List<ParseObject>) {
        String startUpPointer = a.get('startUpPointer').objectId;
        print(startUpPointer);
        final QueryBuilder<ParseObject> parseQuery =
            QueryBuilder<ParseObject>(ParseObject('StepsProgress'));
        parseQuery.whereContains('startUpId', startUpPointer);
        final ParseResponse stepsResponse = await parseQuery.query();
        if (stepsResponse.success && stepsResponse.results != null) {
          for (var o in stepsResponse.results!) {
            print((o as ParseObject).toString());
          }
          return stepsResponse.results as List<ParseObject>;
        }
      }
    }
    return [];
  }
}
