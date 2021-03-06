import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/widgets/poll_details_body.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class PollDetailsScreen extends StatelessWidget {
  
  const PollDetailsScreen(this.arguments);

  static const String ROUTE_NAME = '/poll_details';

  final PollDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    if (arguments.routing) {
      return Scaffold(
        appBar: RousseauAppBar(),
        body: PollDetailsBody(arguments.pollId),
        backgroundColor: BACKGROUND_GREY,
      );
    } else {
      return RousseauLoggedScaffold(
        appBar: RousseauAppBar(),
        body: PollDetailsBody(arguments.pollId)
      );
    }
  }
}