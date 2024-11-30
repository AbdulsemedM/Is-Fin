import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MultipleRangeGaugeWidget extends StatelessWidget {
  final double value; // Value to point with the needle

  const MultipleRangeGaugeWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfRadialGauge(
        animationDuration: 3000,
        enableLoadingAnimation: true,
        // title: const GaugeTitle(
        //   text: 'Loan Status',
        //   textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: true,
            showTicks: true,
            axisLineStyle: const AxisLineStyle(
              thickness: 40,
            ),
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 20,
                color: Colors.red,
                startWidth: 30,
                endWidth: 30,
              ),
              GaugeRange(
                startValue: 20,
                endValue: 40,
                color: Colors.orange,
                startWidth: 30,
                endWidth: 30,
              ),
              GaugeRange(
                startValue: 40,
                endValue: 60,
                color: Colors.yellow,
                startWidth: 30,
                endWidth: 30,
              ),
              GaugeRange(
                startValue: 60,
                endValue: 80,
                color: Colors.lightGreen,
                startWidth: 30,
                endWidth: 30,
              ),
              GaugeRange(
                startValue: 80,
                endValue: 100,
                color: Colors.green,
                startWidth: 30,
                endWidth: 30,
              ),
            ],
            pointers: [
              NeedlePointer(
                value: value, // Dynamic needle value
                needleColor: Colors.black,
                enableDragging: true,
                needleLength: 0.8,
                needleStartWidth: 1,
                needleEndWidth: 5,
                knobStyle: const KnobStyle(
                  color: Colors.black,
                  borderColor: Colors.black,
                  borderWidth: 0.05,
                ),
              ),
            ],
            annotations: [
              GaugeAnnotation(
                widget: Text(
                  '${value.toStringAsFixed(1)}%', // Display the value dynamically
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                positionFactor: 0.7,
                angle: 90,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
