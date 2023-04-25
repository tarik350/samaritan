import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;

class PrivacyPolicyPgae extends StatelessWidget {
  const PrivacyPolicyPgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          )),
      body: RichText(
          text: TextSpan(children: [
        TextSpan(
            style: GoogleFonts.raleway(
              textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  color: styleClass.Style.medicineDescriptionColorMain),
              fontSize: 30,
            ),
            text: 'Privacy Policy\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorPrimary)),
            text: 'Last updated October 17, 2022\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "This privacy notice for Samaritan (Company, we, us, or our), describes how and why we might collect, store, use, and/or share (process) your information when you use our services (Services), such as when you"),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "\n > Download and use our mobile application (Samaritan), or any other application of ours that links to this privacy notice  \n >Engage with us in other related ways, including any sales, marketing, or events \n"),
        TextSpan(
            style: GoogleFonts.raleway(
              textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  color: styleClass.Style.medicineDescriptionColorSecondary),
              fontSize: 15,
            ),
            text: "Questions or concerns?"),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "Reading this privacy notice will help you understand your privacy rights and choices. If you do not agree with our policies and practices, please do not use our Services. If you still have any questions or concerns, please contact us at contactolyad@gmail.com."),
        TextSpan(
            style: GoogleFonts.raleway(
              textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  color: styleClass.Style.medicineDescriptionColorMain),
              fontSize: 25,
            ),
            text: '\n SUMMARY OF KEY POINTS\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "\n This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for. You can also click here to go directly to our table of contents."),
        TextSpan(
            style: GoogleFonts.raleway(
              textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  color: styleClass.Style.medicineDescriptionColorSecondary),
              fontSize: 15,
            ),
            text: " \n What personal information do we process?"),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "When you visit, use, or navigate our Services, we may process personal information depending on how you interact with Samaritan and the Services, the choices you make, and the products and features you use."),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                "\n Do we process any sensitive personal information? We do not process sensitive personal information. \n Do we receive any information from third parties? We do not receive any information from third parties.\n"),
        TextSpan(
            style: GoogleFonts.raleway(
              textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  color: styleClass.Style.medicineDescriptionColorMain),
              fontSize: 25,
            ),
            text: '\n 1. WHAT INFORMATION DO WE COLLECT?\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                " Personal information you disclose to us In Short:We collect personal information that you provide to us.We collect personal information that you voluntarily provide to us when youexpressan interest in obtaining information about us or our products and Services, when youparticipate in activities on the Services, or otherwise when you contact us.Sensitive Information.We do not process sensitive information.Application Data.If you use our application(s), we also may collect the followinginformation if you choose to provide us with access or permission:"),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: "Personal informations"),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text: ""),
      ])),
    );
  }
}
