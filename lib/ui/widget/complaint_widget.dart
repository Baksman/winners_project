// ]import 'package:Dantownapp/repository/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/utils/date_extension.dart' as td;
// import "package:Dantownapp/model/notifications.dart" as notif;
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:project/model/complaint_model.dart';
// import 'package:Dantownapp/utilities/extensions.dart';

class ComplaintItem extends StatefulWidget {
  final Complaint complaint;

  const ComplaintItem({Key key, this.complaint}) : super(key: key);

  @override
  _ComplaintItemState createState() => _ComplaintItemState();
}

class _ComplaintItemState extends State<ComplaintItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(

          // leading: ,
          title: ListTile(
              // leading: SvgPicture.asset(widget.notification.isSeen == 0
              //     ? "assets/svg/message_close.svg"
              //     : "assets/svg/message_open.svg"),
              title: Text(
            widget.complaint.title.toUpperCase(),
            style:
                TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
          )),
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, right: 10),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                                  child: Text(widget.complaint.desc,
                      
                      style: TextStyle(color: Color(0xff78839C), fontSize: 13)),
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
                        widget.complaint.timeStamp.toDate().toString().toTime,
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
                        widget.complaint.timeStamp.toDate().toString().toDate,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                      ),
                    ],
                  ),
                )
              ]),
            )
          ]),
    );
  }
}
