import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loader.dart';
import '../../../constants/colors.dart';
import '../../../models/status_model.dart';
import '../controllers/status_controller.dart';
import './status_screen.dart';

class StatusContactsScreen extends ConsumerWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: snapshot.data!.length,
              (context, index) {
                var statusData = snapshot.data![index];
                return Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          StatusScreen.routeName,
                          arguments: statusData,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListTile(
                          title: Text(
                            statusData.username,
                          ),
                          leading: statusData.profilePic == ""
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/bot.png'),
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(statusData.profilePic),
                                  radius: 30,
                                ),
                        ),
                      ),
                    ),
                    const Divider(color: dividerColor, indent: 85),
                  ],
                );
              },
            )),
          ],
        );
      },
    );
  }
}
