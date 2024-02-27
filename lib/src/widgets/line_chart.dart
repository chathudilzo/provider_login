import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weeklyData =
        Provider.of<UserProvider>(context).calculateWeeklyIncomeAndExpenses();

    return LineChart(
      isShowingMainData
          ? generateWeeklyData(weeklyData)
          : sampleData2, // Use your existing sampleData2 for other cases
      //duration: const Duration(milliseconds: 250),
    );
  }
  LineChartData get sampleData2 => LineChartData(
  lineTouchData: LineTouchData(
    enabled: false,
  ),
  gridData: FlGridData(show: false),
  // titlesData: FlTitlesData(
  //   bottomTitles: AxisTitles(
  //     showTitles: true,
  //     interval: 1,
  //     getTitles: (value) {
  //       return value.toInt().toString();
  //     },
  //   ),
  //   leftTitles: AxisTitles(
  //     showTitles: true,
  //     interval: 1,
  //     getTitles: (value) {
  //       return value.toInt().toString();
  //     },
  //   ),
  // ),
  borderData: FlBorderData(
    show: true,
    border: Border.all(
      color: Colors.grey,
      width: 0.5,
    ),
  ),
  lineBarsData: [
    LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      colors: [Colors.blue.withOpacity(0.5)],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        FlSpot(0, 3),
        FlSpot(1, 4),
        FlSpot(2, 2),
        FlSpot(3, 6),
        FlSpot(4, 8),
        FlSpot(5, 5),
        FlSpot(6, 7),
      ],
    ),
    LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      colors: [Colors.red.withOpacity(0.5)],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        FlSpot(0, 6),
        FlSpot(1, 7),
        FlSpot(2, 5),
        FlSpot(3, 3),
        FlSpot(4, 2),
        FlSpot(5, 4),
        FlSpot(6, 3),
      ],
    ),
  ],
  minX: 0,
  maxX: 6,
  maxY: 10,
  minY: 0,
);


  LineChartData generateWeeklyData(List<Map<String, dynamic>> weeklyData) {
    List<FlSpot> incomeSpots = [];
    List<FlSpot> expenseSpots = [];

    for (int i = 0; i < weeklyData.length; i++) {
      DateTime currentDate = weeklyData[i]['date'];
      double income = weeklyData[i]['income'];
      double expense = weeklyData[i]['expense'];

      incomeSpots.add(FlSpot(i.toDouble(), income));
      expenseSpots.add(FlSpot(i.toDouble(), expense));
    }

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: incomeSpots,
          isCurved: true,
          colors: [Colors.green],
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
          dotData: FlDotData(show: false),
        ),
        LineChartBarData(
          spots: expenseSpots,
          isCurved: true,
          colors: [Colors.red],
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
          dotData: FlDotData(show: false),
        ),
      ],
      // titlesData: FlTitlesData(
      //   bottomTitles: AxisTitles(
      //     showTitles: true,
      //     interval: 1,
      //     getTitles: (value) {
      //       return DateFormat('MMM d').format(
      //         weeklyData[value.toInt()]['date'],
      //       );
      //     },
      //   ),
      //   leftTitles: AxisTitles(
      //     showTitles: true,
      //     interval: 1,
      //     getTitles: (value) {
      //       return value.toInt().toString(); // You may adjust based on your data
      //     },
      //   ),
      // ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      ),
    );
  }
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Weekly Income and Expenses',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}
