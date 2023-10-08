import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:klndrive/auth/userData.dart';
import 'package:klndrive/sharedPreferences/sharedPreferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  final String? phone;
  SignUp({this.phone});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _controller = TextEditingController();

  String? uid;
  String? mob;
  //dropdown variables
  final List<String> _branch = [
    'Computer Science',
    'Mathematics & Computing',
    'Electrical',
    'Mechanical',
    'Metallurgy & Materials',
    'Chemical',
    'Civil',
  ];

  final List<String> _degree = [
    'BTech',
    'MTech',
    'MSc',
    'PhD',
  ];

  final List<String> _dept = [
    'Computer Science',
    'Maths',
    'Electrical',
    'Mechanical',
    'Metallurgy & Materials',
    'Chemical',
    'Civil',
    'Biomedical',
    'Physics',
    'Humanities',
    'Chemistry',
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form field variables
  String? name;
  String? phone;
  String? email;
  String? upi;
  String? vehicleNo;
  String? branch = 'Computer Science';
  String? department = 'Computer Science';
  String? year = '1st';
  int? carpool = 1;
  int? role = 0;
  bool _isVisible = false;
  bool _isVisibleFaculty = false;
  bool _isVisibleStudent = true;
  String? degree = 'BTech';
  bool validEmail = false;
  bool validPhone = false;

  bool _areFieldsFilled() {
    if (_controller.text.isEmpty) {
      _showToast("Name is required");
      return false;
    }

    return true;
  }

  bool _areFieldsFilledPhone(String phoneNo) {
    if (phoneNo.length != 10) {
      // _showToast("Please provide your number");
      return false;
    }
    validPhone = true;
    return true;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
    );
  }

  void saveUserInfo() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    phone = FirebaseAuth.instance.currentUser!.phoneNumber;
    await UserDatabaseService(uid: uid).updateUserData(name, phone, email, upi,
        degree, branch, year, carpool, role, department, vehicleNo);
    // print("stored user details in firestore");

    //save user id from response in local storage

    MySharedPreferences.instance.setStringValue("userName", name!);
    MySharedPreferences.instance.setStringValue("userPhone", phone!);
    MySharedPreferences.instance.setStringValue("userBranch", branch!);
    MySharedPreferences.instance.setStringValue("vechicleno", vehicleNo!);
    MySharedPreferences.instance.setStringValue("degree", degree!);
    MySharedPreferences.instance.setStringValue("email", email!);
    MySharedPreferences.instance.setStringValue("userYear", year!);
    MySharedPreferences.instance.setBoolValue("isLoggedIn", true);
    MySharedPreferences.instance.setIntValue("carpool", carpool!);
    MySharedPreferences.instance.setIntValue("role", role!);
    MySharedPreferences.instance.setStringValue("department", department!);
    MySharedPreferences.instance.setStringValue("upi", upi!);

    // print("stored user data in local storage");
  }

  // Submit the user details to database
  void _submitForm(BuildContext context) async {
    saveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 221, 231, 232),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image(
                //
                height: 200,
                width: 350,

                image: AssetImage("assets/sign.jpeg"),
              ),
              // Sign Up container
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                width: screenWidth,
                height: 840.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // UserName

                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),

                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            labelText: "Name",
                            icon: Icon(Icons.account_circle)),
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontFamily: "Poppins"),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),

                      // Phone
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Phone No.",
                            icon: Icon(Icons.phone_android_outlined)),
                        keyboardType: TextInputType.number,
                        validator: (input) => _areFieldsFilledPhone(input!)
                            ? null
                            : "Please enter a valid phone number",
                        maxLength: 10,
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                          // if (val.length != 10) {
                          //   _showToast("Please enter correct phone number");
                          // }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.0),
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Email id",
                            icon: Icon(Icons.email_rounded)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (input) => EmailValidator.validate(input!)
                            ? null
                            : "Please enter a valid email address",
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "UPI Id",
                            icon: Icon(Icons.credit_card_outlined)),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          setState(() {
                            upi = val;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Student:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 0,
                            groupValue: role,
                            onChanged: (int? val) {
                              setState(() {
                                role = val;
                                _isVisibleStudent = true;
                                _isVisibleFaculty = false;
                              });
                            },
                          ),
                          Text("Faculty:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 1,
                            groupValue: role,
                            onChanged: (int? val) {
                              setState(() {
                                role = val;
                                _isVisibleFaculty = true;
                                _isVisibleStudent = false;
                              });
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      ),
                      Visibility(
                        visible: _isVisibleStudent,
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                height: 185.0,
                                width: 400.0,
                                child: Row(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text("Degree: ",
                                                style:
                                                    TextStyle(fontSize: 17.0)),
                                            Padding(
                                                padding: EdgeInsets.all(5.0)),
                                            DropdownButton<String>(
                                              value: degree,
                                              items:
                                                  _degree.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  degree = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(5.0)),
                                        Row(
                                          children: [
                                            Text("Branch: ",
                                                style:
                                                    TextStyle(fontSize: 17.0)),
                                            Padding(
                                                padding: EdgeInsets.all(5.0)),
                                            DropdownButton<String>(
                                              value: branch,
                                              items:
                                                  _branch.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  branch = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(5.0)),
                                        // Year
                                        Row(
                                          children: [
                                            Text("Year: ",
                                                style:
                                                    TextStyle(fontSize: 17.0)),
                                            Padding(
                                                padding: EdgeInsets.all(5.0)),
                                            DropdownButton<String>(
                                              value: year,
                                              items: <String>[
                                                '1st',
                                                '2nd',
                                                '3rd',
                                                '4th'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  year = value;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: _isVisibleFaculty,
                        child: Center(
                          child: (Row(
                            children: <Widget>[
                              Text("Department: ",
                                  style: TextStyle(fontSize: 17.0)),
                              Padding(padding: EdgeInsets.all(5.0)),
                              DropdownButton<String>(
                                value: department,
                                items: _dept.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    department = value;
                                  });
                                },
                              ),
                            ],
                          )),
                        ),
                      ),
                      // Branch
                      // Row(
                      //   children: <Widget>[
                      //     Text("Branch: ", style: TextStyle(fontSize: 17.0)),
                      //     Padding(padding: EdgeInsets.all(5.0)),
                      //     DropdownButton<String>(
                      //       value: branch,
                      //       items: _branch.map((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           branch = value;
                      //         });
                      //       },
                      //     ),
                      //     Padding(padding: EdgeInsets.all(10.0)),
                      //     // Year
                      //     Text("Year: ", style: TextStyle(fontSize: 17.0)),
                      //     Padding(padding: EdgeInsets.all(5.0)),
                      //     DropdownButton<String>(
                      //       value: year,
                      //       items: <String>['1st', '2nd', '3rd', '4th']
                      //           .map<DropdownMenuItem<String>>((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           year = value;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      // Carpool
                      Row(
                        children: <Widget>[
                          Text(
                            "Do you have a vehicle to pool?",
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(2.0)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Yes:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 0,
                            groupValue: carpool,
                            onChanged: (int? val) {
                              setState(() {
                                carpool = val;
                                _isVisible = true;
                              });
                            },
                          ),
                          Text("No:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 1,
                            groupValue: carpool,
                            onChanged: (int? val) {
                              setState(() {
                                carpool = val;
                                _isVisible = false;
                              });
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Vehicle No",
                              icon: Icon(Icons.directions_bike)),
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontFamily: "Poppins"),
                          onChanged: (val) {
                            setState(() {
                              vehicleNo = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Submit Button

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.green)),
                                  child: Text("Register"),
                                  onPressed: () {
                                    if (_areFieldsFilled() && validPhone) {
                                      _submitForm(context);
                                      Navigator.pushNamed(context, "/otphome");
                                    }
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
