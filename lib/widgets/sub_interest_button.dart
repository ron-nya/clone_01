import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubInterestButton extends StatefulWidget {
  const SubInterestButton({
    super.key,
    required String interest,
    required this.updateInterests,
  }) : _interest = interest;

  final String _interest;
  final Function updateInterests;

  @override
  State<SubInterestButton> createState() => _SubInterestButtonState();
}

class _SubInterestButtonState extends State<SubInterestButton> {
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
      child: Container(
        width: 100,
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size3, vertical: Sizes.size2),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
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
    );
  }
}
