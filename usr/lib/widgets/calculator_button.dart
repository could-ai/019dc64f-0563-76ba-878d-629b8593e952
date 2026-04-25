import 'package:flutter/material.dart';

enum ButtonType {
  number,
  operator,
  action,
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final ButtonType type;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.type = ButtonType.number,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case ButtonType.operator:
        backgroundColor = theme.colorScheme.primary;
        textColor = theme.colorScheme.onPrimary;
        break;
      case ButtonType.action:
        backgroundColor = theme.colorScheme.secondaryContainer;
        textColor = theme.colorScheme.onSecondaryContainer;
        break;
      case ButtonType.number:
      default:
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        textColor = theme.colorScheme.onSurface;
        break;
    }

    return Expanded(
      flex: isWide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            splashColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            highlightColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            child: Container(
              alignment: isWide ? Alignment.centerLeft : Alignment.center,
              padding: isWide ? const EdgeInsets.only(left: 32.0) : EdgeInsets.zero,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: type == ButtonType.operator ? FontWeight.w600 : FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
