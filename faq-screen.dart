import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/data_layer/models/faq.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/widgets/social-icons-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../localizations.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<NewItem> items;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = buildItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: bgColor,
            title: Image.asset('assets/img/logo.png',
                fit: BoxFit.cover, height: 80),
            centerTitle: true,
            elevation: 0,
            leadingWidth: 120,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60, left: 60),
                      child: SocialIconsWidget(),
                    ),
                    Text(
                      AppLocalizations.of(context).faq,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ))),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    items[index].isExpanded = !items[index].isExpanded;
                  });
                },
                children: items.map((NewItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                          title: Text(
                        item.header,
//                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    },
                    isExpanded: item.isExpanded,
                    body: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 20, left: 20),
                        child: Text(item.body,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }

  buildItems() {
    List<NewItem> items = <NewItem>[];
    List<Faq> questionsAnswers = appConfigBloc.appConfig.faqArray;

    questionsAnswers.forEach((element) {
      items.add(NewItem(
          false, // isExpanded ?
          element.question, // header
          element.answer // body
          ));
    });
    return items;
  }
}

class NewItem {
  bool isExpanded;
  final String header;
  final String body;

  NewItem(this.isExpanded, this.header, this.body);
}
