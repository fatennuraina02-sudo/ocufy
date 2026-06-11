import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const PomodoroApp());

const Color darkBg = Color(0xff1d1b55);
const Color cardBg = Color(0xff5a548c);
const Color accent = Color(0xff00d0ad);
const Color inputColor = Color(0xffeee9ff);
const Color softLabel = Color(0xffaab7d8);

String loggedEmail = '';
String profileName = '';
String savedPassword = '';
String selectedLanguage = 'English';

bool isDarkMode = true;
bool reminderOn = true;
bool messageOn = true;
bool pointsOn = true;

int userPoints = 6700;
int accumulatedMinutes = 0;

final ValueNotifier<int> themeNotifier = ValueNotifier<int>(0);

Color get appBg => isDarkMode ? darkBg : Colors.white;
Color get appCard => isDarkMode ? cardBg : const Color(0xffded8f4);
Color get appText => isDarkMode ? inputColor : darkBg;
Color get appPanel => isDarkMode ? inputColor : const Color(0xfff7f2ff);
Color get appBottomNav => isDarkMode ? cardBg : const Color(0xffe6defa);

// APP ROOT

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ocufy Pomodoro',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const LoginStartPage(),
    );
  }
}

// LOGIN START PAGE

class LoginStartPage extends StatelessWidget {
  const LoginStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      showBack: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 118),

          const SizedBox(height: 35),

          Text(
            'Ready to target\nyour focus',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 95),

          GreenButton(
            text: 'Login',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterPage(),
                ),
              );
            },
            child: Text(
              "Doesn't have an account? Sign Up",
              style: TextStyle(
                color: isDarkMode ? Colors.white : darkBg,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// LOGIN PAGE

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  void login() {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password.'),
        ),
      );
      return;
    }

    loggedEmail = email.text.trim();
    profileName = loggedEmail.split('@').first;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 115),

          const SizedBox(height: 62),

          AuthInput(
            controller: email,
            hint: 'Email',
          ),

          AuthInput(
            controller: password,
            hint: 'Password',
            obscure: true,
          ),

          const SizedBox(height: 12),

          GreenButton(
            text: 'Log In',
            onTap: login,
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterPage(),
                ),
              );
            },
            child: Text(
              "Don't have an account? Sign Up",
              style: TextStyle(
                color: isDarkMode ? Colors.white : darkBg,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Forgot password?',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// REGISTER PAGE

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  void register() {
    if (email.text.isEmpty || password.text.isEmpty || confirm.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all information.'),
        ),
      );
      return;
    }

    if (password.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password tidak sama'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 115),

          const SizedBox(height: 55),

          AuthInput(
            controller: email,
            hint: 'Email',
          ),

          AuthInput(
            controller: password,
            hint: 'Password',
            obscure: true,
          ),

          AuthInput(
            controller: confirm,
            hint: 'Confirm Password',
            obscure: true,
          ),

          const SizedBox(height: 12),

          GreenButton(
            text: 'Register',
            onTap: register,
          ),
        ],
      ),
    );
  }
}

// SUCCESS PAGES

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginPage(),
            ),
          );
        }
      },
    );

    return const SuccessPage(
      text: 'REGISTRATION\nSUCCESSFUL',
    );
  }
}

class LoginSuccessPage extends StatelessWidget {
  const LoginSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MainPage(),
            ),
          );
        }
      },
    );

    return const SuccessPage(
      text: 'LOG IN\nSUCCESSFUL',
    );
  }
}

class LogoutSuccessPage extends StatelessWidget {
  const LogoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginPage(),
            ),
          );
        }
      },
    );

    return const SuccessPage(
      text: 'LOG OUT\nSUCCESSFUL',
    );
  }
}
// MAIN PAGE

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: themeNotifier,
      builder: (context, _, __) {
        final pages = [
          const HomePage(),
          const ChartPage(),
          FocusPage(onPointAdded: refresh),
          const ReminderPage(),
          AccountPage(onChanged: refresh),
        ];

        return Scaffold(
          backgroundColor: appBg,
          body: SafeArea(
            child: pages[index],
          ),
          bottomNavigationBar: CustomNav(
            selectedIndex: index,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
          ),
        );
      },
    );
  }
}

