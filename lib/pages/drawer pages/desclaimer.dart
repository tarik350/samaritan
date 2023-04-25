import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_samaritan/styles.dart' as styleClass;

class DesclaimerPage extends StatelessWidget {
  const DesclaimerPage({super.key});

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
            text: 'DISCLAIMER\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorPrimary)),
            text: 'WEBSITE DISCLAIMER\n'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                'The information provided by Samaritan ("we," "us," or "our") on our mobile application is for general informational purposes only. All information on our mobile application is provided in good faith, however we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy,validity, reliability, availability, or completeness of any information on our mobileapplication. UNDER NO CIRCUMSTANCE SHALL WE HAVE ANY LIABILITY TO YOUFOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OFOUR MOBILE APPLICATION OR RELIANCE ON ANY INFORMATION PROVIDED ONOUR MOBILE APPLICATION. YOUR USE OF OUR MOBILE APPLICATION AND YOURRELIANCE ON ANY INFORMATION ON OUR MOBILE APPLICATION IS SOLELY ATYOUR OWN RISK.'),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorSecondary)),
            text:
                '\nOur mobile application may contain (or you may be sent through our mobile application) links to otherwebsites or content belonging to or originating from third parties or links towebsites and features in banners or other advertising. Such external links arenot investigated, monitored, or checked for accuracy, adequacy, validity, reliability,availability, or completeness by us. WE DO NOT WARRANT, ENDORSE, GUARANTEE, ORASSUME RESPONSIBILITY FOR THE ACCURACY OR RELIABILITY OF ANY INFORMATIONOFFERED BY THIRD-PARTY WEBSITES LINKED THROUGH THE SITE OR ANY WEBSITE ORFEATURE LINKED IN ANY BANNER OR OTHER ADVERTISING. WE WILL NOT BE A PARTY TO ORIN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND THIRDPARTY PROVIDERS OF PRODUCTS OR SERVICES. '),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorPrimary)),
            text: '\nPROFESSIONAL DISCLAIMER\n '),
        TextSpan(
            style: GoogleFonts.raleway(
                textStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    color: styleClass.Style.medicineDescriptionColorPrimary)),
            text:
                'Do not rely on Samaritan to make decisions regarding medical care. Always speak to your health provider about the risks and benefits of FDA-regulated products. We may limit or otherwise restrict your access to the information provided by the API in line with our Terms of service this warning banner provides privacy and security notices consistent with applicable federal laws, directives, and other federal guidance for accessing this system, Unauthorized or improper use of this App is prohibited and may result in disciplinary action and/or civil and criminal penalties. Any communication or data transiting or stored on this system may be disclosed or used for any lawful Government purpose. THE USE OR RELIANCE OF ANY INFORMATION CONTAINED ON OUR MOBILE APPLICATION IS SOLELY AT YOUR OWN RISK.')
      ])),
    );
  }
}
