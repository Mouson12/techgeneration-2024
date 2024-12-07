import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/constants/sizes.dart';
import 'package:flutter_podium/flutter_podium.dart';
import 'package:office_app/config/l10n/extensions.dart';
import 'package:office_app/features/application/users/cubit/ranking_cubit.dart';
import 'package:office_app/features/application/users/models/user.dart';
import 'package:office_app/features/application/users/models/user_ranking.dart';
import 'package:office_app/features/ranking/person_tile.dart';
import 'package:office_app/features/ranking/podium_title.dart';

class RankingPage extends HookWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: 3);
    final index = useState(0);

    controller.addListener(
      () {
        if (index.value != controller.index) {
          index.value = controller.index;
        }
      },
    );

    UserRanking? getState(RankingCubitState state) {
      if (state is RankingCubitLoaded) {
        return state.ranking;
      }
      return null;
    }

    if (index.value == 0) {
      context.read<RankingCubit>().fetchRanking(2);
    } else if (index.value == 1) {
      context.read<RankingCubit>().fetchRanking(3);
    } else if (index.value == 2) {
      context.read<RankingCubit>().fetchRanking(4);
    }
    return Scaffold(
      backgroundColor: AUColors.mainGreen,
      body: BlocBuilder<RankingCubit, RankingCubitState>(
        builder: (context, state) {
          final currentState = getState(state);
          return Padding(
            padding: AUSizes.mainPadding,
            child: Stack(
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Leaderboard",
                        style: TextStyle(
                          color: AUColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 13.h),
                    SizedBox(
                      width: 220.w,
                      child: SegmentedTabControl(
                        controller: controller,
                        backgroundColor: AUColors.lightGreen,
                        tabs: [
                          SegmentTab(
                            label: context.text.februaryShort,
                            selectedTextColor: AUColors.mainGreen,
                            textColor: AUColors.white,
                          ),
                          SegmentTab(
                            label: context.text.marchShort,
                            selectedTextColor: AUColors.mainGreen,
                          ),
                          SegmentTab(
                            label: context.text.aprilShort,
                            selectedTextColor: AUColors.mainGreen,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    if (state is RankingCubitLoaded &&
                        currentState!.users.length > 2)
                      Podium(
                        firstPosition: PodiumTile(
                            name: currentState.users[0].name,
                            points: currentState.users[0].points),
                        secondPosition: PodiumTile(
                            name: currentState.users[1].name,
                            points: currentState.users[1].points),
                        thirdPosition: PodiumTile(
                            name: currentState.users[2].name,
                            points: currentState.users[2].points),
                        showRankingNumberInsteadOfText: true,
                        color: AUColors.lightGreen,
                        rankingTextColor: AUColors.white,
                        rankingFontSize: 30.sp,
                        height: 120.h,
                        width: 70.w,
                      ),
                  ],
                ),
                state is RankingCubitLoaded
                    ? buildBottomModal(currentState!.users)
                    : buildCircularProgress(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCircularProgress() {
    return Center(
      child: Container(
        height: 110,
        width: 200,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildBottomModal(List<User> users) {
    return users.length == 0
        ? SizedBox()
        : DraggableScrollableSheet(
            maxChildSize: 0.8,
            minChildSize: 0.5,
            initialChildSize: 0.5,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AUColors.dirtyWhite,
                  ),
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      for (int i = 0; i < users.length; i++)
                        PersonTile(
                            position: i + 1,
                            name: users[i].name,
                            points: users[i].points)
                    ],
                  ),
                ),
              );
            },
          );
  }
}
