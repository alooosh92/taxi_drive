import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/about_us/widget/row_icons.dart';
import 'package:taxi_drive/widget/drawer_home.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined))
        ],
        title: const Text(
          "من نحن",
          style: FontManager.w600s24cB,
        ),
        centerTitle: true,
      ),
      drawer: DrawerHome(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'lib/asset/images/about1.png',
                width: MediaQuery.sizeOf(context).height / 2,
                height: MediaQuery.sizeOf(context).height / 3,
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مرحبًا بك في شركة ARG Group Co.، كشركة رائدة في مجال تطوير البرمجيات ملتزمة بتقديم حلول مبتكرة وعالية الجودة للشركات في جميع أنحاء العالم',
                        style: FontManager.w400s17cB,
                      ),
                      Text(
                        'تأسست ARG في إسطنبول، تركيا في عام 2019',
                        style: FontManager.w400s17cB,
                      ),
                      Text(
                        'حيث كانت مهمتنا الرئيسية في ARG Group Co. هي تمكين الشركات باستخدام أحدث التكنولوجيا وتقديم حلول برمجية استثنائية',
                        style: FontManager.w400s17cB,
                      ),
                      Text(
                        '.نسعى لتحويل الأفكار إلى واقع، مما يمكن عملائنا من البقاء في المقدمة في المشهد الرقمي الدينامكيي الحالي',
                        style: FontManager.w400s17cB,
                      ),
                      Text(
                        'تقدم ARG  مجموعة  من التطبيقات والمواقع التي تهدف لتلبية احتياجات عملائها المتنوعة من ضمنها تطبيق تكسي الذي يجسد رؤيتنا في تحسين تجربة التنقل, يتيح تطبيقنا للمستخدمين الاستمتاع بتجربة ركوب سهلة وآمنة، حيث يوفر أحدث التقنيات في عالم التطبيقات الذكية يمتاز تطبيق تكسي بواجهة مستخدم سهلة الاستخدام وخدمات فعالة تلبي احتياجات العملاء بكل كفاءة',
                        style: FontManager.w400s17cB,
                      ),
                      Text(
                        'للتواصل معنا عبر مواقعنا او الاتصال ',
                        style: FontManager.w400s17cB,
                      ),
                    ]),
              ),
            ),
          ),
          const RowIcon(),
        ],
      ),
    );
  }
}
