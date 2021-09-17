import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/database/database_service.dart';
import 'package:project/ui/utils/date_extension.dart' as td;
import 'package:project/model/complaint_model.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';

class ComplaintItem extends StatelessWidget {
  final Complaint complaint;
  final DatabaseService databaseService;
  ComplaintItem({Key key, this.complaint, this.databaseService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            final result =
                await databaseService.deleteComplaint(complaint.complaintID);
            if (result) {
              showFlushBarWidget("complaint deleted");
              return;
            }
            showFlushBarWidget("error occured couldn't delete complaint");
          },
        ),
      ],
      child: Card(
        child: ExpansionTile(
            title: ListTile(
                title: Text(
              complaint.title.toUpperCase(),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )),
            children: [
              Align(
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: titleDeterm(
                        isAttended: complaint.isAttended,
                        isInvalid: complaint.isInvalid,
                        isPending: !complaint.isAttended)),
                alignment: Alignment.centerRight,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, top: 10, right: 10),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(complaint.desc,
                        style:
                            TextStyle(color: Color(0xff78839C), fontSize: 13)),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // extension method todate
                          complaint.timeStamp.toDate().toString().toTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 11),
                        ),
                        SizedBox(width: 5),
                        Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Color(0xff78839C),
                                shape: BoxShape.circle)),
                        SizedBox(width: 5),
                        Text(
                          complaint.timeStamp.toDate().toString().toDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 11),
                        ),
                        Spacer(),
                        SelectableText(
                          complaint.complaintID.substring(0, 12),
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  )
                ]),
              )
            ]),
      ),
    );
  }
}

Widget titleDeterm({bool isAttended, bool isInvalid, bool isPending}) {
  if (isPending) {
    return Text(
      "Pending",
      style: TextStyle(color: Colors.red, fontSize: 13),
    );
  } else if (isInvalid) {
    return Row(
      children: [
        Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        Text(
          "Invalid",
          style: TextStyle(color: Colors.green, fontSize: 13),
        ),
      ],
    );
  }
  return Text(
    "Approved",
    style: TextStyle(color: Colors.green, fontSize: 13),
  );
}
