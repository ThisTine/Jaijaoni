import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaijaoni/components/circle_avata.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/functions/profile/set_profile_picture.dart';
import 'package:jaijaoni/functions/profile/user_name.dart';

import '../config/theme/custom_color.g.dart';
import '../functions/profile/updateinfo.dart';
import '../model/user.model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? imagefile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _name = TextEditingController();
  String imgUrl = '';
  final TextEditingController _quote = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getImage();
    username().then((uname) {
      _name.text = uname;
    });
    quoteprefill().then((quote) {
      _quote.text = quote;
    });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // var image = await pickedFile.readAsBytes();
      // var imgFile = await File("test.png").writeAsBytes(image);
      // print(await pickedFile.readAsBytes());
      setState(() {
        imagefile = pickedFile;
      });
      // setState(() {});
    }
  }

  _getImage() async {
    String imgurl = await profilepic();
    setState(() {
      imgUrl = imgurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    void save(context) {
      SnackBar snackBar = const SnackBar(
        content: Text('Profile Updated'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Edit", backButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              imagefile != null
                  ? circleAvata(radius: 70, imagefile: imagefile!)
                  : circleAvataUser(radius: 70, imgUrl: imgUrl),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Upload Profile",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .fontSize)),
                  IconButton(
                      onPressed: () {
                        _getFromGallery();

                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) => Padding(
                        //         padding: const EdgeInsets.all(20.0),
                        //         child: ListView(children: [Row(children: [])])));
                      },
                      icon: Icon(Icons.edit,
                          color: Theme.of(context).colorScheme.primary,
                          size:
                              Theme.of(context).textTheme.titleSmall!.fontSize))
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textlebel(context, "Name"),
                        const SizedBox(width: 65),

                        FutureBuilder<String>(
                          future: username(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return hintlebel(context, snapshot.data!, _name);
                            } else if (snapshot.hasError) {
                              return hintlebel(
                                  context, 'Error: ${snapshot.error}', _name);
                            }
                            return hintlebel(
                              context,
                              ' ${snapshot.data ?? ''}',
                              _name,
                            );
                          },
                        ),
                        // hintlebel(context, "name"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textlebel(context, "Quote"),
                        const SizedBox(width: 65),

                        FutureBuilder<String>(
                          future: quoteprefill(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return hintlebel(context, snapshot.data!, _quote);
                            } else if (snapshot.hasError) {
                              return hintlebel(
                                  context, 'Error: ${snapshot.error}', _quote);
                            }
                            return hintlebel(
                                context, ' ${snapshot.data ?? ''}', _quote);
                          },
                        ),
                        // hintlebel(context, "add quote"),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      width: 1))),
                          onPressed: () {
                            context.go('/profile');
                          },
                          child: Text("Cancel",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .extension<CustomColors>()!
                                      .sourceRedbar,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize))),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          username().then((uname) {
                            update(Users(
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              profilePic: "",
                              username: uname,
                              name: _name.text,
                              quote: _quote.text,
                              charts: [],
                              friendList: [],
                              accs: [],
                            )).then((value) {
                              if (imagefile != null) {
                                setProfilepicture(imagefile!).then((value) {
                                  save(context);
                                  context.go("/profile");
                                });
                              } else {
                                save(context);
                                context.go('/profile');
                              }
                            });
                          });
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textlebel(BuildContext context, String text) {
  return Text(text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize));
}

Widget hintlebel(
    BuildContext context, String text, TextEditingController controller) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.4,
    ),
    height: 50,
    child: (Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: Theme.of(context).colorScheme.primaryContainer,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
              decoration: InputDecoration(
                hintText: text,
                hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontSize:
                        Theme.of(context).textTheme.labelMedium!.fontSize),
              ),
            ),
          )
        ])),
  );
}