// HOME PAGE

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> streak = List.generate(7, (_) => false);

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: 'Home',
      child: Column(
        children: [
          ShadowPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Point:',
                  style: TextStyle(
                    color: appText,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: appPanel,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    userPoints.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: accent,
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      height: .95,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          ShadowPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent:',
                  style: TextStyle(
                    color: appText,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: appPanel,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      HomeLapRow(
                        lap: 'Lap 1',
                        time: '50m',
                        detail1: '20m exercise (2)',
                        detail2: '5m rest (2)',
                      ),

                      Divider(color: Colors.grey, thickness: 0.5),

                      HomeLapRow(
                        lap: 'Lap 2',
                        time: '1h10m',
                        detail1: '30m exercise (2)',
                        detail2: '10m rest (1)',
                      ),

                      Divider(color: Colors.grey, thickness: 0.5),

                      HomeLapRow(
                        lap: 'Lap 3',
                        time: '1h30m',
                        detail1: '25m exercise (3)',
                        detail2: '5m rest (3)',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Streak',
            style: TextStyle(
              color: accent,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: appCard,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                streak.length,
                    (i) => GestureDetector(
                  onTap: () {
                    setState(() {
                      streak[i] = !streak[i];
                    });
                  },
                  child: Icon(
                    Icons.local_fire_department,
                    size: 36,
                    color: streak[i] ? Colors.orange : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeLapRow extends StatelessWidget {
  final String lap;
  final String time;
  final String detail1;
  final String detail2;

  const HomeLapRow({
    super.key,
    required this.lap,
    required this.time,
    required this.detail1,
    required this.detail2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lap,
                style: const TextStyle(
                  color: darkBg,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              Text(
                time,
                style: const TextStyle(
                  color: accent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '$detail1\n$detail2',
              style: const TextStyle(
                color: darkBg,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// CHART PAGE

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: 'Chart',
      child: Center(
        child: Container(
          width: 310,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: appCard,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 285,
                padding: const EdgeInsets.fromLTRB(10, 13, 10, 10),
                decoration: BoxDecoration(
                  color: appPanel,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(250, 250),
                          painter: DonutChartPainter(),
                        ),

                        const Positioned(
                          left: 10,
                          top: 40,
                          child: ChartLabel(text: 'EXERCISE'),
                        ),

                        const Positioned(
                          left: 20,
                          top: 105,
                          child: Text(
                            '30%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const Positioned(
                          right: 40,
                          top: 50,
                          child: Text(
                            '40%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const Positioned(
                          left: 110,
                          bottom: 20,
                          child: Text(
                            '20%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const Positioned(
                          right: 20,
                          bottom: 115,
                          child: ChartLabel(text: 'STUDY'),
                        ),

                        const Positioned(
                          left: 5,
                          bottom: 60,
                          child: ChartLabel(text: 'MEDITATION'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.fromLTRB(35, 40, 20, 20),
                decoration: BoxDecoration(
                  color: appPanel,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressPill(
                      text: 'STUDY',
                      width: 175,
                      color: cardBg,
                    ),

                    ProgressPill(
                      text: 'EXERCISE',
                      width: 135,
                      color: darkBg,
                    ),

                    ProgressPill(
                      text: 'MEDITATION',
                      width: 100,
                      color: accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 62.0;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = (size.width - stroke) / 2;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    // STUDY - 40%
    paint.color = cardBg;
    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 0.80,
      false,
      paint,
    );

    // MEDITATION - 20%
    paint.color = accent;
    canvas.drawArc(
      rect,
      -math.pi / 2 + math.pi * 0.80,
      math.pi * 0.40,
      false,
      paint,
    );

    // EXERCISE - 30%
    paint.color = darkBg;
    canvas.drawArc(
      rect,
      -math.pi / 2 + math.pi * 1.20,
      math.pi * 0.60,
      false,
      paint,
    );

    // Center hole
    final hole = Paint()
      ..style = PaintingStyle.fill
      ..color = appPanel;

    canvas.drawCircle(
      center,
      63,
      hole,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ChartLabel extends StatelessWidget {
  final String text;

  const ChartLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMeditation = text == 'MEDITATION';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isMeditation ? accent.withOpacity(0.3) : softLabel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isMeditation ? accent : darkBg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class ProgressPill extends StatelessWidget {
  final String text;
  final double width;
  final Color color;

  const ProgressPill({
    super.key,
    required this.text,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(left: 14),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
// FOCUS PAGE

class FocusPage extends StatefulWidget {
  final VoidCallback onPointAdded;

  const FocusPage({
    super.key,
    required this.onPointAdded,
  });

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int totalSeconds = 25 * 60;
  int seconds = 25 * 60;

  Timer? timer;

  final minute = TextEditingController(text: '25');

  bool isRunning = false;

  void setTime() {
    final min = int.tryParse(minute.text.trim());

    if (min == null || min <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the correct time.'),
        ),
      );
      return;
    }

    timer?.cancel();

    setState(() {
      totalSeconds = min * 60;
      seconds = totalSeconds;
      isRunning = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Timer set to $min minute'),
      ),
    );
  }

  void start() {
    if (isRunning) return;

    if (seconds <= 0) {
      setTime();
    }

    setState(() {
      isRunning = true;
    });

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          timer?.cancel();

          final completedMinutes = totalSeconds ~/ 60;

          accumulatedMinutes += completedMinutes;

          while (accumulatedMinutes >= 60) {
            userPoints += 1;
            accumulatedMinutes -= 60;
          }

          setState(() {
            isRunning = false;
          });

          widget.onPointAdded();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Focus complete! Points updated.'),
              ),
            );
          }
        }
      },
    );
  }

  void pause() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void restart() {
    timer?.cancel();

    setState(() {
      seconds = totalSeconds;
      isRunning = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    minute.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');

    return PagePad(
      title: "Let’s Focus",
      titleSize: 34,
      child: Column(
        children: [
          const SizedBox(height: 45),

          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accent,
                width: 44,
              ),
            ),
            child: Center(
              child: Text(
                '$m:$s',
                style: const TextStyle(
                  color: inputColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 38),

          Container(
            height: 35,
            width: 155,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: appCard,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userPoints.toString().padLeft(4, '0'),
                  style: TextStyle(
                    color: appText,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'Points',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : darkBg,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: 175,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: appCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                TextField(
                  controller: minute,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : darkBg,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Set minit',
                    hintStyle: TextStyle(
                      color: isDarkMode ? Colors.white54 : Colors.black45,
                    ),
                    border: InputBorder.none,
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 34,
                  child: GreenButton(
                    text: 'Set Time',
                    onTap: setTime,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FocusCircleButton(
                icon: isRunning ? Icons.pause : Icons.play_arrow,
                isStart: true,
                color: isRunning ? const Color(0xfff15b2a) : accent,
                onTap: isRunning ? pause : start,
              ),

              FocusCircleButton(
                icon: Icons.refresh,
                isStart: false,
                onTap: restart,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FocusCircleButton extends StatelessWidget {
  final IconData icon;
  final bool isStart;
  final VoidCallback onTap;
  final Color? color;

  const FocusCircleButton({
    super.key,
    required this.icon,
    required this.isStart,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(44),
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: color ?? (isStart ? accent : appPanel),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 42,
          color: isStart ? appPanel : darkBg,
        ),
      ),
    );
  }
}
// REMINDER PAGE

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  void _prevMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysInMonth(_focusedDate);

    return PagePad(
      title: 'Reminder',
      titleSize: 34,
      child: ShadowPanel(
        padding: const EdgeInsets.all(17),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 12),
          decoration: BoxDecoration(
            color: appPanel,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _prevMonth,
                    icon: const Icon(Icons.chevron_left, color: darkBg),
                  ),
                  Expanded(
                    child: Text(
                      _months[_focusedDate.month - 1],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: darkBg,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(Icons.chevron_right, color: darkBg),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  days,
                      (i) {
                    final day = i + 1;
                    final isSelected = _selectedDate.year == _focusedDate.year &&
                        _selectedDate.month == _focusedDate.month &&
                        _selectedDate.day == day;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime(
                            _focusedDate.year,
                            _focusedDate.month,
                            day,
                          );
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: isSelected ? accent : appCard,
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDarkMode ? Colors.white : darkBg),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 45),

              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                height: 115,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: darkBg,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: 90,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      width: 55,
                      height: 8,
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: 70,
                      height: 8,
                      decoration: BoxDecoration(
                        color: inputColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              GreenButton(
                text: 'Add Reminder',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReminderInputPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// REMINDER INPUT PAGE

class ReminderInputPage extends StatefulWidget {
  const ReminderInputPage({super.key});

  @override
  State<ReminderInputPage> createState() => _ReminderInputPageState();
}

class _ReminderInputPageState extends State<ReminderInputPage> {
  final event = TextEditingController();
  final date = TextEditingController();

  void setReminder() {
    if (event.text.isEmpty || date.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the event and date'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminder saved'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'Your\nReminder',
      child: Column(
        children: [
          const Text(
            'Event',
            style: TextStyle(
              color: accent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),

          const SizedBox(height: 25),

          AuthInput(
            controller: event,
            hint: 'Event',
          ),

          AuthInput(
            controller: date,
            hint: 'Date',
          ),

          const SizedBox(height: 35),

          GreenButton(
            text: 'Set',
            onTap: setReminder,
          ),
        ],
      ),
    );
  }
}
// ACCOUNT PAGE

class AccountPage extends StatelessWidget {
  final VoidCallback onChanged;

  const AccountPage({
    super.key,
    required this.onChanged,
  });

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LogoutSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: '',
      child: Column(
        children: [
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: inputColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              const CircleAvatar(
                radius: 68,
                backgroundColor: Colors.white70,
              ),

              const SizedBox(width: 25),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileName.isEmpty ? 'Your Name' : profileName,
                    style: const TextStyle(
                      color: accent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '$userPoints points',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    loggedEmail.isEmpty ? 'Email' : loggedEmail,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(
              color: inputColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const SizedBox(height: 25),

          MenuTile(
            icon: Icons.stars_outlined,
            text: 'Redeem',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RedeemPage(),
                ),
              );
            },
          ),

          MenuTile(
            icon: Icons.hexagon_outlined,
            text: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsDetailPage(),
                ),
              );
            },
          ),

          MenuTile(
            icon: Icons.person_search_outlined,
            text: 'Edit Profile',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfilePage(),
                ),
              );

              onChanged();
            },
          ),

          MenuTile(
            icon: Icons.campaign_outlined,
            text: 'Report Bug',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReportBugPage(),
                ),
              );
            },
          ),

          MenuTile(
            icon: Icons.info_outline,
            text: 'About',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GreenButton(
              text: 'Log Out',
              onTap: () => logout(context),
            ),
          ),
        ],
      ),
    );
  }
}

// REDEEM PAGE

class RedeemPage extends StatelessWidget {
  const RedeemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      backIcon: Icons.reply,
      topWidget: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: inputColor,
            width: 8,
          ),
        ),
        child: const Icon(
          Icons.stars,
          color: inputColor,
          size: 80,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Redeem\nShop',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accent,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: appPanel,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                RedeemItem(
                  name: 'Product 1',
                  point: '1000',
                ),

                RedeemItem(
                  name: 'Product 2',
                  point: '2000',
                ),

                RedeemItem(
                  name: 'Product 3',
                  point: '3500',
                ),

                RedeemItem(
                  name: 'Product 4',
                  point: '5000',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RedeemItem extends StatelessWidget {
  final String name;
  final String point;

  const RedeemItem({
    super.key,
    required this.name,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 58,
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xffd9d9d9),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          Text(
            point,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// EDIT PROFILE PAGE

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final name = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = profileName;
    email.text = loggedEmail;
  }

  void save() {
    if (name.text.isEmpty || email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in your name and email.'),
        ),
      );
      return;
    }

    profileName = name.text;
    loggedEmail = email.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      avatar: true,
      backIcon: Icons.reply,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: name,
            hint: 'Name',
          ),

          Text(
            'Email:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: email,
            hint: 'Email',
          ),

          Text(
            'Profile Image:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: SizedBox(
              width: 120,
              child: GreenButton(
                text: '+',
                onTap: () {},
              ),
            ),
          ),

          const SizedBox(height: 25),

          GreenButton(
            text: 'Save',
            onTap: save,
          ),
        ],
      ),
    );
  }
}

// REPORT BUG PAGE

class ReportBugPage extends StatefulWidget {
  const ReportBugPage({super.key});

  @override
  State<ReportBugPage> createState() => _ReportBugPageState();
}

class _ReportBugPageState extends State<ReportBugPage> {
  final title = TextEditingController();
  final desc = TextEditingController();

  void sendBug() {
    if (title.text.isEmpty || desc.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete the issue title and description.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bug report sent'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      topIcon: Icons.campaign,
      backIcon: Icons.reply,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Issue Title:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: title,
            hint: '',
          ),

          Text(
            'Description:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: desc,
            maxLines: 6,
            style: const TextStyle(
              color: darkBg,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: appPanel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Center(
            child: SizedBox(
              width: 120,
              child: GreenButton(
                text: '+',
                onTap: () {},
              ),
            ),
          ),

          const SizedBox(height: 12),

          GreenButton(
            text: 'Send',
            onTap: sendBug,
          ),
        ],
      ),
    );
  }
}

// ABOUT PAGE

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      backIcon: Icons.reply,
      topWidget: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: inputColor,
            width: 8,
          ),
        ),
        child: const Icon(
          Icons.info_outline,
          color: inputColor,
          size: 80,
        ),
      ),
      child: Column(
        children: [
          const AppLogo(size: 92),

          const SizedBox(height: 25),

          Text(
            'Ocufy',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            'v1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            'Ready to target\nyour focus',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 35),

          Text(
            'Term of Service',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Privacy Policy',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Open Source Licenses',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 55),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright,
                color: isDarkMode ? Colors.white : darkBg,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                '2026 Ocufy Corp. All rights reserved',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : darkBg,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// SETTINGS DETAIL PAGE

class SettingsDetailPage extends StatelessWidget {
  const SettingsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 25, 22, 22),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.reply,
                    color: isDarkMode ? Colors.white : darkBg,
                    size: 40,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Settings',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : darkBg,
                  fontSize: 42,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 35),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  decoration: BoxDecoration(
                    color: appCard,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SettingOption(
                          icon: Icons.palette_outlined,
                          text: 'Theme',
                          page: const ThemePage(),
                        ),

                        SettingOption(
                          icon: Icons.edit_outlined,
                          text: 'Change Password',
                          page: const ChangePasswordPage(),
                        ),

                        SettingOption(
                          icon: Icons.translate_outlined,
                          text: 'Language',
                          page: const LanguagePage(),
                        ),

                        SettingOption(
                          icon: Icons.notifications_none_outlined,
                          text: 'Notifications',
                          page: const NotificationPage(),
                        ),

                        SettingOption(
                          icon: Icons.send_outlined,
                          text: 'Send Feedback',
                          page: const SendFeedbackPage(),
                        ),

                        SettingOption(
                          icon: Icons.security_outlined,
                          text: 'Security',
                          page: const SecurityPage(),
                        ),

                        SettingOption(
                          icon: Icons.headphones_outlined,
                          text: 'Customer Services',
                          page: const CustomerServicePage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// THEME PAGE

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  void setThemeMode(bool dark) {
    setState(() {
      isDarkMode = dark;
      themeNotifier.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.palette,
      title: 'Theme',
      child: Column(
        children: [
          Text(
            'Choose your theme color',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          const SizedBox(height: 35),

          Container(
            height: 65,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: darkBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setThemeMode(false),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !isDarkMode ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'LIGHT',
                        style: TextStyle(
                          color: !isDarkMode ? accent : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () => setThemeMode(true),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'DARK',
                        style: TextStyle(
                          color: isDarkMode ? darkBg : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CHANGE PASSWORD PAGE

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final email = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  void savePassword() {
    if (email.text.isEmpty || newPass.text.isEmpty || confirmPass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all information.'),
        ),
      );
      return;
    }

    if (newPass.text != confirmPass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password tidak sama'),
        ),
      );
      return;
    }

    savedPassword = newPass.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password berjaya ditukar'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.edit,
      title: 'Change Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter email',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: email,
            hint: 'Email',
          ),

          Text(
            'New password',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: newPass,
            hint: 'Password',
            obscure: true,
          ),

          Text(
            'Confirm new password',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
            ),
          ),

          AuthInput(
            controller: confirmPass,
            hint: 'Confirm Password',
            obscure: true,
          ),

          const SizedBox(height: 20),

          GreenButton(
            text: 'Save',
            onTap: savePassword,
          ),
        ],
      ),
    );
  }
}

// LANGUAGE PAGE

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final languages = [
    'Bahasa Melayu',
    'English',
    'Español',
    'Deutsch',
    'Français',
    'Italiano',
  ];

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.translate,
      title: 'Language',
      child: Column(
        children: languages.map((lang) {
          final selected = selectedLanguage == lang;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedLanguage = lang;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to $lang'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selected ? accent : Colors.white,
                  foregroundColor: selected ? Colors.white : darkBg,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29),
                  ),
                ),
                child: Text(
                  lang,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// NOTIFICATION PAGE

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.notifications_none,
      title: 'Notifications',
      child: Column(
        children: [
          NotifyTile(
            text: 'Reminder',
            value: reminderOn,
            onChanged: (v) {
              setState(() {
                reminderOn = v;
              });
            },
          ),

          NotifyTile(
            text: 'Message',
            value: messageOn,
            onChanged: (v) {
              setState(() {
                messageOn = v;
              });
            },
          ),

          NotifyTile(
            text: 'Points Collected',
            value: pointsOn,
            onChanged: (v) {
              setState(() {
                pointsOn = v;
              });
            },
          ),
        ],
      ),
    );
  }
}
// SEND FEEDBACK PAGE

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final feedback = TextEditingController();

  void send() {
    if (feedback.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write feedback first'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback sent'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.send_outlined,
      title: 'Send Feedback',
      child: Column(
        children: [
          Text(
            'Description:',
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: feedback,
            maxLines: 6,
            style: const TextStyle(
              color: darkBg,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: appPanel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 60),

          GreenButton(
            text: 'Send',
            onTap: send,
          ),
        ],
      ),
    );
  }
}

// SECURITY PAGE

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.security,
      title: 'Security',
      child: Center(
        child: GreenButton(
          text: 'Two Factor Authentication',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SecurityVerificationPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecurityVerificationPage extends StatelessWidget {
  const SecurityVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.security,
      title: 'Security',
      whiteCard: true,
      child: Column(
        children: [
          const Icon(
            Icons.verified_user,
            color: accent,
            size: 90,
          ),

          const SizedBox(height: 20),

          const Text(
            "We've Sent Verification\nCode to your email",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkBg,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            loggedEmail.isEmpty ? 'to your email' : loggedEmail,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkBg,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Enter the code below valid for\n5 minutes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkBg,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 20),

          GreenButton(
            text: 'Continue',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// CUSTOMER SERVICE PAGE

class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.headphones,
      title: 'Customer Services',
      child: Column(
        children: [
          GreenButton(
            text: 'Call Us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calling customer service...'),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          GreenButton(
            text: 'Chat Us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening chat...'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// REUSABLE WIDGETS

class PagePad extends StatelessWidget {
  final String title;
  final Widget child;
  final double titleSize;

  const PagePad({
    super.key,
    required this.title,
    required this.child,
    this.titleSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 58, 25, 10),
      child: Column(
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                color: appText,
                fontSize: titleSize,
                fontWeight: FontWeight.w400,
              ),
            ),

          const SizedBox(height: 44),

          Expanded(
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class ShadowPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const ShadowPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: appCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}

class SettingSubPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final bool whiteCard;

  const SettingSubPage({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.whiteCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 25, 18, 18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.reply,
                    color: isDarkMode ? Colors.white : darkBg,
                    size: 35,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              Icon(
                icon,
                color: isDarkMode ? Colors.white : darkBg,
                size: 90,
              ),

              const SizedBox(height: 8),

              Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : darkBg,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: whiteCard ? Colors.white : appCard,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? topIcon;
  final Widget? topWidget;
  final IconData? backIcon;
  final bool avatar;

  const SimplePage({
    super.key,
    required this.title,
    required this.child,
    this.topIcon,
    this.topWidget,
    this.backIcon,
    this.avatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    backIcon ?? Icons.arrow_back_ios,
                    color: isDarkMode ? Colors.white : darkBg,
                    size: backIcon != null ? 35 : 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              if (topWidget != null)
                topWidget!
              else ...[
                if (topIcon != null)
                  Icon(
                    topIcon,
                    color: isDarkMode ? Colors.white : darkBg,
                    size: 90,
                  ),

                if (avatar)
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white70,
                  ),
              ],

              if (title.isNotEmpty)
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : darkBg,
                    fontSize: 24,
                  ),
                ),

              const SizedBox(height: 30),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: appCard,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Widget child;

  const Box({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: appPanel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? Colors.white : darkBg,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: isDarkMode ? Colors.white : darkBg,
              size: 22,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isDarkMode ? Colors.white : darkBg,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 5),

        Divider(
          color: isDarkMode ? Colors.white24 : Colors.black26,
          thickness: 2,
        ),
      ],
    );
  }
}

class SettingOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget page;

  const SettingOption({
    super.key,
    required this.icon,
    required this.text,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          color: isDarkMode ? Colors.white : darkBg,
          size: 28,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isDarkMode ? Colors.white : darkBg,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }
}

class NotifyTile extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const NotifyTile({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: darkBg,
              ),
            ),
          ),

          Switch(
            value: value,
            activeColor: accent,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class CustomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.blur_on,
      Icons.timer_outlined,
      Icons.add,
      Icons.nightlight_round,
      Icons.person_outline,
    ];

    return Container(
      height: 58,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 12),
      decoration: BoxDecoration(
        color: appBottomNav,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icons.length,
              (i) {
            final selected = selectedIndex == i;

            return GestureDetector(
              onTap: () => onTap(i),
              child: CircleAvatar(
                radius: i == 2 ? 17 : 15,
                backgroundColor: i == 2
                    ? selected
                    ? accent
                    : appPanel
                    : Colors.transparent,
                child: Icon(
                  icons[i],
                  size: i == 2 ? 30 : 31,
                  color: i == 2
                      ? selected
                      ? appPanel
                      : accent
                      : selected
                      ? accent
                      : isDarkMode
                      ? Colors.white
                      : darkBg,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AuthBg extends StatelessWidget {
  final Widget child;
  final bool showBack;

  const AuthBg({
    super.key,
    required this.child,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      body: Stack(
        children: [
          const Positioned(
            left: -35,
            bottom: 140,
            child: Dot(size: 75),
          ),

          const Positioned(
            right: -25,
            bottom: 150,
            child: Dot(size: 60),
          ),

          const Positioned(
            right: 25,
            top: 170,
            child: Dot(size: 22),
          ),

          if (showBack)
            Positioned(
              top: 45,
              left: 18,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDarkMode ? Colors.white : darkBg,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double size;

  const Dot({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: accent,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  final String text;

  const SuccessPage({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      showBack: false,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? Colors.white : darkBg,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;

  const AuthInput({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 12,
          color: darkBg,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: appPanel,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GreenButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bubble_chart,
      color: accent,
      size: size,
    );
  }
}