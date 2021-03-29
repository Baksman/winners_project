import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:provider/provider.dart';

class AllComplaintScreen extends StatefulWidget {
  @override
  _AllComplaintScreenState createState() => _AllComplaintScreenState();
}

class _AllComplaintScreenState extends State<AllComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<AppUser>(context).uuid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<List<Complaint>>(
          future: DatabaseService.getUsersComplaints(userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: AwesomeLoader(
                  color: primaryColor,
                  loaderType: AwesomeLoader.AwesomeLoader3,
                ),
              );
            return SingleChildScrollView(
              child: Column(
                children: [],
              ),
            );
          }),
    );
  }
// ComplaintItem

}
