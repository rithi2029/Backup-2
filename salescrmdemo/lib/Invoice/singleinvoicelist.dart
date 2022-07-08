/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class SingleInvoicescreen StatefulWidget;
 class SingleInvoicescreen extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _SingleInvoicescreenState createState() => _SingleInvoicescreenState();
}
   

 
class _SingleInvoicescreenState extends State<SingleInvoicescreen> {
  final formKey = GlobalKey<FormState>();
  var accesstoken;
 

   TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 15.0);

  TextStyle textStyle1 = TextStyle(color: Colors.white, fontSize: 15.0);
 var _invoicelist = [];
  var contcolor = Colors.white;
  invoicesList() async {
    print("inside invoicesList");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/invoices");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          _invoicelist = json.decode(response.body);

          print(_invoicelist.toString());
          print(_invoicelist.length);
        });

        print("lead_accountindustries id is" + _invoicelist.toString());
        print(_invoicelist.toString());
        setState(() {});
        return _invoicelist;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken = sharedPreferences.setString("access_token", "_");

        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Loginscreen()));
      } else {
        print(response.body.toString());

        print(response.statusCode.toString());
        print(json.decode(response.body).toString());
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
  }
  @override
   
   Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        screenSize.width / (2 / (screenSize.height / screenSize.width));
    return Scaffold(
     
       
      appBar: AppBar(
        backgroundColor: Color(maincolor),
       
        centerTitle: true,
        title: Text("Invoice Details"),

      ),
        body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Card(
                elevation: 5.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DataTable(
                              sortColumnIndex: 1,
                              columns: <DataColumn>[
                                DataColumn(
                                  tooltip: "This is Name",
                                  label: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(maincolor)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "widget.name",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(maincolor)),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                //     for (int ij = 0; ij < _leadlist.length; ij++)
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Email'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.email".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Phone'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Phone".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Title'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Title".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Website'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Website".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Lead Address'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.leadAddress".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('City'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.City.".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('State'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.State".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Country'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Country".toString()),
                                    ),
                                  ],
                                ),
                
                                /*DataRow(
                        
                                  cells: <DataCell>[
                                    DataCell(
                                        Text(
                                         'Status'
                                        ),
                                        //   showEditIcon: true,
                                           ),
                                    DataCell(
                                        Text(Status.toString()
                        
                         
                                            ),  ),
                                            
                                    
                                  ],
                                ),*/
                
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Source'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Source".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Opportunity Amount'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text(defultcurrency +
                                          " " +
                                         " widget.OpportunityAmount".toString()),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('Industry'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Industry.".toString()),
                                    ),
                
                                    //_leadlist['status']
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('status'),
                                      //   showEditIcon: true,
                                    ),
                                    DataCell(
                                      Text("widget.Status".toString()),
                                    ),
                
                                    //_leadlist['status']
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
          height: 40.0,
                                                                  width: 100.0,
    child:   ElevatedButton(
      
      style: ButtonStyle(
        //  foregroundColor: color:Color(maincolor),
    
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Color(maincolor))
        )
      )
    ),
                 //   color: Color(maincolor),
                    child: new Text(
                      "Ok",
                      style: textStyle1,
                    ),
                    onPressed: () {
                      //  continueCallBack();
                      Navigator.of(context).pop();
                    },
                  ),
  ),
),
            ],)
        
              ],
          ),
        ),
      ),
    );
  }
}*/