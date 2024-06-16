import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/modalBottomSheet/report_screen.dart';
import 'package:flutter/material.dart';

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({super.key});

  void _onTapReport(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const ReportScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size24,
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: Sizes.size16),
                    child: Text(
                      'Unfollow',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: Sizes.size1,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: Sizes.size16),
                    child: Text(
                      'Mute',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: Sizes.size16),
                    child: Text(
                      'Hide',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: Sizes.size1,
                  ),
                  GestureDetector(
                    onTap: () => _onTapReport(context),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Sizes.size16),
                        child: Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
