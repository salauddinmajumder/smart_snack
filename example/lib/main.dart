import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_snack/smart_snack.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SmartSnackShowcase());
}

class SmartSnackShowcase extends StatelessWidget {
  const SmartSnackShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartSnack Showcase',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      themeMode: ThemeMode.light,
      home: const ShowcasePage(),
    );
  }
}

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _BasicStylesTab(),
                  _CustomStylesTab(),
                  _InteractiveTab(),
                  _AdvancedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.notifications_active_rounded,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SmartSnack',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Dynamic Island-style notifications',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: 'Basic'),
          Tab(text: 'Styles'),
          Tab(text: 'Interactive'),
          Tab(text: 'Advanced'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BASIC STYLES TAB
// ═══════════════════════════════════════════════════════════════════════════════

class _BasicStylesTab extends StatelessWidget {
  const _BasicStylesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle('Status Notifications'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Success',
          subtitle: 'Confirms completed actions',
          gradient: const [Color(0xFF10B981), Color(0xFF14B8A6)],
          icon: Icons.check_circle_rounded,
          onTap: () => SmartSnack.success(
            context,
            title: 'Payment Successful!',
            subtitle: '\$50.00 sent to Sarah',
          ),
        ),
        _ShowcaseCard(
          title: 'Error',
          subtitle: 'Shows failure messages',
          gradient: const [Color(0xFFEF4444), Color(0xFFF97316)],
          icon: Icons.error_rounded,
          onTap: () => SmartSnack.error(
            context,
            title: 'Connection Failed',
            subtitle: 'Please check your internet',
          ),
        ),
        _ShowcaseCard(
          title: 'Warning',
          subtitle: 'Alerts for caution',
          gradient: const [Color(0xFFF59E0B), Color(0xFFEAB308)],
          icon: Icons.warning_rounded,
          onTap: () => SmartSnack.warning(
            context,
            title: 'Low Battery',
            subtitle: '10% remaining',
          ),
        ),
        _ShowcaseCard(
          title: 'Info',
          subtitle: 'Informational messages',
          gradient: const [Color(0xFF3B82F6), Color(0xFF06B6D4)],
          icon: Icons.info_rounded,
          onTap: () => SmartSnack.info(
            context,
            title: 'New Update Available',
            subtitle: 'Version 2.0 is ready',
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Loading State'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Loading',
          subtitle: 'Animated gradient border',
          gradient: const [Color(0xFF8B5CF6), Color(0xFFD946EF)],
          icon: Icons.sync_rounded,
          onTap: () async {
            SmartSnack.loading(context, title: 'Syncing data...');
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              SmartSnack.success(context, title: 'Sync complete!');
            }
          },
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CUSTOM STYLES TAB
// ═══════════════════════════════════════════════════════════════════════════════

class _CustomStylesTab extends StatelessWidget {
  const _CustomStylesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle('Premium Styles'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Glass Morphism',
          subtitle: 'Frosted glass blur effect',
          gradient: const [Color(0xFF64748B), Color(0xFF475569)],
          icon: Icons.blur_on_rounded,
          onTap: () => SmartSnack.glass(
            context,
            title: 'AirDrop Received',
            subtitle: 'Photo from iPhone nearby',
            leading:
                const Icon(Icons.phone_iphone, color: Colors.white70, size: 22),
          ),
        ),
        _ShowcaseCard(
          title: 'Gradient',
          subtitle: 'Beautiful gradient backgrounds',
          gradient: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          icon: Icons.gradient_rounded,
          onTap: () => SmartSnack.gradient(
            context,
            title: 'Premium Unlocked! ✨',
            gradientColors: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
        ),
        _ShowcaseCard(
          title: 'Minimal',
          subtitle: 'Clean and simple',
          gradient: const [Color(0xFF374151), Color(0xFF1F2937)],
          icon: Icons.minimize_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'Copied to clipboard',
            style: SmartSnackStyle.minimal,
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Custom Notifications'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Now Playing',
          subtitle: 'Music player style',
          gradient: const [Color(0xFFEC4899), Color(0xFFF43F5E)],
          icon: Icons.music_note_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: '',
            style: SmartSnackStyle.custom,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
                  ),
                ),
                child:
                    const Icon(Icons.music_note, color: Colors.white, size: 20),
              ),
            ),
            bodyWidget: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blinding Lights',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  'The Weeknd',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            trailing: const _AnimatedWave(),
          ),
        ),
        _ShowcaseCard(
          title: 'Incoming Call',
          subtitle: 'With action buttons',
          gradient: const [Color(0xFF22C55E), Color(0xFF16A34A)],
          icon: Icons.call_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'Sarah Wilson',
            subtitle: 'Incoming call...',
            style: SmartSnackStyle.custom,
            duration: const Duration(seconds: 8),
            leading: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFF22C55E),
              child: Text('SW',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CallButton(
                    color: Colors.red,
                    icon: Icons.call_end,
                    onTap: () => SmartSnack.dismiss()),
                const SizedBox(width: 8),
                _CallButton(
                    color: Colors.green,
                    icon: Icons.call,
                    onTap: () =>
                        SmartSnack.success(context, title: 'Call connected')),
              ],
            ),
          ),
        ),
        _ShowcaseCard(
          title: 'Message',
          subtitle: 'Chat notification',
          gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          icon: Icons.message_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'New message from Alex',
            subtitle: 'Hey! Are you free tonight? 🎉',
            style: SmartSnackStyle.custom,
            leading: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue[100],
              child: const Text('A',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INTERACTIVE TAB
// ═══════════════════════════════════════════════════════════════════════════════

class _InteractiveTab extends StatelessWidget {
  const _InteractiveTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle('Action Buttons'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'With Actions',
          subtitle: 'Undo deleted item',
          gradient: const [Color(0xFFEF4444), Color(0xFFDC2626)],
          icon: Icons.delete_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'Item deleted',
            style: SmartSnackStyle.custom,
            leading: const Icon(Icons.delete_outline,
                color: Color(0xFFEF4444), size: 22),
            actions: [
              SmartSnackAction(
                label: 'Undo',
                onPressed: () =>
                    SmartSnack.success(context, title: 'Item restored'),
              ),
            ],
          ),
        ),
        _ShowcaseCard(
          title: 'Multiple Actions',
          subtitle: 'Save or share file',
          gradient: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
          icon: Icons.file_present_rounded,
          onTap: () => SmartSnack.info(
            context,
            title: 'File ready',
            subtitle: 'document.pdf',
            actions: [
              SmartSnackAction(
                label: 'Share',
                icon: Icons.share,
                onPressed: () {},
              ),
              SmartSnackAction(
                label: 'Save',
                icon: Icons.download,
                onPressed: () => SmartSnack.success(context, title: 'Saved!'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Progress Indicators'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Upload Progress',
          subtitle: 'Animated progress bar',
          gradient: const [Color(0xFF06B6D4), Color(0xFF0891B2)],
          icon: Icons.cloud_upload_rounded,
          onTap: () async {
            for (double i = 0; i <= 1.0; i += 0.1) {
              SmartSnack.progress(
                context,
                id: 'upload',
                title: 'Uploading file...',
                progress: i,
                showProgressText: true,
                accentColor: const Color(0xFF06B6D4),
              );
              await Future.delayed(const Duration(milliseconds: 300));
            }
            if (context.mounted) {
              SmartSnack.success(context, title: 'Upload complete!');
            }
          },
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Loading Transitions'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Load → Success',
          subtitle: 'Common async pattern',
          gradient: const [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
          icon: Icons.sync_rounded,
          onTap: () async {
            SmartSnack.loading(context, title: 'Processing payment...');
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              SmartSnack.success(context, title: 'Payment successful! 💰');
            }
          },
        ),
        _ShowcaseCard(
          title: 'Load → Error',
          subtitle: 'Failure handling',
          gradient: const [Color(0xFFEF4444), Color(0xFFDC2626)],
          icon: Icons.error_outline_rounded,
          onTap: () async {
            SmartSnack.loading(context, title: 'Connecting...');
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              SmartSnack.error(context, title: 'Connection timeout');
            }
          },
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADVANCED TAB
// ═══════════════════════════════════════════════════════════════════════════════

class _AdvancedTab extends StatelessWidget {
  const _AdvancedTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle('Queue Management'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Queued Messages',
          subtitle: 'Shows 3 notifications in sequence',
          gradient: const [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
          icon: Icons.queue_rounded,
          onTap: () {
            SmartSnack.info(context, title: 'First notification');
            SmartSnack.warning(context, title: 'Second notification');
            SmartSnack.success(context, title: 'Third notification');
          },
        ),
        _ShowcaseCard(
          title: 'High Priority',
          subtitle: 'Jumps the queue',
          gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
          icon: Icons.priority_high_rounded,
          onTap: () {
            SmartSnack.info(context, title: 'Normal priority');
            SmartSnack.show(
              context,
              title: '⚡ URGENT: Check this first!',
              style: SmartSnackStyle.warning,
              priority: SmartSnackPriority.urgent,
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Position & Gestures'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'Bottom Position',
          subtitle: 'Display at screen bottom',
          gradient: const [Color(0xFF64748B), Color(0xFF475569)],
          icon: Icons.vertical_align_bottom_rounded,
          onTap: () => SmartSnack.info(
            context,
            title: 'Bottom notification',
            position: SmartSnackPosition.bottom,
          ),
        ),
        _ShowcaseCard(
          title: 'Swipe to Dismiss',
          subtitle: 'Try swiping up on any notification',
          gradient: const [Color(0xFF06B6D4), Color(0xFF0891B2)],
          icon: Icons.swipe_up_rounded,
          onTap: () => SmartSnack.info(
            context,
            title: '⬆️ Swipe up to dismiss',
            duration: const Duration(seconds: 10),
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('System Notifications'),
        const SizedBox(height: 12),
        _ShowcaseCard(
          title: 'AirPods Connected',
          subtitle: 'Device connection style',
          gradient: const [Color(0xFF22C55E), Color(0xFF16A34A)],
          icon: Icons.headphones_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'AirPods Pro',
            subtitle: 'Connected',
            style: SmartSnackStyle.custom,
            leading: const Icon(Icons.headphones_rounded,
                color: Color(0xFF22C55E), size: 24),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.battery_full,
                    color: Color(0xFF22C55E), size: 16),
                const SizedBox(width: 4),
                Text(
                  '85%',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        _ShowcaseCard(
          title: 'Screenshot Taken',
          subtitle: 'System capture notification',
          gradient: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
          icon: Icons.screenshot_rounded,
          onTap: () => SmartSnack.show(
            context,
            title: 'Screenshot saved',
            subtitle: 'Tap to view',
            style: SmartSnackStyle.custom,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, color: Colors.blue, size: 20),
            ),
            onTap: () => SmartSnack.info(context, title: 'Opening gallery...'),
          ),
        ),
        _ShowcaseCard(
          title: 'Face ID',
          subtitle: 'Authentication notification',
          gradient: const [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
          icon: Icons.face_rounded,
          onTap: () async {
            SmartSnack.show(
              context,
              title: 'Face ID',
              style: SmartSnackStyle.loading,
              leading: const Icon(Icons.face_rounded,
                  color: Color(0xFF8B5CF6), size: 24),
            );
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted) {
              SmartSnack.success(context, title: 'Face ID verified ✓');
            }
          },
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final IconData icon;
  final VoidCallback onTap;

  const _ShowcaseCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.first.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400],
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _CallButton({
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}

// Animated wave widget for music player
class _AnimatedWave extends StatefulWidget {
  const _AnimatedWave();

  @override
  State<_AnimatedWave> createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<_AnimatedWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(
              animationValue: _controller.value,
              color: const Color(0xFFEC4899),
              barCount: 4,
              maxHeight: 16,
            ),
          );
        },
      ),
    );
  }
}
