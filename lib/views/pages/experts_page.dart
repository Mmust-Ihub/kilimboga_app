import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/single_expert_page.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ExpertsPage extends StatelessWidget {
  const ExpertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Row(
              children: [
                Text(
                  "Experts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height:10),
            Expanded(
              child: LazyLoadScrollView(
                onEndOfPage: () {},
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SingleExpertPage()));
                          },
                          leading: Image.asset(
                            "assets/images/doctor.webp",
                          ),
                          title: Text(
                            "Expert Name",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            size: 20,
                          ),
                        ),
                    separatorBuilder: (context, index) => Divider(
                          thickness: 0.7,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                    itemCount: 20),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
