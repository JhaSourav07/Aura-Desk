import 'package:flutter/material.dart';
import 'dart:async'; // For the voice sim

// --- Main App Home Page ---
// This widget holds the bottom navigation bar and all the tabbed screens.
class MainHubScreen extends StatefulWidget {
  const MainHubScreen({Key? key}) : super(key: key);

  @override
  _MainHubScreenState createState() => _MainHubScreenState();
}

class _MainHubScreenState extends State<MainHubScreen> {
  int _currentIndex = 0;

  // All the screens are defined in this one file
  final List<Widget> _pages = [
    const DashboardScreen(),
    const LampControlScreen(),
    const FanControlScreen(),
    const PrinterScreen(),
    const AlarmScreen(),
  ];

  // --- Voice Assistant Modal ---
  // void _showVoiceAssistant() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: const Color(0xFF252A30),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       // We use a stateful builder to manage the state *inside* the sheet.
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setModalState) {
  //           String feedback = "Listening...";
  //           bool isListening = true;
  //
  //           // This simulates the visual flow
  //           void simulateFlow() async {
  //             // 1. "Listening..."
  //             await Future.delayed(const Duration(seconds: 2));
  //
  //             // 2. "Heard command"
  //             setModalState(() {
  //               isListening = false;
  //               feedback = "Okay, turning the lamp on.";
  //             });
  //
  //             // 3. Close the sheet
  //             await Future.delayed(const Duration(seconds: 2));
  //             if (mounted) {
  //               Navigator.of(context).pop();
  //             }
  //           }
  //
  //           // Start the simulation when the sheet opens
  //           if (isListening) {
  //             simulateFlow();
  //           }
  //
  //           return Container(
  //             padding: const EdgeInsets.all(24.0),
  //             height: 250,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(feedback,
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .headlineSmall
  //                         ?.copyWith(color: Colors.white)),
  //                 const SizedBox(height: 20),
  //                 if (isListening)
  //                   CircularProgressIndicator(
  //                     valueColor: AlwaysStoppedAnimation<Color>(
  //                         Theme.of(context).colorScheme.primary),
  //                   ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Darker background
      appBar: AppBar(
        title: const Text(
          "Aura Desk",
          style: TextStyle(
            color: Colors.white, // White text
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF252525), // Professional dark app bar
        elevation: 0,
        actions: [
          // Hard-coded status for prototype
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.bluetooth_connected,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.battery_charging_full,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Text(
                  " 85%", // Hard-coded value
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      // --- Floating Action Button for Voice ---
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showVoiceAssistant,
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   child: const Icon(Icons.mic, color: Colors.white),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // --- Bottom Nav Bar with a "notch" ---
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFF252525), // Matching dark surface
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(Icons.dashboard_outlined, "Dashboard", 0),
                  _buildNavItem(Icons.lightbulb_outline, "Lamp", 1),
                ],
              ),
              // Right side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(Icons.air_outlined, "Fan", 2),
                  _buildNavItem(Icons.print_outlined, "Printer", 3),
                  _buildNavItem(Icons.alarm_outlined, "Alarms", 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    double width = MediaQuery.of(context).size.width / 5.5;
    final bool isSelected = _currentIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey[400]; // Lighter grey for unselected

    return Container(
      width: width,
      child: MaterialButton(
        minWidth: 40,
        onPressed: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4), // Spacing
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 1: Dashboard Tab (NOW STATEFUL) ---
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // State variables for the toggles
  bool _isLampOn = true;
  bool _isFanOn = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          "Quick Controls",
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _DashboardControlTile(
              icon: Icons.lightbulb_outline,
              title: "Lamp",
              isOn: _isLampOn,
              onChanged: (val) => setState(() => _isLampOn = val),
            ),
            _DashboardControlTile(
              icon: Icons.air_outlined,
              title: "Fan",
              isOn: _isFanOn,
              onChanged: (val) => setState(() => _isFanOn = val),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "At a Glance",
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF252525), // Dark card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "STATUS",
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.bluetooth_connected,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Connected",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const Divider(height: 24, color: Color(0xFF424242)),
                Text(
                  "LAMP",
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                // Show state dynamically
                Text(
                  "Status: ${_isLampOn ? 'On' : 'Off'}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Brightness: 60%", // Hard-coded value
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  "Temp: Warm", // Hard-coded value
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const Divider(height: 24, color: Color(0xFF424242)),
                Text(
                  "FAN",
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                // Show state dynamically
                Text(
                  "Status: ${_isFanOn ? 'On' : 'Off'}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// --- Reusable Control Tile for Dashboard ---
class _DashboardControlTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const _DashboardControlTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isOn ? Colors.white : Colors.grey[400];
    return Card(
      color: const Color(0xFF252525),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isOn,
                  onChanged: onChanged,
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 2: Lamp Control Tab (NOW STATEFUL) ---
class LampControlScreen extends StatefulWidget {
  const LampControlScreen({Key? key}) : super(key: key);

  @override
  State<LampControlScreen> createState() => _LampControlScreenState();
}

class _LampControlScreenState extends State<LampControlScreen> {
  // State variables for lamp controls
  bool _isLampOn = true;
  double _brightness = 0.6;
  double _colorTemp = 0.4;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: const Color(0xFF252525),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      size: 32,
                      color: _isLampOn
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[400],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Lamp Control",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Switch(
                      value: _isLampOn,
                      onChanged: (val) {
                        setState(() {
                          _isLampOn = val;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFF424242)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Brightness",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    ),
                    Slider(
                      value: _brightness,
                      min: 0.0,
                      max: 1.0,
                      divisions: 100,
                      label: "${(_brightness * 100).toInt()}%",
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Colors.grey[600],
                      onChanged: (val) {
                        setState(() {
                          _brightness = val;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Color Temperature",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    ),
                    Slider(
                      value: _colorTemp,
                      min: 0.0,
                      max: 1.0,
                      divisions: 100,
                      label: _colorTemp < 0.5 ? "Warm" : "Cool",
                      activeColor: Colors.orange,
                      inactiveColor: Colors.lightBlue,
                      onChanged: (val) {
                        setState(() {
                          _colorTemp = val;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.orange[300],
                        ), // Warm
                        Icon(
                          Icons.ac_unit_outlined,
                          color: Colors.blue[200],
                        ), // Cool
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Screen 3: Fan Control Tab (NOW STATEFUL) ---
class FanControlScreen extends StatefulWidget {
  const FanControlScreen({Key? key}) : super(key: key);

  @override
  State<FanControlScreen> createState() => _FanControlScreenState();
}

class _FanControlScreenState extends State<FanControlScreen> {
  // State variables for fan controls
  bool _isFanOn = false;
  double _fanSpeed = 0.0; // 0.0 = Off, 0.5 = Medium, 1.0 = High

  String _getFanSpeedLabel(double speed) {
    if (speed == 0.0) return "Off";
    if (speed == 0.5) return "Medium";
    if (speed == 1.0) return "High";
    return "Off";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: const Color(0xFF252525),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.air,
                      size: 32,
                      color: _isFanOn
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[400],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Fan Control",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Switch(
                      value: _isFanOn,
                      onChanged: (val) {
                        setState(() {
                          _isFanOn = val;
                          if (!val) {
                            _fanSpeed = 0.0;
                          } else if (_fanSpeed == 0.0) {
                            _fanSpeed = 0.5;
                          }
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFF424242)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fan Speed",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    ),
                    Slider(
                      value: _fanSpeed,
                      min: 0.0,
                      max: 1.0,
                      divisions: 2, // Off, Medium, High
                      label: _getFanSpeedLabel(_fanSpeed),
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Colors.grey[600],
                      onChanged: (val) {
                        setState(() {
                          _fanSpeed = val;
                          if (val == 0.0) {
                            _isFanOn = false;
                          } else {
                            _isFanOn = true;
                          }
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Off", style: TextStyle(color: Colors.grey[400])),
                        Text(
                          "Medium",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text("High", style: TextStyle(color: Colors.grey[400])),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Screen 4: Printer Tab ---
class PrinterScreen extends StatefulWidget {
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _print() {
    // Just show a snackbar and clear text. No "backend" logic.
    _textController.clear();
    FocusScope.of(context).unfocus(); // Hide keyboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Sending note to printer... (Prototype)"),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: const Color(0xFF252525),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Print a Note",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _textController,
                  maxLines: 8,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Type a short to-do list or note...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _print,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Print",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// --- Screen 5: Alarms Tab (NOW STATEFUL) ---
class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

// A simple class to hold alarm data
class MockAlarm {
  String time;
  String repeat;
  bool isOn;
  MockAlarm(this.time, this.repeat, this.isOn);
}

class _AlarmScreenState extends State<AlarmScreen> {
  // Mock list of alarms
  final List<MockAlarm> _alarms = [
    MockAlarm("07:00 AM", "Weekdays", true),
    MockAlarm("09:30 AM", "Mon, Wed, Fri", true),
    MockAlarm("06:00 PM", "Saturday", false),
  ];

  // Mock method to show a time picker
  void _addAlarm(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      // Add to our list and update the UI
      setState(() {
        _alarms.add(MockAlarm(time.format(context), "Once", true));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Alarm set for ${time.format(context)}"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Inherit from MainHubScreen
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: const Color(0xFF252525),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Build the list from our state variable
                for (int i = 0; i < _alarms.length; i++)
                  Column(
                    children: [
                      SwitchListTile(
                        title: Text(
                          _alarms[i].time,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          _alarms[i].repeat,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        value: _alarms[i].isOn,
                        onChanged: (val) {
                          setState(() {
                            // Update the state of this specific alarm
                            _alarms[i].isOn = val;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                      if (i < _alarms.length - 1)
                        const Divider(
                          height: 1,
                          color: Color(0xFF424242),
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAlarm(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
