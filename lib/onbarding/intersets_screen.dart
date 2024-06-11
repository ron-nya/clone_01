import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/onbarding/sub_intersets_screen.dart';
import 'package:authentication/widgets/interest_button.dart';
import 'package:authentication/widgets/twitter_appbar.dart';
import 'package:flutter/material.dart';

class IntersetsScreen extends StatefulWidget {
  const IntersetsScreen({super.key});

  @override
  State<IntersetsScreen> createState() => _IntersetsScreenState();
}

class _IntersetsScreenState extends State<IntersetsScreen> {
  late List<String> _interests;
  late List<String> _selectedInterests;

  void _updateSelectedInterests(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  void _onPressedNextButton() {
    if (_selectedInterests.length < 3) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SubIntersetsScreen(
        selectedInterest: _selectedInterests,
      ),
    ));
  }

  @override
  void initState() {
    _interests = [];
    _selectedInterests = [];
    for (int i = 65; i <= 90; i++) {
      _interests.add(String.fromCharCode(i));
    }
    super.initState();
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapScaffold,
      child: Scaffold(
        appBar: const TwitterAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: Sizes.size36,
                right: Sizes.size36,
                top: Sizes.size36,
                bottom: Sizes.size12),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you want to see on Twitter?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v10,
                  Text(
                    'Select at leat 3 interests to personalize your Twitter experience. They will be visible on your profile',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Gaps.v20,
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      color: Colors.grey,
                      height: Sizes.size1,
                    ),
                  ),
                  Gaps.v20,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _interests.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: Sizes.size10,
                      crossAxisSpacing: Sizes.size10,
                    ),
                    itemBuilder: (context, index) {
                      return InterestButton(
                        interest: _interests[index],
                        updateInterests: _updateSelectedInterests,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.1,
          color: Colors.white,
          shadowColor: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedInterests.length < 3
                  ? Text('${_selectedInterests.length} / 3 selected')
                  : const Text('Great work!'),
              TextButton(
                onPressed: _onPressedNextButton,
                style: TextButton.styleFrom(
                  backgroundColor: _selectedInterests.length < 3
                      ? Colors.grey
                      : Colors.black,
                ),
                child: const Text(
                  'next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
