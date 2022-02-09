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
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 25,
                      child: TextButton(
                        child: const Text('Logout'),
                        onPressed: () => loginPage(),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: const Color(0XFF161635)),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (_, int position) {
                          return Column(
                            children: [
                              const SizedBox(
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
                                    ? const Color(0XFF666666)
                                    : snapshot.data![position]['showStatus'] ==
                                            'Y'
                                        ? const Color(0XFF33FF66)
                                        : const Color(0XFF3366FF),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Container(
                                  height: 80,
                                  color: snapshot.data![position]
                                              ['showStatus'] ==
                                          'N'
                                      ? const Color(0XFF666666)
                                      : snapshot.data![position]
                                                  ['showStatus'] ==
                                              'Y'
                                          ? const Color(0XFF33FF66)
                                          : const Color(0XFF3366FF),
                                  child: ListView.builder(
                                      itemCount: snapshot
                                          .data![position]['steps'].length,
                                      itemBuilder: (_, int position1) {
                                        final itemSteps =
                                            snapshot.data![position]['steps'];
                                        return Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Container(
                                                child: Text(snapshot
                                                    .data![position]['steps']
                                                        [position1]
                                                    .toString()))
                                          ],
                                        );
                                      })),
                              Container(
                                height: 80,
                                color: snapshot.data![position]['showStatus'] ==
                                        'N'
                                    ? const Color(0XFF666666)
                                    : snapshot.data![position]['showStatus'] ==
                                            'Y'
                                        ? const Color(0XFF33FF66)
                                        : const Color(0XFF3366FF),
                                child: ListView.builder(
                                    itemCount: snapshot
                                        .data![position]['goals'].length,
                                    itemBuilder: (_, int position1) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Container(
                                              child: Text(snapshot
                                                  .data![position]['goals']
                                                      [position1]
                                                  .toString()))
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          );
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
    return currentUser;
  }

  Future<String?> getUserStartUp() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser?.username.toString();
  }

  String? getUserString() {
    Future current = getUserStartUp();

    current.then((data) {
      return data['username'].toString();
    }, onError: (e) {
      return ' ';
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
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = 'I love coding';
    } else {
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

  Future<List?> getStepsWithBlocks() async {
    print('getCurrentUser inside getStepsWithBlocks');
    currentUser = await ParseUser.currentUser() as ParseUser?;
    String x;
    if (currentUser == null) {
      x = ' ';
    } else {
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
        for (var blocks in blocksResponse.results!) {
          var widgetBlock = {};
          var stepsList = [];
          var stepsStatusList = [];
          var goalsList = [];
          var goalStatusList = [];
          var goalStatusNCount = 0;
          var goalStatusYCount = 0;
          var numberOfGoals;
          String showGoalsStatus;
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

          final QueryBuilder<ParseObject> goalsQuery =
              QueryBuilder<ParseObject>(ParseObject('Goals'));
          goalsQuery.whereContains('blockId', blocks.get('objectId'));
          goalsQuery.orderByAscending('goalNumber');

          final ParseResponse goalsResponse = await goalsQuery.query();
          for (var goals in goalsResponse.results!) {
            final QueryBuilder<ParseObject> goalsProgressQuery =
                QueryBuilder<ParseObject>(ParseObject('GoalProgress'));
            goalsProgressQuery.whereContains('startUpId', startUpPointer);
            goalsProgressQuery.whereContains('blockId', blocks.get('objectId'));
            goalsProgressQuery.whereContains('goalId', goals.get('objectId'));
            final ParseResponse goalProgressResponse =
                await goalsProgressQuery.query();
            numberOfGoals = goalProgressResponse.count;
            for (var goalsProgress in goalProgressResponse.results!) {
              goalsList.add(goals.get('goalDescription'));
              goalStatusList.add(goalsProgress.get('goalStatus'));
              if (goalsProgress.get('goalStatus') == 'N') {
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
          if (numberOfGoals == goalStatusNCount) {
            widgetBlock['goals'].clear();
            widgetBlock['goalStatus'].clear();
            widgetBlock['steps'].clear();
            widgetBlock['stepStatus'].clear();
            widgetBlock['goals'].add('TODO');
          } else if (numberOfGoals == goalStatusYCount) {
            widgetBlock['goals'].clear();
            widgetBlock['goalStatus'].clear();
            widgetBlock['steps'].clear();
            widgetBlock['stepStatus'].clear();
            widgetBlock['goals'].add('Done');
          }

          resultList.add(widgetBlock);
        }
      }
    }
    return resultList;
  }
}
