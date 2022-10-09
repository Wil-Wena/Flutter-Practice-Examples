import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProcessView(),
    );
  }
}

class ProcessView extends StatefulWidget {
  const ProcessView({Key? key}) : super(key: key);

  @override
  State<ProcessView> createState() => _ProcessViewState();
}

class _ProcessViewState extends State<ProcessView> {
  int currentStep = 0;
  bool horizontalOrientation = true;

  _firstStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  _continueStep() {
    currentStep < 2 ? setState(() => currentStep += 1) : null;
  }

  _cancelStep() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wilson Aballey'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SwitchListTile(
                hoverColor: Colors.blueAccent,
                activeTrackColor: Colors.purpleAccent,
                activeColor: Colors.purpleAccent,
                title: Text('Tap to select the stepper type you want'),
                subtitle: Text('Horizontal/Vertical'),
                value: horizontalOrientation,
                onChanged: (_) {
                  setState(() {
                    horizontalOrientation = !horizontalOrientation;
                  });
                }),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Expanded(
            child: Stepper(
                type: horizontalOrientation
                    ? StepperType.horizontal
                    : StepperType.vertical,
                physics: const ScrollPhysics(),
                currentStep: currentStep,
                onStepTapped: (step) => _firstStep(step),
                onStepCancel: _cancelStep,
                onStepContinue: _continueStep,
                steps: [
                  Step(
                    title: Text('Name'),
                    content: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(labelText: 'Enter your name'),
                        )
                      ],
                    ),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text('Email'),
                    content: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(labelText: 'Enter your email'),
                        )
                      ],
                    ),
                    isActive: currentStep > 0,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                      title: Text('Verify Email'),
                      content: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter verification Pin'),
                          )
                        ],
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.disabled)
                ]),
          )
        ],
      ),
    );
  }
}
