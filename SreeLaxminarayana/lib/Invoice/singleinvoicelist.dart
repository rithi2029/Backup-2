import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ims/Invoice/invoicelist.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SingleInvoicescreen extends StatefulWidget {
  var id;
  @override
  SingleInvoicescreen({this.id});
  @override
  _SingleInvoicescreenState createState() => _SingleInvoicescreenState();
}
//class SingleInvoicescreen StatefulWidget;

class _SingleInvoicescreenState extends State<SingleInvoicescreen> {
  final formKey = GlobalKey<FormState>();
  var accesstoken;
  Future a;
  initState() {
    paymentinvoicesList();
    a = singleinvoicesList();

    super.initState();
  }

  TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 15.0);

  TextStyle textStyle1 = TextStyle(color: Colors.white, fontSize: 15.0);
  var _Singleinvoicelist = {};
  var contcolor = Colors.white;

  SharedPreferences sharedPreferences;
  var _paymentinvoicedetails = [];
  Future paymentinvoicesList() async {
    print("inside paymentinvoicesList");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/invoicepayments");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
        //    paymentinvoicesList();
          _paymentinvoicedetails = json.decode(response.body);

          print(_paymentinvoicedetails.toString());
          print("lengthhhhhh_paymentinvoicedetails.length" +
              _paymentinvoicedetails.length.toString());
          print(_paymentinvoicedetails.length.toString());
        });

        print(
            "lead_accountindustries id is" + _paymentinvoicedetails.toString());
        print(_paymentinvoicedetails.toString());
        setState(() {});
        return _paymentinvoicedetails;
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

  Future singleinvoicesList() async {
    print("inside invoicesList");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/invoices/${widget.id}");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
            paymentinvoicesList();
          _Singleinvoicelist = json.decode(response.body);

          print(_Singleinvoicelist.toString());
          print("_idsfddfsafdhsdgy" + _Singleinvoicelist['id'].toString());
          print(_Singleinvoicelist.length.toString());
        });

        print("lead_accountindustries id is" + _Singleinvoicelist.toString());
        print(_Singleinvoicelist.toString());
        setState(() {});
        return _Singleinvoicelist;
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
           leading: InkResponse(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            //Navigator.pop(context);
                Navigator.of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new InvoiceScreen(),
                        ));
          },
        ),
        title: Text("Invoice Details"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: paymentinvoicesList(),
            builder: (context, snapshot) {
              return FutureBuilder(
                  future: a,
                  builder: (context, snapshot) {
                    return snapshot.hasData == true
                        ? Column(
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
                                                      'Invoice Name',
                                                      style: TextStyle(
                                                          //  fontStyle: FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      _Singleinvoicelist['name'],
                                                      style: TextStyle(
                                                          //   fontStyle: FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                ],
                                                rows: <DataRow>[
                                                  //     for (int ij = 0; ij < _leadlist.length; ij++)
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Invoice ID'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text("#INV0000" +
                                                            "" +
                                                            _Singleinvoicelist[
                                                                    'invoice_id']
                                                                .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Invoice Date'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'invoice_id']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Created'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'date_quoted']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Invoice Status'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'status_name']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  /*DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Text('Amount'),
                                              //   showEditIcon: true,
                                            ),
                                            DataCell(
                                              Text(defaultcurrency+" "+_Singleinvoicelist['amount'].toString()),
                                            ),
                                          ],
                                        ),*/
                                                  /* DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Text('Assigned User '),
                                              //   showEditIcon: true,
                                            ),
                                            DataCell(
                                              Text("widget.Website".toString()),
                                            ),
                                          ],
                                        ),*/
          
                                                  /* DataRow(
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
                                              Text(defaultcurrency +
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
                                         */
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            'Item Details',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                //  fontStyle: FontStyle.italic,
                                                color: Color(maincolor)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: DataTable(
                                                columns: <DataColumn>[
                                               
                                                    DataColumn(
                                                      label: Center(
                                                        child: Text(
                                                          'Item Name',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle.italic,
                                                              color:
                                                                  Color(maincolor)),
                                                        ),
                                                      ),
                                                    ),
                                                    for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                  DataColumn(
                                                    
                                                    label: Text(
                                                      _Singleinvoicelist['items'][i]
                                                              ['name']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                ],
                                               
                                                rows: <DataRow>[
                                                  //     for (int ij = 0; ij < _leadlist.length; ij++)
            
          
                                                      
                                                  /*DataRow(
                                                    cells: <DataCell>[
                                                 
                                                      DataCell(
                                                        Text("Name"),
                                                        //   showEditIcon: true,
                                                      ),
                                                            for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(        _Singleinvoicelist['items'][i]
                                                              ['name']
                                                            .toString()),
                                                      ),
                                                    ],
                                                    
                                                  ),*/
          
                                                /*  DataRow(
                                                    cells: <DataCell>[
                                                
                                                      DataCell(
                                                        Text("Quantity"),
                                                        //   showEditIcon: true,
                                                      ),
                                                            for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text( _Singleinvoicelist['items'][i]
                                                              ['quantity']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),*/
          
                                                  DataRow(
                                                    
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Width * Height * Length"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                  
                                                    
                                                      DataCell(
                                                        Text(
                         _Singleinvoicelist['items'][i] ['width'].toString() == 'null'
                                                          && _Singleinvoicelist['items'][i] ['height'].toString() == 'null'
                                                           &&
                                                          _Singleinvoicelist['items'][i] ['length'].toString() == 'null' 
                                                          ? '0.00 * 0.00 * 0.00' :
                                       '${_Singleinvoicelist['items'][i]['width'].toString()}'+" * "+'${_Singleinvoicelist['items'][i]['height'].toString()}'+" * "+'${_Singleinvoicelist['items'][i]['length'].toString()}'
                                       // :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),
           /*                                        DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Height"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['items'][i] ['height'].toString() == 'null' ? '0.00' :
                                       _Singleinvoicelist['items'][i]['height'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),
                                                   DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Length"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :
                                       _Singleinvoicelist['items'][i]['length'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),
          
         */  
         DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Measurement"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['items'][i]['one_unit_value'].toString() == "null" ?"0.00" : _Singleinvoicelist['items'][i]['one_unit_value'],
                                                        // == 'null' ? '0.00' :
                                     //  _Singleinvoicelist['items'][i]['height'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),    
                                                        DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("QTY"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['items'][i]['unit_qty'].toString() == "null" ?"0.00" : _Singleinvoicelist['items'][i]['one_unit_value'],
                                                        // == 'null' ? '0.00' :
                                     //  _Singleinvoicelist['items'][i]['height'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),                                              
              
          
DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Total"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['itemsdata'][i]['quantity'].toString()
                                                        // == 'null' ? '0.00' :
                                     //  _Singleinvoicelist['items'][i]['height'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),                                              
                 DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Price"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(defaultcurrency+" " + _Singleinvoicelist['itemsdata'][i]['price'].toString()
                                                        // == 'null' ? '0.00' :
                                     //  _Singleinvoicelist['items'][i]['height'].toString()// :  _Singleinvoicelist['items'][i]['width'].toString()
                                                        
                                                        
                                                     //   +_Singleinvoicelist['items'][i] ['length'].toString() == 'null' ? '0.00' :  _Singleinvoicelist['items'][i]['length'].toString(),
                                                       /* +'*'+_Singleinvoicelist['items'][i]
                                                              ['height'].toString()+ '*'+ _Singleinvoicelist['items'][i]
                                                              ['length'].toString()
                                                            .toString()),*/
                                                      )),
                                                    ],
                                                  ),                                              
                 
                                                      DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Discount"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(defaultcurrency+" " + _Singleinvoicelist['itemsdata'][i]['discount'].toString()
                                                      
                                                      )),
                                                    ],
                                                  ),                                              
                
               DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Total Price"),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
          
                                                        //"${(element['price'] as double) * (element['step'] as int)} c"
                                                        Text(defaultcurrency+" " +  
                                                        "${(double.parse(_Singleinvoicelist['itemsdata'][i]['quantity'])) * (double.parse(_Singleinvoicelist['itemsdata'][i]['price']))}"
                                                         //_Singleinvoicelist['itemsdata'][i]['quantity'] * int.tryParse( _Singleinvoicelist['itemsdata'][i]['price'])
                                                        //double.parse(_Singleinvoicelist['itemsdata'][i]['quantity'] )* _Singleinvoicelist['itemsdata'][i]['price'].toString()
                                                        
                                                      )),
                                                    ],
                                                  ),                                              
                
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Tax'),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(_Singleinvoicelist['items'][i]['itemTax'][0][
                                                                'name']+" "+_Singleinvoicelist['items'][i]['itemTax'][0][
                                                                'rate']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                              
                                                   DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Total Value'),
                                                        //   showEditIcon: true,
                                                      ),
                                                         for (int i = 0;
                                                      i <
                                                          _Singleinvoicelist[
                                                                  'items']
                                                              .length;
                                                      i++)
                                                      DataCell(
                                                        Text(defaultcurrency+" "+_Singleinvoicelist['invoice_totalamt']
                                                            .toString()
                                                            ,
                                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                                      ),
                                                    ],
                                                  ),
                                              
                      ],
                                              ),
                                            ),
                                          ],
                                        ),//invoice_totalamt
                                        Center(
                                          child: Text(
                                            'Billing Address Details',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                //  fontStyle: FontStyle.italic,
                                                color: Color(maincolor)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DataTable(
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Center(
                                                      child: Text(
                                                        'Billing Address',
                                                        style: TextStyle(
                                                            fontStyle:
                                                                FontStyle.italic,
                                                            color:
                                                                Color(maincolor)),
                                                      ),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      _Singleinvoicelist[
                                                              'billing_address']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                ],
                                                rows: <DataRow>[
                                                  //     for (int ij = 0; ij < _leadlist.length; ij++)
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Billing City"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'billing_city']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Billing Country"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'billing_country']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Zip Code"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'billing_postalcode']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Billing Contact'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'name']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            'Shipping Address Details',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                //  fontStyle: FontStyle.italic,
                                                color: Color(maincolor)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DataTable(
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Center(
                                                      child: Text(
                                                        'Shipping Address',
                                                        style: TextStyle(
                                                            fontStyle:
                                                                FontStyle.italic,
                                                            color:
                                                                Color(maincolor)),
                                                      ),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      _Singleinvoicelist[
                                                              'shipping_address']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                ],
                                                rows: <DataRow>[
                                                  //     for (int ij = 0; ij < _leadlist.length; ij++)
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Shipping City"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'shipping_city']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Shipping Country"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'shipping_country']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text("Zip Code"),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'shipping_postalcode']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Shipping Contact'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_Singleinvoicelist[
                                                                'name']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            'Payment History',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                //  fontStyle: FontStyle.italic,
                                                color: Color(maincolor)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DataTable(
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Center(
                                                      child: Text(
                                                        'Transaction ID',
                                                        style: TextStyle(
                                                            fontStyle:
                                                                FontStyle.italic,
                                                            color:
                                                                Color(maincolor)),
                                                      ),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "#T0000" +
                                                          _paymentinvoicedetails[0]
                                                                  ['transaction_id']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(maincolor)),
                                                    ),
                                                  ),
                                                ],
                                                rows: <DataRow>[
                                                  //     for (int ij = 0; ij < _leadlist.length; ij++)
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('	Payment Date'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_paymentinvoicedetails[
                                                                0]['date']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Notes'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_paymentinvoicedetails[
                                                                0]['notes']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
          
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Payment Type'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(_paymentinvoicedetails[
                                                                0]['payment_type']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                        Text('Amount'),
                                                        //   showEditIcon: true,
                                                      ),
                                                      DataCell(
                                                        Text(defaultcurrency +
                                                            " " +
                                                            _paymentinvoicedetails[
                                                                    0]['amount']
                                                                .toString()),
                                                      ),
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
                                    child: Container(
                                      height: 40.0,
                                      width: 100.0,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            //  foregroundColor: color:Color(maincolor),
          
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(18.0),
                                                    side: BorderSide(
                                                        color: Color(maincolor))))),
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
                                ],
                              )
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 150.0,
                              ),
                              new Center(
                                child: new CircularProgressIndicator(),
                              ),
                            ],
                          );
                  });
            }
          ),
        ),
      ),
    );
  }
}

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