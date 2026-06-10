import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const PomodoroApp());

const darkBg = Color(0xff1d1b55);
const cardBg = Color(0xff5a548c);
const accent = Color(0xff00d0ad);
const inputColor = Color(0xffeee9ff);

String loggedEmail = '';
String profileName = '';
String savedPassword = '';

bool isDarkMode = true;
String selectedLanguage = 'English';

bool reminderOn = true;
bool messageOn = true;
bool pointsOn = true;

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      home: const LoginStartPage(),
    );
  }
}

/* ================= LOGIN START ================= */

class LoginStartPage extends StatelessWidget {
  const LoginStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      showBack: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const SizedBox(height: 35),
          const Text(
            'Ready to target\nyour focus',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 100),
          GreenButton(
            text: 'Login',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: const Text(
              "Doesn't have an account? Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= LOGIN PAGE ================= */

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
        const SnackBar(content: Text('Sila masukkan email dan password')),
      );
      return;
    }

    loggedEmail = email.text;
    profileName = loggedEmail.split('@').first;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const SizedBox(height: 60),
          AuthInput(controller: email, hint: 'Email'),
          AuthInput(controller: password, hint: 'Password', obscure: true),
          const SizedBox(height: 12),
          GreenButton(text: 'Log In', onTap: login),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: const Text(
              "Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Forgot password?',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

/* ================= REGISTER PAGE ================= */

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
        const SnackBar(content: Text('Sila lengkapkan semua maklumat')),
      );
      return;
    }

    if (password.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak sama')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RegisterSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const SizedBox(height: 55),
          AuthInput(controller: email, hint: 'Email'),
          AuthInput(controller: password, hint: 'Password', obscure: true),
          AuthInput(controller: confirm, hint: 'Confirm Password', obscure: true),
          const SizedBox(height: 12),
          GreenButton(text: 'Register', onTap: register),
        ],
      ),
    );
  }
}

/* ================= SUCCESS PAGE ================= */

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });

    return const SuccessPage(text: 'REGISTRATION\nSUCCESSFUL');
  }
}

class LoginSuccessPage extends StatelessWidget {
  const LoginSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
    });

    return const SuccessPage(text: 'LOG IN\nSUCCESSFUL');
  }
}

class LogoutSuccessPage extends StatelessWidget {
  const LogoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });

    return const SuccessPage(text: 'LOG OUT\nSUCCESSFUL');
  }
}

