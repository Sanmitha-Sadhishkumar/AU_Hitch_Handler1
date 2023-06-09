import 'dart:io';
import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import '../../../constants.dart';
import '../../../resources/post_methods.dart';
import '../../components/customfields/customelevatedbutton.dart';

class ImageSourceSelect extends StatefulWidget {
  const ImageSourceSelect({
    super.key,
  });

  @override
  State<ImageSourceSelect> createState() => _ImageSourceSelectState();
}

class _ImageSourceSelectState extends State<ImageSourceSelect> {
  File? imageFile;
  List<File>? imageList;
  Future pickImage(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(
          source: source, maxHeight: 1080, maxWidth: 1920, imageQuality: 100);

      if (file == null) {
        debugPrint('Image pick using $source : Failed!');
        return; //Todo Dialog
      }

      setState(() {
        imageFile = File(file.path);
        debugPrint(UploadFileList.appendFile(imageFile!));
        debugPrint('Image pick using $source : Succesful!');
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }

    Navigator.pop(context);
  }

  Future pickMultiImage() async {
    try {
      final list = await ImagePicker()
          .pickMultiImage(maxHeight: 1080, maxWidth: 1920, imageQuality: 50);

      if (list == null || list == []) {
        print('multi Image picking : Failed!');
        return; //Todo Dialog
      }

      setState(() {
        int lent = 0;
        if (list.length > 5 - UploadFileList.currLength()) {
          lent = 5 - UploadFileList.currLength();
        } else {
          lent = list.length;
        }
        for (var i = 0; i < lent; i++) {
          imageFile = File(list[i].path);
          debugPrint(UploadFileList.appendFile(imageFile!) + " : $i+1");
        }
        debugPrint('multi Image picking : Succesful!');
      });
    } on Exception catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    //Todo Show Dialog if chosen many images
    Navigator.pop(context);
  }

  final String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    TextStyle textStyle =
        AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
      color: kTextColor,
      //fontWeight: isDark ? FontWeight.normal : FontWeight.w500,
      fontSize: 13,
      fontFeatures: const [
        FontFeature.tabularFigures(),
        FontFeature.oldstyleFigures()
      ],
    );
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
              child: Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: isDark
                        ? kTextColor.withOpacity(0.4)
                        : kLTextColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FittedBox(
              child: Text(
                "Select Image source :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? kTextColor : kLTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButtonWithIcon(
                    activeColor: Colors.lightBlue[200]!,
                    label: "Camera",
                    icon: Icons.camera_alt_rounded,
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButtonWithIcon(
                    activeColor: Colors.green[300]!,
                    label: "Gallery",
                    icon: Icons.photo_library_rounded,
                    onPressed: () {
                      pickMultiImage();
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Theme(
                data: ThemeData(
                  useMaterial3: true,
                  splashColor: Colors.transparent,
                  brightness: Brightness.dark,
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  initiallyExpanded: true,
                  textColor: kTextColor,
                  collapsedTextColor: kTextColor.withOpacity(0.8),
                  iconColor: kTextColor,
                  collapsedIconColor: kTextColor.withOpacity(0.8),
                  backgroundColor: isDark ? kBlack20 : kGrey30,
                  collapsedBackgroundColor: isDark ? kBlack20 : kGrey30,
                  title: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Note',
                        style: TextStyle(
                          fontWeight:
                              isDark ? FontWeight.normal : FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$bullet Max Image count \t-\t 5.",
                            style: textStyle,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "$bullet Max Resolution \t-\t 1920 x 1080.",
                            style: textStyle,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "$bullet Camera \t:\t Capture single image.",
                            style: textStyle,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "$bullet Gallery \t:\t Select multiple images.",
                            style: textStyle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
