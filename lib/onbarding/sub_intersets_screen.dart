import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/widgets/sub_interest_button.dart';
import 'package:authentication/widgets/twitter_appbar.dart';
import 'package:flutter/material.dart';

class SubIntersetsScreen extends StatefulWidget {
  final List<String> selectedInterest;
  const SubIntersetsScreen({super.key, required this.selectedInterest});

  @override
  State<SubIntersetsScreen> createState() => _SubIntersetsScreenState();
}

class _SubIntersetsScreenState extends State<SubIntersetsScreen> {
  late Map<String, List<String>> _subInerests;
  late List<String> _selectedSubInterests;

  void _updateSelectedInterests(String interest) {
    setState(() {
      if (_selectedSubInterests.contains(interest)) {
        _selectedSubInterests.remove(interest);
      } else {
        _selectedSubInterests.add(interest);
      }
    });
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    _subInerests = <String, List<String>>{};
    for (int i = 65; i <= 90; i++) {
      var key = (String.fromCharCode(i));
      List<String> values = [];
      for (int i = 0; i < 50; i++) {
        var value = "$key-$i";
        values.add(value);
      }
      _subInerests[key] = values;
    }

    _selectedSubInterests = [];

    super.initState();
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
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.selectedInterest.length,
                      itemBuilder: (context, index) {
                        final interest = widget.selectedInterest[index];
                        final subInterestList = _subInerests[interest];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: Sizes.size24,
                            bottom: Sizes.size10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                interest,
                                style: const TextStyle(
                                  fontSize: Sizes.size24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width * 3,
                                  child: Wrap(
                                    runSpacing: Sizes.size20,
                                    spacing: Sizes.size10,
                                    children: [
                                      if (subInterestList != null)
                                        for (var si in subInterestList)
                                          SizedBox(
                                            width: 100,
                                            height: 40,
                                            child: SubInterestButton(
                                              interest: si,
                                              updateInterests:
                                                  _updateSelectedInterests,
                                            ),
                                          )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
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
              _selectedSubInterests.length < 3
                  ? Text('${_selectedSubInterests.length} / 3 selected')
                  : const Text('Great work!'),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: _selectedSubInterests.length < 3
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
