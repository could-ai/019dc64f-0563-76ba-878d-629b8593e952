import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() => Text(
                          controller.expression.value,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(153), // ~60% opacity
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity != null && details.primaryVelocity != 0) {
                          controller.onDelete();
                        }
                      },
                      child: Obx(() {
                        // Dynamically adjust font size
                        double fontSize = 80;
                        int length = controller.display.value.length;
                        if (length > 6 && length <= 8) {
                          fontSize = 60;
                        } else if (length > 8) {
                          fontSize = 50;
                        }

                        return Text(
                          controller.display.value,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            
            // Keypad Area
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CalculatorButton(
                                text: 'AC',
                                type: ButtonType.action,
                                onTap: controller.onClear,
                              ),
                              CalculatorButton(
                                text: '+/-',
                                type: ButtonType.action,
                                onTap: controller.onToggleSign,
                              ),
                              CalculatorButton(
                                text: '%',
                                type: ButtonType.action,
                                onTap: controller.onPercentage,
                              ),
                              CalculatorButton(
                                text: '÷',
                                type: ButtonType.operator,
                                onTap: () => controller.onOperatorPressed('÷'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CalculatorButton(
                                text: '7',
                                onTap: () => controller.onNumberPressed('7'),
                              ),
                              CalculatorButton(
                                text: '8',
                                onTap: () => controller.onNumberPressed('8'),
                              ),
                              CalculatorButton(
                                text: '9',
                                onTap: () => controller.onNumberPressed('9'),
                              ),
                              CalculatorButton(
                                text: '×',
                                type: ButtonType.operator,
                                onTap: () => controller.onOperatorPressed('×'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CalculatorButton(
                                text: '4',
                                onTap: () => controller.onNumberPressed('4'),
                              ),
                              CalculatorButton(
                                text: '5',
                                onTap: () => controller.onNumberPressed('5'),
                              ),
                              CalculatorButton(
                                text: '6',
                                onTap: () => controller.onNumberPressed('6'),
                              ),
                              CalculatorButton(
                                text: '-',
                                type: ButtonType.operator,
                                onTap: () => controller.onOperatorPressed('-'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CalculatorButton(
                                text: '1',
                                onTap: () => controller.onNumberPressed('1'),
                              ),
                              CalculatorButton(
                                text: '2',
                                onTap: () => controller.onNumberPressed('2'),
                              ),
                              CalculatorButton(
                                text: '3',
                                onTap: () => controller.onNumberPressed('3'),
                              ),
                              CalculatorButton(
                                text: '+',
                                type: ButtonType.operator,
                                onTap: () => controller.onOperatorPressed('+'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CalculatorButton(
                                text: '0',
                                isWide: true,
                                onTap: () => controller.onNumberPressed('0'),
                              ),
                              CalculatorButton(
                                text: '.',
                                onTap: controller.onDecimal,
                              ),
                              CalculatorButton(
                                text: '=',
                                type: ButtonType.operator,
                                onTap: controller.calculate,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
