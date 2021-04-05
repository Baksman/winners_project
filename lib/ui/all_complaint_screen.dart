import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:project/ui/widget/complaint_widget.dart';
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
            if (snapshot.hasError) {
              logger.d(snapshot.error);
              return Text("Error");
            }
            if (!snapshot.hasData)
              return Center(
                child: AwesomeLoader(
                  color: primaryColor,
                  loaderType: AwesomeLoader.AwesomeLoader3,
                ),
              );
            List<Complaint> complaints = snapshot.data;
            logger.d(complaints.length);
            if (complaints.isEmpty) {
              return Center(
                  child: Text(
                "No complaint yet",
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
            }

            return SingleChildScrollView(
              child: Column(
                children: complaints
                    .map((e) => Theme(
                          data: ThemeData(primaryColor: primaryColor),
                          child: ComplaintItem(
                            complaint: e,
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
    );
  }
// ComplaintItem

}
