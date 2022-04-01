import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pneumonia_detection/utils/constants.dart';
import 'package:tflite/tflite.dart';
import '../utils/app_theme.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? _classifiedResult;
  var pickedImage1;
  var pickedImage2;
  Future<void> _getImage1() async {
    Uint8List? bytesFromPicker1 = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker1 != null) {
      setState(() {
        pickedImage1 = bytesFromPicker1;
      });
    }
    classifyImage(pickedImage1);
  }

  Future<void> _getImage2() async {
    Uint8List? bytesFromPicker2 = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker2 != null) {
      setState(() {
        pickedImage2 = bytesFromPicker2;
      });
    }
    classifyImage(pickedImage2);
  }

  Future loadModel() async {
    String? result;
    result = await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt",
    );
    print(result);
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    print("classification start $image");
    final List? result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("classification done");
    setState(() {
      if (image != null) {
        pickedImage1 = File(image);
        _classifiedResult = result;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Padding(
          padding: hpad8,
          child: Text('Pneumonia Predictor', style: appBarheader),
        ),
        backgroundColor: AppTheme.maintheme,
        actions: [
          sBoxH30,
          sBoxH20,
          TextButton(
              onPressed: () {},
              child: const Text(
                'Products',
                style: appBarmenu,
              )),
          const SizedBox(width: 50),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Services',
                style: appBarmenu,
              )),
          const SizedBox(width: 50),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Contact Us',
                style: appBarmenu,
              )),
          const SizedBox(width: 50),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sBoxH20,
                    sBoxH30,
                    const Padding(
                      padding: hpad30,
                      child: Text('The More You Breathe', style: header1),
                    ),
                    sBoxH10,
                    const Padding(
                      padding: hpad30,
                      child: Text(
                        'The More You Live',
                        style: header1,
                      ),
                    ),
                    sBoxH20,
                    sBoxH20,
                    const Padding(
                      padding: hpad30,
                      child: Text(
                        'The most important function of the lungs is to take oxygen from the\nenvironment and transfer it to the bloodstream.',
                        style: body1,
                      ),
                    ),
                    sBoxH20,
                    sBoxH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sBoxW30,
                        Image.asset(
                          'assets/images/upload.png',
                          height: 25,
                          width: 25,
                        ),
                        sBoxW10,
                        const Text(
                          'Upload your X-ray',
                          style: header2,
                        ),
                        sBoxW30,
                        sBoxW30,
                        sBoxW30,
                        Image.asset('assets/images/server.png',
                            height: 25, width: 25),
                        sBoxW10,
                        const Text(
                          'Get verified with our servers',
                          style: header2,
                        )
                      ],
                    ),
                    sBoxH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        sBoxW30,
                        sBoxW30,
                        sBoxW5,
                        Text(
                          'Upload your images through\nany format.',
                          style: body1,
                        ),
                        sBoxW60,
                        sBoxW30,
                        Text(
                            'Generate accurate reports using our\nMachine Learning model',
                            style: body1)
                      ],
                    ),
                    sBoxH30,
                    sBoxH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sBoxW30,
                        Image.asset(
                          'assets/images/devices.png',
                          height: 25,
                          width: 25,
                        ),
                        sBoxW10,
                        const Text(
                          'Across multiple devices',
                          style: header2,
                        ),
                        sBoxW30,
                        sBoxW10,
                        Image.asset('assets/images/steth.png',
                            height: 25, width: 25),
                        sBoxW10,
                        const Text(
                          'Get immediate Doctor consultation !',
                          style: header2,
                        )
                      ],
                    ),
                    sBoxH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        sBoxW30,
                        sBoxW30,
                        sBoxW5,
                        Text(
                          'Get acces to your reports\non multiple devices.',
                          style: body1,
                        ),
                        sBoxW60,
                        sBoxW30,
                        sBoxW20,
                        Text(
                            'Get your reports consulted and verified\nwith expert doctors',
                            style: body1)
                      ],
                    ),
                  ],
                ),
                sBoxW60,
                sBoxW60,
                sBoxW60,
                Image.asset(
                  'assets/images/home.png',
                  height: 480,
                  width: 510,
                ),
              ],
            ),
            sBoxH30,
            sBoxH20,
            const Center(
                child: Text(
              'Why Should We Trust You?',
              style: header1,
            )),
            sBoxH30,
            sBoxH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 310,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sBoxH30,
                      Image.asset(
                        'assets/images/rib.png',
                        height: 75,
                        width: 75,
                      ),
                      sBoxH30,
                      const Text(
                        'We have trained our\nmodule with 5000+\nrecords to get maximum\naccuracy of your report',
                        style: body2,
                      )
                    ],
                  ),
                ),
                sBoxW30,
                Container(
                  height: 300,
                  width: 310,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sBoxH30,
                      Image.asset(
                        'assets/images/ct.png',
                        height: 75,
                        width: 75,
                      ),
                      sBoxH30,
                      const Text(
                        'In order to get more\naccuracy for your reports\nwe are using 1000+\nrecords of CT scan',
                        style: body2,
                      )
                    ],
                  ),
                ),
                sBoxW30,
                Container(
                  height: 300,
                  width: 310,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sBoxH30,
                      Image.asset(
                        'assets/images/drop.png',
                        height: 75,
                        width: 75,
                      ),
                      sBoxH30,
                      const Text(
                        'Through 500+ blood\nsample reports we can\ntrace out your Pneumonia\nreport more accurately',
                        style: body2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sBoxH60,
            const Padding(
              padding: hpad30,
              child: Text(
                'X-ray Predictor',
                style: header3,
              ),
            ),
            sBoxH30,
            Padding(
              padding: hpad30,
              child: (pickedImage1 != null)
                  ? Center(child: Image.memory(pickedImage1))
                  : DottedBorder(
                      dashPattern: const [8, 8],
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: AppTheme.lightgrey,
                      child: SizedBox(
                        height: 445,
                        width: 1335,
                        child: Column(
                          children: [
                            sBoxH60,
                            sBoxH60,
                            Image.asset(
                              'assets/images/cloud.png',
                              width: 55,
                              height: 34,
                            ),
                            sBoxH20,
                            const Text(
                              'Drop your Image\n             or',
                              style: body2,
                            ),
                            sBoxH20,
                            InkWell(
                              onTap: _getImage1,
                              child: Container(
                                width: 129,
                                height: 39,
                                decoration: BoxDecoration(
                                    color: AppTheme.maintheme,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                    child: Text(
                                  'Browse',
                                  style: browse,
                                )),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
            sBoxH20,
            SingleChildScrollView(
              child: Column(
                children: _classifiedResult != null
                    ? _classifiedResult!.map((result) {
                        return Card(
                          elevation: 0.0,
                          color: Colors.lightBlue,
                          child: Container(
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "${result["label"]} :  ${(result["confidence"] * 100).toStringAsFixed(1)}%",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    : [],
              ),
            ),
            sBoxH30,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sBoxW30,
                        const Text(
                          'Recommended Hospitals',
                          style: header4,
                        ),
                        sBoxW30,
                        sBoxW30,
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: AppTheme.maintheme,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.white,
                                size: 15,
                              ),
                              sBoxW5,
                              Text(
                                'Location',
                                style: location,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    sBoxH30,
                    sBoxH10,
                    Padding(
                      padding: hpad30,
                      child: Container(
                        height: 180,
                        width: 460,
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      const Text(
                                        'Gans Hospital • ₹₹₹ • Pulmonologist',
                                        style: body1,
                                      ),
                                      const Text(
                                        'Gans Hospital • Opens at 4:00 pm',
                                        style: body1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Puducherry',
                                            style: body1,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Website',
                                                style: cardButton,
                                              ),
                                            ),
                                          ),
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Direction',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 160,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      const Text(
                                        'Gans Hospital • ₹₹₹ • Pulmonologist',
                                        style: body1,
                                      ),
                                      const Text(
                                        'Gans Hospital • Opens at 4:00 pm',
                                        style: body1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Puducherry',
                                            style: body1,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Website',
                                                style: cardButton,
                                              ),
                                            ),
                                          ),
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Direction',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 160,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      const Text(
                                        'Gans Hospital • ₹₹₹ • Pulmonologist',
                                        style: body1,
                                      ),
                                      const Text(
                                        'Gans Hospital • Opens at 4:00 pm',
                                        style: body1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Puducherry',
                                            style: body1,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Website',
                                                style: cardButton,
                                              ),
                                            ),
                                          ),
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Direction',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 160,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      const Text(
                                        'Gans Hospital • ₹₹₹ • Pulmonologist',
                                        style: body1,
                                      ),
                                      const Text(
                                        'Gans Hospital • Opens at 4:00 pm',
                                        style: body1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Puducherry',
                                            style: body1,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Website',
                                                style: cardButton,
                                              ),
                                            ),
                                          ),
                                          sBoxW10,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Direction',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                sBoxW60,
                sBoxW30,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Overview', style: header5),
                    sBoxH10,
                    const Text(
                      'Upload your X-ray of your lungs or chest part with proper scaning of image',
                      style: body2,
                    ),
                    sBoxH10,
                    sBoxH5,
                    const Text('Image Accuracy', style: header5),
                    sBoxH10,
                    Container(
                      width: 650,
                      height: 25,
                      decoration: BoxDecoration(
                          color: AppTheme.violet,
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    sBoxH10,
                    sBoxH5,
                    const Text('Severity', style: header5),
                    sBoxH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppTheme.grey),
                          child: const Center(
                            child: Text(
                              'Mild',
                              style: appBarmenu,
                            ),
                          ),
                        ),
                        sBoxW10,
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppTheme.grey),
                          child: const Center(
                            child: Text(
                              'Severe',
                              style: appBarmenu,
                            ),
                          ),
                        ),
                        sBoxW10,
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppTheme.grey),
                          child: const Center(
                            child: Text(
                              'Normal',
                              style: appBarmenu,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            sBoxH60,
            const Padding(
              padding: hpad30,
              child: Text(
                'Computed Tomorgraphy Scan',
                style: header3,
              ),
            ),
            sBoxH30,
            Padding(
              padding: hpad30,
              child: (pickedImage2 != null)
                  ? Center(child: Image.memory(pickedImage2))
                  : DottedBorder(
                      dashPattern: const [8, 8],
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: AppTheme.lightgrey,
                      child: SizedBox(
                        height: 445,
                        width: 1335,
                        child: Column(
                          children: [
                            sBoxH60,
                            sBoxH60,
                            Image.asset(
                              'assets/images/cloud.png',
                              width: 55,
                              height: 34,
                            ),
                            sBoxH20,
                            const Text(
                              'Drop your Image\n             or',
                              style: body2,
                            ),
                            sBoxH20,
                            InkWell(
                              onTap: _getImage2,
                              child: Container(
                                width: 129,
                                height: 39,
                                decoration: BoxDecoration(
                                    color: AppTheme.maintheme,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                    child: Text(
                                  'Browse',
                                  style: browse,
                                )),
                              ),
                            )
                          ],
                        ),
                      )),
            ),
            sBoxH30,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sBoxW30,
                        const Text(
                          'Recommended Doctors',
                          style: header4,
                        ),
                        sBoxW30,
                        sBoxW30,
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: AppTheme.maintheme,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.white,
                                size: 15,
                              ),
                              sBoxW5,
                              Text(
                                'Location',
                                style: location,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    sBoxH30,
                    sBoxH10,
                    Padding(
                      padding: hpad30,
                      child: Container(
                        height: 180,
                        width: 460,
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 140,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/staru.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Book Now',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        '“Recommended Highly....Good consultation”',
                                        style: body1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 140,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/staru.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Book Now',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        '“Recommended Highly....Good consultation”',
                                        style: body1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 140,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/staru.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Book Now',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        '“Recommended Highly....Good consultation”',
                                        style: body1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              sBoxH20,
                              Container(
                                height: 140,
                                width: 460,
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: hpad20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sBoxH20,
                                      const Text(
                                        'Dr.Ganapathy',
                                        style: cardHeader,
                                      ),
                                      sBoxH10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/starf.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW5,
                                          Image.asset(
                                            'assets/images/staru.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW60,
                                          sBoxW30,
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppTheme.maintheme),
                                            child: const Center(
                                              child: Text(
                                                'Book Now',
                                                style: cardButton,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        '“Recommended Highly....Good consultation”',
                                        style: body1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                sBoxW60,
                sBoxW30,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Overview', style: header5),
                    sBoxH10,
                    const Text(
                      'Upload your CT scan of your lungs or chest part with proper scanned image',
                      style: body2,
                    ),
                    sBoxH10,
                    sBoxH5,
                    const Text('Image Accuracy', style: header5),
                    sBoxH10,
                    Container(
                      width: 650,
                      height: 25,
                      decoration: BoxDecoration(
                          color: AppTheme.violet,
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ],
                )
              ],
            ),
            sBoxH60,
            sBoxH10,
            const Padding(
              padding: hpad30,
              child: Text(
                'Blood Test Report',
                style: header3,
              ),
            ),
            sBoxH30,
            const Padding(
              padding: hpad30,
              child: Text(
                'Overview',
                style: header5,
              ),
            ),
            sBoxH10,
            const Padding(
              padding: hpad30,
              child: Text(
                'Please enter your blood sample details given below',
                style: body2,
              ),
            ),
            const Padding(
              padding: hpad30,
              child: Text('Enter your report details for accurate results',
                  style: body1),
            ),
            sBoxH30,
            const Padding(
              padding: hpad30,
              child: SizedBox(
                width: 1450,
                child: Divider(
                  thickness: 0.5,
                  color: AppTheme.grey,
                ),
              ),
            ),
            sBoxH60,
            Padding(
              padding: hpad30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 190,
                      width: 260,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 260,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppTheme.grey,
                                  offset: Offset(0.0, 0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppTheme.maintheme,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: const Center(
                                      child: Text('Urea', style: appBarmenu)),
                                ),
                                sBoxH10,
                                Container(
                                    width: 230,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppTheme.textboxgrey,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                        child: TextField(
                                            inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                            decoration: InputDecoration(
                                                suffixText: 'mg/dL',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    hpad12 + vpad12 + vpad4)))),
                                sBoxH10,
                                const Center(
                                    child: Text('Normal value', style: body1))
                              ],
                            ),
                          ),
                          const Center(
                              child: Text('6 to 24 mg/dL', style: body1))
                        ],
                      )),
                  sBoxW60,
                  Container(
                      height: 190,
                      width: 260,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 260,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppTheme.grey,
                                  offset: Offset(0.0, 0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppTheme.maintheme,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: const Center(
                                      child:
                                          Text('ATP/ALP', style: appBarmenu)),
                                ),
                                sBoxH10,
                                Container(
                                    width: 230,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppTheme.textboxgrey,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                        child: TextField(
                                            inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                            decoration: InputDecoration(
                                                suffixText: 'mmol/L',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    hpad12 + vpad12 + vpad4)))),
                                sBoxH10,
                                const Center(
                                    child: Text('Normal value', style: body1))
                              ],
                            ),
                          ),
                          const Center(
                              child: Text('1 to 10 mmol/L', style: body1))
                        ],
                      )),
                  sBoxW60,
                  Container(
                      height: 190,
                      width: 260,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 260,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppTheme.grey,
                                  offset: Offset(0.0, 0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppTheme.maintheme,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: const Center(
                                      child:
                                          Text('Creatine', style: appBarmenu)),
                                ),
                                sBoxH10,
                                Container(
                                    width: 230,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppTheme.textboxgrey,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                        child: TextField(
                                            inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                            decoration: InputDecoration(
                                                suffixText: 'mg/dL',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    hpad12 + vpad12 + vpad4)))),
                                sBoxH10,
                                const Center(
                                    child: Text('Normal value', style: body1))
                              ],
                            ),
                          ),
                          const Center(
                              child: Text('0.7 to 1.3 mg/dL', style: body1))
                        ],
                      )),
                  sBoxW60,
                  Container(
                      height: 190,
                      width: 260,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 260,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppTheme.grey,
                                  offset: Offset(0.0, 0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppTheme.maintheme,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: const Center(
                                      child: Text('WBC', style: appBarmenu)),
                                ),
                                sBoxH10,
                                Container(
                                    width: 230,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppTheme.textboxgrey,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                        child: TextField(
                                            inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                            decoration: InputDecoration(
                                                suffixText: 'WBCs per L',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    hpad12 + vpad12 + vpad4)))),
                                sBoxH10,
                                const Center(
                                    child: Text('Normal value', style: body1))
                              ],
                            ),
                          ),
                          const Center(
                              child: Text('4.5 to 11.0 x 109/L', style: body1))
                        ],
                      )),
                ],
              ),
            ),
            sBoxH60,
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppTheme.maintheme,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: appBarmenu,
                    ),
                  ),
                ),
              ),
            ),
            sBoxH60
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.maintheme,
          onPressed: () {},
          child: Center(
            child: Image.asset('assets/images/floatingbutton.png',
                height: 25, width: 25),
          )),
    );
  }
}
