
import 'package:flutter/material.dart';

void main() => runApp(const NovaStudyApp());

const navy = Color(0xFF0A1024);
const panel = Color(0xFF17213B);
const purple = Color(0xFF8B78FF);
const cyan = Color(0xFF64D9F7);

class NovaStudyApp extends StatelessWidget {
  const NovaStudyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'NOVA AI Study',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: navy,
          colorScheme: ColorScheme.fromSeed(
            seedColor: purple,
            brightness: Brightness.dark,
          ),
          fontFamily: 'Roboto',
        ),
        home: const WelcomeScreen(),
      );
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: controller,
                  curve: Curves.easeIn,
                ),
                child: ScaleTransition(
                  scale: Tween<double>(begin: .75, end: 1).animate(
                    CurvedAnimation(
                      parent: controller,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [purple, cyan],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: purple.withOpacity(.3),
                              blurRadius: 45,
                              spreadRadius: 7,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 70,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'NOVA AI',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                        ),
                      ),
                      const Text(
                        'STUDY',
                        style: TextStyle(
                          fontSize: 20,
                          color: cyan,
                          letterSpacing: 7,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'مساعدك الذكي للمذاكرة الجامعية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('ابدأ المذاكرة'),
                          style: FilledButton.styleFrom(
                            backgroundColor: purple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

const subjects = <({String ar, String en, IconData icon})>[
  (
    ar: 'مبادئ المحاسبة المالية',
    en: 'Financial Accounting',
    icon: Icons.account_balance_wallet_outlined,
  ),
  (
    ar: 'مبادئ الاقتصاد',
    en: 'Principles of Economics',
    icon: Icons.show_chart,
  ),
  (
    ar: 'مبادئ الإدارة',
    en: 'Principles of Management',
    icon: Icons.business_center_outlined,
  ),
  (
    ar: 'لغة إنجليزية للمتخصصين',
    en: 'English for Specialists',
    icon: Icons.translate,
  ),
  (
    ar: 'رياضيات تحليل الأعمال التجارية',
    en: 'Business Analytics Mathematics',
    icon: Icons.calculate_outlined,
  ),
  (
    ar: 'التفكير الابتكاري',
    en: 'Creative Thinking',
    icon: Icons.lightbulb_outline,
  ),
  (
    ar: 'إدارة رياضية',
    en: 'Sports Management',
    icon: Icons.sports_soccer,
  ),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selected = 0;

  final pages = const [
    HomePage(),
    StudyPage(),
    ExamsPage(),
    TermsPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: navy,
          title: const Row(
            children: [
              Icon(Icons.auto_awesome, color: cyan),
              SizedBox(width: 10),
              Text(
                'NOVA AI Study',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(.06, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(selected),
            child: pages[selected],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: panel,
          indicatorColor: purple.withOpacity(.35),
          selectedIndex: selected,
          onDestinationSelected: (index) {
            setState(() => selected = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'المذاكرة',
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz_outlined),
              selectedIcon: Icon(Icons.quiz),
              label: 'الامتحانات',
            ),
            NavigationDestination(
              icon: Icon(Icons.style_outlined),
              selectedIcon: Icon(Icons.style),
              label: 'مصطلحات',
            ),
          ],
        ),
      );
}

class FadeInTile extends StatefulWidget {
  final Widget child;
  final int index;

  const FadeInTile({
    super.key,
    required this.child,
    this.index = 0,
  });

  @override
  State<FadeInTile> createState() => _FadeInTileState();
}

class _FadeInTileState extends State<FadeInTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450 + widget.index * 90),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: CurvedAnimation(
          parent: controller,
          curve: Curves.easeIn,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, .13),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: widget.child,
        ),
      );
}

class NovaCard extends StatelessWidget {
  final Widget child;

  const NovaCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(.07),
          ),
        ),
        child: child,
      );
}

void upcoming(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('ميزة $feature هنفعّلها في المرحلة القادمة'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(18),
        children: [
          FadeInTile(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4233A2),
                    Color(0xFF176A91),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'أهلاً بيك في NOVA ✨',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ذاكر بذكاء، افهم بالعربي، واختبر نفسك بالإنجليزي.',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'موادك الدراسية',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(subjects.length, (i) {
            final subject = subjects[i];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FadeInTile(
                index: i,
                child: NovaCard(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: purple.withOpacity(.17),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          subject.icon,
                          color: cyan,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              subject.ar,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subject.en,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      );
}

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int subjectIndex = 0;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'مركز المذاكرة',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'اختار المادة، وبعدها هنضيف رفع المحاضرات وشرحها.',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          NovaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'المادة',
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: subjectIndex,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    subjects.length,
                    (i) => DropdownMenuItem(
                      value: i,
                      child: Text(
                        subjects[i].ar,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => subjectIndex = value);
                    }
                  },
                ),
                const SizedBox(height: 22),
                const Icon(
                  Icons.picture_as_pdf_outlined,
                  size: 65,
                  color: cyan,
                ),
                const SizedBox(height: 12),
                const Text(
                  'رفع ملف PDF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'رفع الملفات واستخراج المحتوى سيتم تفعيله بعد ربط خدمات معالجة PDF.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => upcoming(context, 'رفع PDF'),
                  icon: const Icon(Icons.upload_file),
                  label: const Text('اختيار ملف PDF'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const NovaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'قريبًا في مركز المذاكرة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '• شرح عربي مفصل لكل محاضرة\n'
                  '• ملخصات ومفاهيم مهمة\n'
                  '• أسئلة بالإنجليزي وإجابات مشروحة\n'
                  '• تصدير مذكرة PDF',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(height: 1.9),
                ),
              ],
            ),
          ),
        ],
      );
}

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  String exam = 'Midterm';
  int count = 20;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'الاختبارات الذكية',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          NovaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.fact_check_outlined,
                  color: cyan,
                  size: 58,
                ),
                const SizedBox(height: 18),
                const Text(
                  'نوع الامتحان',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 10),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'Midterm',
                      label: Text('Midterm'),
                    ),
                    ButtonSegment(
                      value: 'Final',
                      label: Text('Final'),
                    ),
                  ],
                  selected: {exam},
                  onSelectionChanged: (values) {
                    setState(() => exam = values.first);
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  'عدد الأسئلة: $count',
                  textAlign: TextAlign.right,
                ),
                Slider(
                  value: count.toDouble(),
                  min: 10,
                  max: 50,
                  divisions: 8,
                  label: '$count',
                  onChanged: (v) {
                    setState(() => count = v.round());
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'الأسئلة بالإنجليزي، والتصحيح والشرح بالعربي والإنجليزي.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => upcoming(
                    context,
                    'توليد امتحان $exam',
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('إنشاء الامتحان'),
                ),
              ],
            ),
          ),
        ],
      );
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'المصطلحات والمفاهيم',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          const NovaCard(
            child: Column(
              children: [
                Icon(
                  Icons.style_outlined,
                  color: cyan,
                  size: 60,
                ),
                SizedBox(height: 16),
                Text(
                  'قاموس NOVA الذكي',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'بعد رفع المحاضرات، هتظهر هنا أهم الكلمات الإنجليزية وترجمتها وشرحها بالعربي مع أمثلة وكروت مراجعة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'مثال على شكل المصطلحات',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          const NovaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Assets',
                  style: TextStyle(
                    fontSize: 21,
                    color: cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'الأصول',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'الموارد الاقتصادية اللي بتمتلكها المنشأة أو بتتحكم فيها والمتوقع تحقق منها منفعة مستقبلية.',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      );
}