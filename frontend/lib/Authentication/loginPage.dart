import 'dart:convert';
import 'dart:io';
import 'package:frontend/Classes/User.dart';
import 'package:frontend/homeScreen.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_selector/file_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController referenceTokenController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController yearofJoining = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController core = TextEditingController();
  bool passwordObscuretext = true;
  IconData passwordIcon = CupertinoIcons.lock;
  String imageURL = "nkdsnvlks";
  var pageHeight = 520;
  var counter = 1;
  var user;

  var file = null;
  var imagePath = "";
  var status = "Error";

  final cloudinary =
      Cloudinary("146921317957316", "dMy6eCEsZ0YpupA_FoMaR_z_sEo", "ddglxo0l3");

  void tohome() {
    setState(() {
      pageHeight = 520;
      counter = 1;
    });
  }

  void confirmToken() async {
    setState(() {
      counter = 0;
    });
    var url = Uri.parse("http://127.0.0.1:1000/api/authentication/addRefUser");
    var body = {"referenceTokenID": referenceTokenController.text};
    var headers = {"content-type": "application/json"};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        var values = jsonDecode(response.body);
        Name = values['firstName'];
        ImageURL = values['photoURL'];
        Designation = values['designation'];
        pageHeight = 440;
        counter = 8;
      });
    } else {
      setState(() {
        var body = jsonDecode(response.body);
        status = body['status'];
        counter = 7;
      });
    }
  }

  void toSubmission() {
    if (firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        department.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        yearofJoining.text.isNotEmpty &&
        designation.text.isNotEmpty &&
        core.text.isNotEmpty) {
      setState(() {
        pageHeight = 520;
        counter = 4;
      });
    }
  }

  void getFile() async {
    try {
      final xtypegroup =
          XTypeGroup(label: 'image', extensions: ['jpeg', 'png']);
      final imageFile = await openFile(acceptedTypeGroups: [xtypegroup]);
      var data = await imageFile?.readAsBytes();
      if (data != null) {
        var completedFile = File.fromRawPath(data);
        setState(() {
          imagePath = imageFile!.path;
          file = completedFile;
        });
      }
    } catch (err) {
      print(err);
      setState(() {
        counter = 7;
      });
    }
  }

  void toTokenRegistrationPage() {
    setState(() {
      counter = 6;
      pageHeight = 320;
    });
  }

  void toRegistration() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
      setState(() {
        pageHeight = 630;
        counter = 3;
      });
  }

  void toError() {
    setState(() {
      counter = 7;
      pageHeight = 400;
    });
  }

  Future<void> login() async {
    setState(() {
      counter = 0;
    });
    try {
      var URL = Uri.parse("http://127.0.0.1:1000/api/authentication/login");
      var body = {
        'email': emailController.text.toString(),
        'password': passwordController.text.toString()
      };
      var header = {"content-type": "application/json"};
      var bodyToPush = jsonEncode(body);
      var response = await http.post(URL, headers: header, body: bodyToPush);
      if (response.statusCode == 200) {
        var values = await jsonDecode(response.body);
        setState(() {
          Name = values['firstName'];
          ImageURL = values['photoURL'];
          Designation = values['designation'];
          pageHeight = 440;
          counter = 8;
        });
        // var currentUser = User(
        //     id: values['_id'],
        //     email: values['email'],
        //     firstName: values['firstName'],
        //     lastName: values['lastName'],
        //     photoURL: values['photoURL'],
        //     department: values['department'],
        //     phoneNumber: values['phoneNumber'],
        //     designation: values['designation'],
        //     yearOfJoining: values['yearOfJoining']);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("User", response.body);
      } else {
        setState(() {
          counter = 7;
        });
      }
    } catch (err) {
      print(err);
      setState(() {
        counter = 7;
      });
    }
  }

  Future<String?> uploadProfileImage() async {
    if (file == null) {
      return "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png";
    } else {
      final response = await cloudinary.uploadFile(
          filePath: imagePath,
          resourceType: CloudinaryResourceType.image,
          folder: "ProfileImages");
      if (response.isSuccessful) {
        var imageURL = response.secureUrl;
        return imageURL;
      } else {
        setState(() {
          counter = 7;
        });
      }
    }
  }

  void SubmitReferenceUser() async {
    setState(() {
      counter = 0;
    });
    var imageURL = await uploadProfileImage();
    var submitURI =
        Uri.parse("http://127.0.0.1:1000/api/authentication/registerRefUser");
    var body = {
      "email": emailController.text,
      "password": passwordController.text,
      "phoneNumber": phoneNumber.text,
      "photoURL": imageURL,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "department": department.text,
      "yearOfJoining": yearofJoining.text,
      "designation": designation.text,
      "core": core.text
    };
    var headers = {"content-type": "application/json"};
    var response =
        await http.post(submitURI, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        pageHeight = 350;
        counter = 5;
      });
    } else {
      setState(() {
        counter = 7;
      });
    }
  }

  ImageProvider getImage() {
    if (file == null) {
      return NetworkImage(
          "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png");
    } else {
      return FileImage(File(imagePath));
    }
  }

  String ImageURL =
      "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png";
  String Name = "No Name";
  String Designation = "No Designation";

  @override
  Widget build(BuildContext context) {
    var pages = [
      LoadingIndicatior(),
      firstpage(),
      UserInfoPage(),
      registrationPage(),
      submissionPage(),
      submissionDone(),
      TokenVerificationPage(),
      ErrorPage(),
      loginSuccessPage(context),
    ];
    var currentPage = pages[counter];
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/brandLogo.jpg'),
                    height: 160.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: double.parse("${pageHeight}"),
                    width: 425,
                    margin: EdgeInsets.only(bottom: 6.0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(2.0, 5.0),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: currentPage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Column loginSuccessPage(BuildContext context) {
    return Column(
      children: [
        Image(
          image: NetworkImage(
              "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png"),
          height: 250,
          width: 250,
        ),
        Text(
          "Hello ${Name}",
          style: TextStyle(fontSize: 20, fontFamily: "Futura"),
        ),
        Text(
          "${Designation}",
          style: TextStyle(fontFamily: "Futura", fontSize: 10),
        ),
        SizedBox(
          height: 20,
        ),
        roboButtons(
            title: "Take me => Workstation",
            ontap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => homePage()));
            },
            fillColor: Colors.white,
            borderColor: Colors.blue.shade800,
            textColor: Colors.black)
      ],
    );
  }

  Column ErrorPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Crash!!!",
          style: TextStyle(fontSize: 90),
        ),
        Divider(
          thickness: 1,
          indent: 50,
          endIndent: 50,
          height: 20,
        ),
        Text(
          "I know it hurts, Par kya kare, sehe lo thoda!!!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        roboButtons(
            ontap: () {
              tohome();
            },
            title: "Back to home",
            fillColor: Colors.white,
            borderColor: Colors.blue.shade800,
            textColor: Colors.black)
      ],
    );
  }

  Column TokenVerificationPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hii there, if you have registered earlier you may have recieved a reference token by robovitics via Email, please enter the token below, This is the final stage of your registration process. You can use this token only once, you have yo register one more time if you fail",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontFamily: "Futura"),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          color: Colors.black,
          thickness: 1,
        ),
        roboTextFeild(
            obscuretext: false,
            placeholder: "Your Reference Token",
            controller: referenceTokenController,
            type: TextInputType.text),
        SizedBox(
          height: 10,
        ),
        Divider(
          indent: 100,
          endIndent: 100,
          color: Colors.black,
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            roboButtons(
                ontap: () {
                  tohome();
                },
                title: "Back home",
                width: double.parse("${170}"),
                fillColor: Colors.white,
                borderColor: Colors.blue.shade800,
                textColor: Colors.black),
            roboButtons(
                ontap: () {
                  confirmToken();
                },
                title: "Confirm ",
                width: double.parse("${170}"),
                fillColor: Colors.blue.shade800,
                borderColor: Colors.blue.shade800,
                textColor: Colors.white),
          ],
        )
      ],
    );
  }

  Column submissionDone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "We have added a registration request for you, we will respond you through a token, you can use that token to signUp into the application.\n\nThank you!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontFamily: "Futura"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        roboButtons(
            ontap: () {
              tohome();
            },
            title: "Back to home",
            fillColor: Colors.white,
            borderColor: Colors.blue.shade800,
            textColor: Colors.black)
      ],
    );
  }

  Column submissionPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Upload an Image",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            getFile();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image(
              image: getImage(),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        roboButtons(
            ontap: () {
              SubmitReferenceUser();
            },
            title: "Submit Appeal",
            fillColor: Colors.white,
            borderColor: Colors.blue.shade800,
            textColor: Colors.black)
      ],
    );
  }

  Column registrationPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Registration Request",
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 17),
        ),
        Divider(
          indent: 150,
          endIndent: 150,
          color: Colors.grey.shade600,
          thickness: 1,
        ),
        Text(
          "Please enter your details below",
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "First Name",
          controller: firstName,
          type: TextInputType.text,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Last Name",
          controller: lastName,
          type: TextInputType.text,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Applying for department",
          controller: department,
          type: TextInputType.text,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Phone Number",
          controller: phoneNumber,
          type: TextInputType.phone,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Year",
          controller: yearofJoining,
          type: TextInputType.datetime,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Applying for designation",
          controller: designation,
          type: TextInputType.text,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          placeholder: "Core",
          controller: core,
          type: TextInputType.text,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            roboButtons(
              fillColor: Colors.blue.shade800,
              borderColor: Colors.blue.shade800,
              textColor: Colors.white,
              width: double.parse("${170}"),
              title: "Prev",
              ontap: () {
                tohome();
              },
            ),
            roboButtons(
              ontap: () {
                toSubmission();
              },
              fillColor: Colors.blue.shade800,
              borderColor: Colors.blue.shade800,
              textColor: Colors.white,
              width: double.parse("${170}"),
              title: "Next",
            )
          ],
        ),
        Divider(
          endIndent: 120.w,
          indent: 120.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        Text(
          'roboVITics 2021',
          style: TextStyle(color: Colors.grey, fontSize: 8),
        )
      ],
    );
  }

  Center UserInfoPage() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image(
            image: NetworkImage(imageURL),
            height: 180,
            width: 180,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "vdslblksmbvfs",
          style: TextStyle(fontSize: 30, fontFamily: "futura"),
        ),
        Text(
          "vdsklvmds",
          style: TextStyle(color: Colors.grey.shade600),
        )
      ],
    ));
  }

  Center LoadingIndicatior() {
    return Center(
        child: Loading(
      indicator: BallSpinFadeLoaderIndicator(),
      size: 40.sp,
      color: Colors.black,
    ));
  }

  Column firstpage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi there,\nWelcome to Robovitics, the official robotics club of Vellore institute of technology, olease log inside the application to gain advantage of robovitics resources and assets, if you don't have an asset, kindly register yourself, we will provide you the Access IDs within 24 hours\nThank you! ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Futura',
          ),
        ),
        Divider(
          endIndent: 20.w,
          indent: 20.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Sign in to Robovitics Official',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        Divider(
          endIndent: 130.w,
          indent: 130.w,
          thickness: 0.3,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        roboTextFeild(
          obscuretext: false,
          controller: emailController,
          placeholder: "Email registered with organisation",
          type: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            roboTextFeild(
              obscuretext: passwordObscuretext,
              placeholder: "Password for this email address",
              controller: passwordController,
              type: TextInputType.visiblePassword,
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (passwordObscuretext == true) {
                          passwordObscuretext = false;
                          passwordIcon = CupertinoIcons.lock_open;
                        } else {
                          passwordObscuretext = true;
                          passwordIcon = CupertinoIcons.lock;
                        }
                      });
                    },
                    child: Icon(
                      passwordIcon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Divider(
          endIndent: 120.w,
          indent: 120.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roboButtons(
              fillColor: Colors.blue.shade800,
              borderColor: Colors.blue.shade800,
              textColor: Colors.white,
              title: "Log in",
              width: double.parse("${160}"),
              ontap: () {
                login();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
            ),
            roboButtons(
              fillColor: Colors.blue.shade800,
              borderColor: Colors.blue.shade800,
              textColor: Colors.white,
              width: double.parse("${160}"),
              title: "Join Request",
              ontap: () {
                toRegistration();
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "OR",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        roboButtons(
          fillColor: Colors.white,
          borderColor: Colors.blue.shade800,
          textColor: Colors.black,
          width: double.parse("${340}"),
          title: "Confirm myself with token",
          ontap: () {
            toTokenRegistrationPage();
          },
        ),
        Divider(
          endIndent: 120.w,
          indent: 120.w,
          thickness: 0.2,
          color: Colors.black,
        ),
        Text(
          'roboVITics 2021',
          style: TextStyle(color: Colors.grey, fontSize: 8),
        )
      ],
    );
  }
}

class roboButtons extends StatelessWidget {
  const roboButtons({
    required this.title,
    required this.fillColor,
    required this.borderColor,
    this.ontap,
    this.width,
    required this.textColor,
  });

  final String title;
  final ontap;
  final width;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontFamily: "Futura",
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}

class roboTextFeild extends StatelessWidget {
  const roboTextFeild(
      {required this.obscuretext,
      required this.placeholder,
      required this.controller,
      required this.type});

  final bool obscuretext;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          obscureText: obscuretext,
          keyboardType: type,
          style: TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