/* ================= MAIN PAGE ================= */

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = const [
    HomePage(),
    ChartPage(),
    FocusPage(),
    ReminderPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: CustomNav(
        selectedIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

/* ================= HOME PAGE - UPDATED ================= */

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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Your Point:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                Box(
                  child: Text(
                    '6700',
                    style: TextStyle(
                      color: accent,
                      fontSize: 76,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent:', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: inputColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      HomeLapRow(
                        lap: 'Lap 1',
                        time: '50m',
                        detail1: '20m exercise (2)',
                        detail2: '5m rest (2)',
                      ),
                      Divider(color: Colors.grey),
                      HomeLapRow(
                        lap: 'Lap 2',
                        time: '1h10m',
                        detail1: '30m exercise (2)',
                        detail2: '10m rest (1)',
                      ),
                      Divider(color: Colors.grey),
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
          const SizedBox(height: 15),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
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
                    size: 31,
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
          width: 95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lap,
                style: const TextStyle(
                  color: darkBg,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: accent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            '$detail1\n$detail2',
            style: const TextStyle(
              color: darkBg,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/* ================= CHART PAGE - UPDATED ================= */

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: 'Chart',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: inputColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: SizedBox(
                width: 210,
                height: 210,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(210, 210),
                      painter: DonutChartPainter(),
                    ),
                    const Positioned(left: 5, top: 20, child: ChartLabel(text: 'EXERCISE')),
                    const Positioned(
                      right: 10,
                      top: 100,
                      child: Text('40%', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    const Positioned(
                      left: 35,
                      top: 70,
                      child: Text(
                        '30%',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Positioned(
                      bottom: 25,
                      child: Text(
                        '20%',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Positioned(right: 0, bottom: 70, child: ChartLabel(text: 'STUDY')),
                    const Positioned(left: 0, bottom: 20, child: ChartLabel(text: 'MEDITATION')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: inputColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressText(text: 'STUDY', width: 190, color: cardBg),
                ProgressText(text: 'EXERCISE', width: 135, color: darkBg),
                ProgressText(text: 'MEDITATION', width: 95, color: accent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 42.0;
    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    paint.color = cardBg;
    canvas.drawArc(rect.deflate(stroke / 2), -1.57, 2.45, false, paint);

    paint.color = accent;
    canvas.drawArc(rect.deflate(stroke / 2), 0.88, 1.55, false, paint);

    paint.color = darkBg;
    canvas.drawArc(rect.deflate(stroke / 2), 2.43, 2.30, false, paint);

    paint
      ..color = inputColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 62, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ChartLabel extends StatelessWidget {
  final String text;

  const ChartLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xffaab7d8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: darkBg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class ProgressText extends StatelessWidget {
  final String text;
  final double width;
  final Color color;

  const ProgressText({
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
/* ================= FOCUS PAGE ================= */

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int totalSeconds = 25 * 60;
  int seconds = 0;
  Timer? timer;
  final minute = TextEditingController(text: '25');

  void setTime() {
    final min = int.tryParse(minute.text);
    if (min == null || min <= 0) return;

    timer?.cancel();
    setState(() {
      totalSeconds = min * 60;
      seconds = totalSeconds;
    });
  }

  void start() {
    if (seconds == 0) setTime();

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        timer?.cancel();
      }
    });
  }

  void restart() {
    timer?.cancel();
    setState(() => seconds = totalSeconds);
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
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            width: 185,
            height: 185,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 28),
            ),
            child: Center(
              child: Text(
                '$m:$s',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Box(
            child: Column(
              children: [
                TextField(
                  controller: minute,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: inputColor,
                    hintText: 'Set minit',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
                GreenButton(text: 'Set Time', onTap: setTime),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundBtn(icon: Icons.play_arrow, onTap: start),
              RoundBtn(icon: Icons.refresh, onTap: restart, white: true),
            ],
          ),
        ],
      ),
    );
  }
}

/* ================= REMINDER PAGE ================= */

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: 'Reminder',
      child: Column(
        children: [
          Box(
            child: Column(
              children: [
                const Text(
                  'Febuary',
                  style: TextStyle(
                    color: darkBg,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const Divider(color: accent, thickness: 3),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: List.generate(
                    28,
                        (i) => CircleAvatar(
                      radius: 12,
                      backgroundColor: i == 0 ? accent : darkBg,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Event', style: TextStyle(color: darkBg)),
                SizedBox(height: 10),
                Divider(color: accent, thickness: 3),
              ],
            ),
          ),
          GreenButton(
            text: 'Add Reminder',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReminderInputPage()),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= ACCOUNT PAGE ================= */

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LogoutSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagePad(
      title: '',
      child: Column(
        children: [
          const Divider(color: Colors.white, thickness: 4),
          Row(
            children: [
              const CircleAvatar(radius: 33, backgroundColor: Colors.white),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileName.isEmpty ? 'Your Name' : profileName,
                    style: const TextStyle(color: accent, fontSize: 14),
                  ),
                  const Text(
                    '6700 points',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    loggedEmail,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.white54),
          MenuTile(
            icon: Icons.redeem,
            text: 'Redeem',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RedeemPage()),
            ),
          ),
          MenuTile(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsDetailPage()),
            ),
          ),
          MenuTile(
            icon: Icons.edit,
            text: 'Edit Profile',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            ),
          ),
          MenuTile(
            icon: Icons.report,
            text: 'Report Bug',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReportBugPage()),
            ),
          ),
          MenuTile(
            icon: Icons.info,
            text: 'About',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            ),
          ),
          const SizedBox(height: 30),
          GreenButton(text: 'Log Out', onTap: () => logout(context)),
        ],
      ),
    );
  }
}

/* ================= REMINDER INPUT PAGE ================= */

class ReminderInputPage extends StatefulWidget {
  const ReminderInputPage({super.key});

  @override
  State<ReminderInputPage> createState() => _ReminderInputPageState();
}

class _ReminderInputPageState extends State<ReminderInputPage> {
  final event = TextEditingController();
  final date = TextEditingController();

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
          AuthInput(controller: event, hint: 'Event'),
          AuthInput(controller: date, hint: 'Date'),
          const SizedBox(height: 35),
          GreenButton(text: 'Set', onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
/* ================= REDEEM PAGE ================= */

class RedeemPage extends StatelessWidget {
  const RedeemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      topIcon: Icons.stars,
      child: Column(
        children: const [
          Text(
            'Redeem\nShop',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accent,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 25),
          RedeemItem(name: 'Product 1', point: '1000'),
          RedeemItem(name: 'Product 2', point: '2000'),
          RedeemItem(name: 'Product 3', point: '3500'),
          RedeemItem(name: 'Product 4', point: '5000'),
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
      height: 45,
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 16, backgroundColor: inputColor),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            point,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= EDIT PROFILE PAGE ================= */

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
    profileName = name.text;
    loggedEmail = email.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      avatar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name:', style: TextStyle(color: Colors.white)),
          AuthInput(controller: name, hint: 'Name'),
          const Text('Email:', style: TextStyle(color: Colors.white)),
          AuthInput(controller: email, hint: 'Email'),
          const Text('Profile Image:', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 120,
              child: GreenButton(text: '+', onTap: () {}),
            ),
          ),
          const SizedBox(height: 25),
          GreenButton(text: 'Save', onTap: save),
        ],
      ),
    );
  }
}

/* ================= REPORT BUG PAGE ================= */

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
        const SnackBar(content: Text('Sila lengkapkan issue title dan description')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bug report sent')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      topIcon: Icons.campaign,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Issue Title:', style: TextStyle(color: Colors.white)),
          AuthInput(controller: title, hint: ''),
          const Text('Description:', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          TextField(
            controller: desc,
            maxLines: 6,
            decoration: InputDecoration(
              filled: true,
              fillColor: inputColor,
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
              child: GreenButton(text: '+', onTap: () {}),
            ),
          ),
          GreenButton(text: 'Send', onTap: sendBug),
        ],
      ),
    );
  }
}

/* ================= ABOUT PAGE ================= */

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '',
      topIcon: Icons.info_outline,
      child: Column(
        children: const [
          AppLogo(),
          SizedBox(height: 25),
          Text(
            'Ocufy\nv1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 25),
          Text(
            'Ready to target\nyour focus',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Term of service',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Privacy Policy',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Open Source Licenses',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 55),
          Text(
            '© 2026 Ocufy Corp. All rights reserved',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
/* ================= SETTINGS DETAIL PAGE ================= */

class SettingsDetailPage extends StatelessWidget {
  const SettingsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 25, 22, 22),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SettingOption(
                        icon: Icons.palette,
                        text: 'Theme',
                        page: const ThemePage(),
                      ),
                      SettingOption(
                        icon: Icons.edit,
                        text: 'Change Password',
                        page: const ChangePasswordPage(),
                      ),
                      SettingOption(
                        icon: Icons.translate,
                        text: 'Language',
                        page: const LanguagePage(),
                      ),
                      SettingOption(
                        icon: Icons.notifications_none,
                        text: 'Notifications',
                        page: const NotificationPage(),
                      ),
                      SettingOption(
                        icon: Icons.send,
                        text: 'Send Feedback',
                        page: const SendFeedbackPage(),
                      ),
                      SettingOption(
                        icon: Icons.security,
                        text: 'Security',
                        page: const SecurityPage(),
                      ),
                      SettingOption(
                        icon: Icons.headphones,
                        text: 'Customer Services',
                        page: const CustomerServicePage(),
                      ),
                    ],
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

/* ================= THEME PAGE ================= */

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.palette,
      title: 'Theme',
      child: Column(
        children: [
          const Text(
            'Choose your theme color',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDarkMode = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isDarkMode ? Colors.white : darkBg,
                    foregroundColor: !isDarkMode ? darkBg : Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('LIGHT'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDarkMode = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? darkBg : Colors.white,
                    foregroundColor: isDarkMode ? Colors.white : darkBg,
                    elevation: 0,
                  ),
                  child: const Text('DARK'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ================= CHANGE PASSWORD PAGE ================= */

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
        const SnackBar(content: Text('Sila lengkapkan semua maklumat')),
      );
      return;
    }

    if (newPass.text != confirmPass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak sama')),
      );
      return;
    }

    savedPassword = newPass.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berjaya ditukar')),
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
          const Text('Enter email', style: TextStyle(color: Colors.white)),
          AuthInput(controller: email, hint: 'Email'),
          const Text('New password', style: TextStyle(color: Colors.white)),
          AuthInput(controller: newPass, hint: 'Password', obscure: true),
          const Text(
            'Confirm new password',
            style: TextStyle(color: Colors.white),
          ),
          AuthInput(
            controller: confirmPass,
            hint: 'Confirm Password',
            obscure: true,
          ),
          const SizedBox(height: 20),
          GreenButton(text: 'Save', onTap: savePassword),
        ],
      ),
    );
  }
}

/* ================= LANGUAGE PAGE ================= */

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

  void changeLanguage(String lang) {
    setState(() {
      selectedLanguage = lang;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Language changed to $lang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.translate,
      title: 'Language',
      child: Column(
        children: languages.map((lang) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => changeLanguage(lang),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  selectedLanguage == lang ? accent : Colors.white,
                  foregroundColor:
                  selectedLanguage == lang ? Colors.white : darkBg,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: Text(lang),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/* ================= NOTIFICATION PAGE ================= */

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
            child: Text(text, style: const TextStyle(color: darkBg)),
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
/* ================= SEND FEEDBACK PAGE ================= */

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
        const SnackBar(content: Text('Sila tulis feedback dahulu')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback sent')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SettingSubPage(
      icon: Icons.send,
      title: 'Send Feedback',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description:', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 15),
          TextField(
            controller: feedback,
            maxLines: 6,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 60),
          GreenButton(text: 'Send', onTap: send),
        ],
      ),
    );
  }
}

/* ================= SECURITY PAGE ================= */

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
          const Icon(Icons.verified_user, color: accent, size: 90),
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
            style: TextStyle(color: darkBg, fontSize: 12),
          ),
          const SizedBox(height: 20),
          GreenButton(
            text: 'Continue',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

/* ================= CUSTOMER SERVICE PAGE ================= */

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
                const SnackBar(content: Text('Calling customer service...')),
              );
            },
          ),
          const SizedBox(height: 15),
          GreenButton(
            text: 'Chat Us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening chat...')),
              );
            },
          ),
        ],
      ),
    );
  }
}

