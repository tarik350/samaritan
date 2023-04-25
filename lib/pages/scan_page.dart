import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dispalay_image_from_gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import '../main.dart';
import 'package:project_samaritan/theme/styles.dart' as style;

// ignore: must_be_immutable
class CameraScan extends StatefulWidget {
  bool? exitButton;
  CameraScan({Key? key, this.exitButton}) : super(key: key);

  @override
  State<CameraScan> createState() => CameraScanState();
}

class CameraScanState extends State<CameraScan> with TickerProviderStateMixin {
  late AnimationController _settingController;
  late AnimationController _favoriteController;
  late AnimationController _menuController;
  late AnimationController _bellController;
  late AnimationController _bookController;

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  IconData flashIcon = Icons.flash_off;
  Icon flashLightIcon = const Icon(
    Icons.flash_off,
    color: Colors.white,
  );
  Color flashLightIconColor = Colors.white;
  String falshLightStatus = 'off';
  int selectedCamera = 0;

  late String selectedImageFile;

  late XFile image;
  @override
  void initState() {
    super.initState();

    _settingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _favoriteController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _menuController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _bookController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    /// this  is to make the notification button disapear
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    initializeCamera(cameras[selectedCamera]);
    _fetchAssets();
  }

  List<AssetEntity> assets = [];
  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(type: RequestType.all);
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1, // end at a very big index (to get all the assets)
    );
    print(recentAssets);

    setState(() => assets = recentAssets);
  }

  void initializeCamera(CameraDescription camera) {
    _cameraController = CameraController(
        // Get a specific camera from the list of available cameras.
        camera,
        // Define the resolution to use.
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg);

    _initializeControllerFuture = _cameraController.initialize();
  }

  Future<void> _pickImage() async {
    selectedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery).then(
      (value) {
        return value!.path;
      },
    );
    setState(() {});
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (_cameraController == null) {
      return;
    }

    try {
      await _cameraController.setFlashMode(mode);
    } on CameraException catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void dispose() {
    _settingController.dispose();
    _favoriteController.dispose();
    _menuController.dispose();
    _bellController.dispose();
    _bookController.dispose();
    _cameraController.dispose();

    super.dispose();
  }

  Widget cameraWidget(context) {
    var camera = _cameraController.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(_cameraController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            //return Center(child: CircularProgressIndicator());

            return Overlay(
              initialEntries: [
                //the camera screen == the main screen
                OverlayEntry(builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: cameraWidget(context),
                          )),
                    ],
                  );
                }),
                //the camera taking button at the middle and gellery and setting on left and right
                OverlayEntry(builder: (context) {
                  return Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // a button to open the gallery and pick and image

                              GestureDetector(
                                onTap: () async {
                                  try {
                                    await _pickImage();

                                    if (!mounted) return;

                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayPictureScreen(
                                          imagePath: selectedImageFile,
                                          // Pass the automatically generated path to
                                          // the DisplayPictureScreen widget.
                                          //imagePath: image.path,
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    // If an error occurs, log the error to the console.
                                    print('error has occured : $e');
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: assets.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: AssetEntityImage(
                                                assets.first,
                                                fit: BoxFit.fill),
                                          )
                                        : Material(
                                            type: MaterialType.transparency,
                                            child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  Colors.black.withOpacity(.2),
                                              child: ClipRRect(
                                                child: Image.asset(
                                                  'assets/images/gallery icon.png',
                                                  height: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              //the middle white button we use to take a picture
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    image =
                                        await _cameraController.takePicture();

                                    if (!mounted) return;

                                    // If the picture was taken, display it on a new screen.
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayPictureScreen(
                                          imagePath: image.path,
                                          // Pass the automatically generated path to
                                          // the DisplayPictureScreen widget.
                                          //imagePath: image.path,
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    // If an error occurs, log the error to the console.
                                    print('error has occured : $e');
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  width: 65,
                                  height: 65,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 55,
                                      height: 55,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //button to change from front camera to back and vice versa
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor:
                                        Colors.black.withOpacity(.2),
                                    child: ClipRRect(
                                      child: TextButton(
                                        onPressed: () {
                                          if (_menuController.status ==
                                              AnimationStatus.dismissed) {
                                            _menuController.reset();
                                            _menuController.forward();
                                          } else {
                                            _menuController.reverse();
                                          }

                                          if (_menuController.isAnimating) {
                                            setState(() {
                                              if (selectedCamera == 0) {
                                                selectedCamera = 1;
                                              } else if (selectedCamera == 1) {
                                                selectedCamera = 0;
                                              }
                                              initializeCamera(
                                                  cameras[selectedCamera]);
                                            });
                                          }
                                        },
                                        child: RotationTransition(
                                          turns: Tween(begin: 0.0, end: 1.0)
                                              .animate(_menuController),
                                          child: Image.asset(
                                            'assets/images/switch-camera.png',
                                            height: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                }),

                //the top flashlight and exit button
                OverlayEntry(builder: (context) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //flashlight button
                            //this icon will have an animation to indicate that the flash light is on and of
                            //and it will also turn on and off flash light
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                    icon: const Icon(Icons.flash_off),
                                    color: _cameraController.value.flashMode ==
                                            FlashMode.off
                                        ? style
                                            .Style.medicineDescriptionColorMain
                                        : style.Style.flashLightColor,
                                    onPressed: () =>
                                        onSetFlashModeButtonPressed(
                                            FlashMode.off)),
                                IconButton(
                                    icon: const Icon(Icons.flash_auto),
                                    color: _cameraController.value.flashMode ==
                                            FlashMode.auto
                                        ? style
                                            .Style.medicineDescriptionColorMain
                                        : style.Style.flashLightColor,
                                    onPressed: () =>
                                        onSetFlashModeButtonPressed(
                                            FlashMode.auto)),
                                IconButton(
                                    icon: const Icon(Icons.flash_on),
                                    color: _cameraController.value.flashMode ==
                                            FlashMode.always
                                        ? style
                                            .Style.medicineDescriptionColorMain
                                        : style.Style.flashLightColor,
                                    onPressed: () =>
                                        onSetFlashModeButtonPressed(
                                            FlashMode.always)),
                                IconButton(
                                    icon: const Icon(Icons.highlight),
                                    color: _cameraController.value.flashMode ==
                                            FlashMode.torch
                                        ? style
                                            .Style.medicineDescriptionColorMain
                                        : style.Style.flashLightColor,
                                    onPressed: () =>
                                        onSetFlashModeButtonPressed(
                                            FlashMode.torch)),
                              ],
                            ),
                            widget.exitButton != null
                                ? IconButton(
                                    iconSize: 30,
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: Colors.transparent,
                                    size: 30,
                                  )
                          ],
                        ),
                      )
                    ],
                  );
                })
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                      'assets/images/camera toggle background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                  child:
                      CupertinoActivityIndicator(animating: true, radius: 20)),
            );
          }
        },
      ),
    );
  }
}
