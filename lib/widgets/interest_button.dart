import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required String interest,
    required this.updateInterests,
  }) : _interest = interest;

  final String _interest;
  final Function updateInterests;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void onTapInterest() {
    setState(() {
      _isSelected = !_isSelected;
      widget.updateInterests(widget._interest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapInterest,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
              vertical: Sizes.size10,
            ),
            height: 300,
            decoration: BoxDecoration(
              color:
                  _isSelected ? Theme.of(context).primaryColor : Colors.white,
              border: _isSelected
                  ? null
                  : Border.all(
                      width: Sizes.size2,
                      color: Colors.grey.withOpacity(0.3),
                    ),
              borderRadius: BorderRadius.circular(Sizes.size20),
            ),
            child: Text(
              widget._interest,
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            top: Sizes.size10,
            right: Sizes.size14,
            child: FaIcon(
              FontAwesomeIcons.solidCircleCheck,
              color: _isSelected ? Colors.white : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