/* ================= REUSABLE WIDGETS ================= */

class PagePad extends StatelessWidget {
  final String title;
  final Widget child;

  const PagePad({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 28, 25, 10),
      child: Column(
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          const SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(child: child),
          ),
        ],
      ),
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
      backgroundColor: darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 25, 18, 18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Icon(icon, color: Colors.white, size: 45),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: whiteCard ? Colors.white : cardBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(child: child),
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
  final bool avatar;

  const SimplePage({
    super.key,
    required this.title,
    required this.child,
    this.topIcon,
    this.avatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              if (topIcon != null)
                Icon(topIcon, color: Colors.white, size: 90),
              if (avatar)
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white70,
                ),
              if (title.isNotEmpty)
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(child: child),
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

  const Box({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: inputColor,
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
          onTap: onTap,
          leading: Icon(icon, color: Colors.white, size: 18),
          title: Text(text, style: const TextStyle(color: Colors.white)),
        ),
        const Divider(color: Colors.white24),
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
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white, size: 19),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
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
      Icons.apps,
      Icons.timer,
      Icons.add,
      Icons.access_time,
      Icons.person_outline,
    ];

    return Container(
      height: 55,
      color: cardBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icons.length,
              (i) => GestureDetector(
            onTap: () => onTap(i),
            child: CircleAvatar(
              radius: i == 2 ? 15 : 13,
              backgroundColor: selectedIndex == i ? accent : Colors.transparent,
              child: Icon(
                icons[i],
                size: 18,
                color: selectedIndex == i ? Colors.white : Colors.white70,
              ),
            ),
          ),
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
      backgroundColor: darkBg,
      body: Stack(
        children: [
          const Positioned(left: -35, bottom: 140, child: Dot(size: 75)),
          const Positioned(right: -25, bottom: 150, child: Dot(size: 60)),
          const Positioned(right: 25, top: 170, child: Dot(size: 22)),
          if (showBack)
            Positioned(
              top: 45,
              left: 18,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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

  const Dot({super.key, required this.size});

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

  const SuccessPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      showBack: false,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
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
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11),
          filled: true,
          fillColor: inputColor,
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
      height: 39,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RoundBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool white;

  const RoundBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.white = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: white ? Colors.white : accent,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: white ? darkBg : Colors.white),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.bubble_chart, color: accent, size: 100);
  }
}