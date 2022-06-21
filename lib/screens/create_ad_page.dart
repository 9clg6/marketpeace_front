import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/data/ad_manager.dart';
import 'package:market_peace/data/image_manager.dart';
import 'package:market_peace/data/secured_store_manager.dart';
import 'package:market_peace/exception/advertisement_exception.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CreateAdPage extends StatefulWidget {
  const CreateAdPage({Key? key}) : super(key: key);

  @override
  State<CreateAdPage> createState() => _CreateAdPageState();
}

class _CreateAdPageState extends State<CreateAdPage> {
  final _titleFormKey = GlobalKey<FormState>();
  final _descFormKey = GlobalKey<FormState>();
  final _priceFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  bool isTitleValid = false;
  bool isDescriptionValid = false;
  bool isPhotoValid = false;
  bool isPriceValid = false;
  int step = 1;

  String? pathImage;
  String? downloadUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: distinctiveColor,
          title: const Text(
            "Déposer une annonce",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStepProgressIndicator(),
                  buildTitleForm(),
                  buildDescForm(),
                  buildPriceForm(),
                  buildPhotoForm(),
                  buildBottomMarge(),
                ],
              ),
            ),
            buildNextBtn(),
          ],
        ),
      ),
    );
  }

  buildBottomMarge() => const SizedBox(height: 100);

  buildStepProgressIndicator() {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: StepProgressIndicator(
          totalSteps: 5,
          selectedColor: distinctiveColor,
          currentStep: step,
          progressDirection: TextDirection.ltr,
          unselectedColor: beige,
          size: 10,
          padding: 0,
        ),
      ),
    );
  }

  buildNextBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          if (!isTitleValid) {
            _titleFormKey.currentState!.validate();
          } else if (!isDescriptionValid) {
            _descFormKey.currentState!.validate();
          } else if(!isPriceValid) {
            _priceFormKey.currentState!.validate();
          } else if (isPhotoValid) {
            try {
              AdManager.saveAd(
                title: titleController.text,
                price: double.parse(priceController.text),
                description: descriptionController.text,
                imageUrl: downloadUrl ?? "",
              ).then((value) => context.router.pushNamed('/')).whenComplete(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Annonce créée !"),
                      content: const Text("Votre annonce a bien été créée !"),
                      actions: [
                        TextButton(
                          onPressed: () => context.router.pop(),
                          child: const Text("Super !"),
                        )
                      ],
                    );
                  },
                );
              });
            } on AdvertisementException catch (e){
              context.router.pushNamed('/login-page');
              Get.snackbar("Veuillez vous reconnecter", "Votre session a expiré, merci de vous reconnecter");
              SecuredStoreManager.clearSecuredStore();
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, -2),
                blurRadius: 2,
              )
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
            child: Container(
              alignment: Alignment.center,
              height: 35,
              decoration: BoxDecoration(
                color: distinctiveColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                isTitleValid && isDescriptionValid && isPriceValid && isPhotoValid? "Terminer" : "Continuer",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildTitleForm() {
    return Opacity(
      opacity: isTitleValid ? 0.3 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Text(
                "Commençons par l'essentiel",
                style: TextStyle(
                  color: distinctiveColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Flexible(
              child: Text(
                "Un titre précis et la bonne catégorie, c'est le meilleur moyen pour que vos futurs acheteurs voient votre annonce !",
                style: TextStyle(
                  color: distinctiveColor,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Form(
                key: _titleFormKey,
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return "Merci d'insérer un titre";
                    }
                    setState(() {
                      isTitleValid = true;
                      step++;
                    });
                    return null;
                  },
                  cursorColor: darkAccentuation,
                  enabled: !isTitleValid,
                  decoration: InputDecoration(
                    labelText: "Quel est le titre de votre annonce ?",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: darkAccentuation,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: darkAccentuation,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildDescForm() {
    return Visibility(
      visible: isTitleValid,
      child: Opacity(
        opacity: isDescriptionValid ? 0.3 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                child: Text(
                  "Décrivez votre produit !",
                  style: TextStyle(
                    color: distinctiveColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Flexible(
                child: Text(
                  "Mettez en valeur votre produit ! Plus il y a de détails, plus votre annonce sera de qualité. Détaillez ici ce qui a de l'importance et ajoutera de la valeur",
                  style: TextStyle(
                    color: distinctiveColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _descFormKey,
                child: TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return "Merci d'insérer une description";
                    }
                    setState(() {
                      isDescriptionValid = true;
                      step++;
                    });
                    return null;
                  },
                  cursorColor: darkAccentuation,
                  enabled: !isDescriptionValid,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    labelText: "Quelle est la description de votre annonce ?",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: darkAccentuation,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: darkAccentuation,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPriceForm() {
    return Visibility(
      visible: isDescriptionValid,
      child: Opacity(
        opacity: isPriceValid ? 0.3 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                child: Text(
                  "Quel est votre prix ?",
                  style: TextStyle(
                    color: distinctiveColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Flexible(
                child: Text(
                  "Vous le savez, le prix est important, autant pour vous que pour l'acheteur. Soyez juste, mais ayez en tête une marge de négociation si besoin",
                  style: TextStyle(
                    color: distinctiveColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _priceFormKey,
                child: TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return "Merci d'insérer un prix";
                    }
                    setState(() {
                      isPriceValid = true;
                      step++;
                    });
                    return null;
                  },
                  cursorColor: darkAccentuation,
                  enabled: !isPriceValid,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    labelText: "Votre prix de vente",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: darkAccentuation,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: darkAccentuation,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPhotoForm() {
    return Visibility(
      visible: isPriceValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Text(
                "Ajoutez une photo !",
                style: TextStyle(
                  color: distinctiveColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Flexible(
              child: Text(
                "Mettez en valeur votre produit ! Une bonne lumière, un bon cadrage vous permettront d'attirer l'oeil des acheteurs",
                style: TextStyle(
                  color: distinctiveColor,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.camera);

                      if (image != null) {
                        final ref = await ImageManager.sendImageToFirebaseStorage(File(image.path));
                        if (ref != null) {
                          downloadUrl = ref;

                          setState(() {
                            pathImage = image.path;
                            isPhotoValid = true;
                          });
                        }
                      }
                    },
                    child: buildPlaceHolder(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceHolder() {
    late Widget toReturn;

    if (pathImage == null) {
      toReturn = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: distinctiveColor,
          ),
        ),
        width: 100,
        height: 100,
        child: const Icon(
          Icons.add_a_photo,
          color: distinctiveColor,
        ),
      );
    } else {
      toReturn = Image.file(
        File(pathImage!),
        width: 300,
        height: 300,
      );
    }

    return toReturn;
  }
}
