import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../theme/app_theme.dart' as AppTheme;
import 'particle_background.dart';

class CodeLanguage {
  final String name;
  final Color iconColor;
  final IconData icon;
  final String template;
  final int judgeId;
  final dynamic languageMode;

  CodeLanguage({
    required this.name,
    required this.iconColor,
    required this.icon,
    required this.template,
    required this.judgeId,
    required this.languageMode,
  });
}

class AboutMeSection extends StatelessWidget {
  final VoidCallback onViewWorkPressed;

  const AboutMeSection({super.key, required this.onViewWorkPressed});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Container(
      color: AppTheme.AppTheme.backgroundColor,
      child: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: isSmallScreen
                  ? _buildSmallScreenLayout()
                  : _buildLargeScreenLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildIntroductionText(),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: FadeAnimation(
            delay: const Duration(milliseconds: 1200),
            child: _buildCodeEditorWithLabel(),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIntroductionText(isCentered: true),
        const SizedBox(height: 48),
        FadeAnimation(
          delay: const Duration(milliseconds: 1200),
          child: _buildCodeEditorWithLabel(isCentered: true),
        ),
      ],
    );
  }

  Widget _buildCodeEditorWithLabel({bool isCentered = false}) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Text(
            "         Try the live code editor below!",
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppTheme.AppTheme.textSecondary.withValues(alpha:0.8),
            ),
          ),
        ),
        const AdvancedCodeEditor(),
      ],
    );
  }

  Widget _buildIntroductionText({bool isCentered = false}) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAnimation(
          delay: const Duration(milliseconds: 200),
          child: _buildGreeting(),
        ),
        const SizedBox(height: 16),
        FadeAnimation(
          delay: const Duration(milliseconds: 400),
          child: _buildName(),
        ),
        const SizedBox(height: 24),
        FadeAnimation(
          delay: const Duration(milliseconds: 600),
          child: _buildAnimatedTitle(),
        ),
        const SizedBox(height: 32),
        FadeAnimation(
          delay: const Duration(milliseconds: 800),
          child: _buildDescription(isCentered),
        ),
        const SizedBox(height: 48),
        FadeAnimation(
          delay: const Duration(milliseconds: 1000),
          child: _buildActionButtons(),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Text(
      'Hello, I\'m',
      style: GoogleFonts.inter(
        fontSize: 18,
        color: AppTheme.AppTheme.textSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildName() {
    return Text(
      'Akshat Singh',
      style: GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: AppTheme.AppTheme.textPrimary,
        height: 1.1,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAnimatedTitle() {
    return SizedBox(
      height: 50,
      child: AnimatedTextKit(
        animatedTexts: [
          _typerText('Flutter Developer', AppTheme.AppTheme.primaryColor),
          _typerText('Machine Learning', AppTheme.AppTheme.accentBlue),
          _typerText('Tech Innovator', AppTheme.AppTheme.accentGreen),
        ],
        totalRepeatCount: 5,
        pause: const Duration(milliseconds: 2000),
      ),
    );
  }

  TyperAnimatedText _typerText(String text, Color color) {
    return TyperAnimatedText(
      text,
      textStyle: GoogleFonts.inter(
        fontSize: 28,
        color: color,
        fontWeight: FontWeight.w600,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }

  Widget _buildDescription(bool isCentered) {
    return Text(
      'I create beautiful, high-performance mobile applications with Flutter. Currently pursuing Computer Science at DTU, focusing on cutting-edge software development and machine learning.',
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.inter(
        fontSize: 16,
        height: 1.6,
        color: AppTheme.AppTheme.textSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildSecondaryButton(
          'GitHub',
          Icons.code_rounded,
          () => _launchUrl('https://github.com/akshat2474'),
        ),
        _buildSecondaryButton(
          'LinkedIn',
          Icons.work_outline_rounded,
          () => _launchUrl('https://www.linkedin.com/in/akshat-singh-48a03b312'),
        ),
      ],
    );
  }


  Widget _buildSecondaryButton(
      String text, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: AppTheme.AppTheme.textPrimary, size: 16),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.AppTheme.textPrimary,
        side: BorderSide(color: AppTheme.AppTheme.borderColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint("Could not launch $url: $e");
    }
  }
}

class AdvancedCodeEditor extends StatefulWidget {
  const AdvancedCodeEditor({super.key});

  @override
  State<AdvancedCodeEditor> createState() => _AdvancedCodeEditorState();
}

class _AdvancedCodeEditorState extends State<AdvancedCodeEditor>
    with TickerProviderStateMixin {
  static final String _rapidApiKey = dotenv.env['API_URL'] ?? '';
  late final CodeController _codeController;
  late TextEditingController _inputController;
  late FocusNode _codeEditorFocusNode;

  bool _isMaximized = false;
  OverlayEntry? _overlayEntry;

  final List<CodeLanguage> _languages = [
    CodeLanguage(
      name: 'Python',
      iconColor: Colors.yellow.shade700,
      icon: Icons.code,
      judgeId: 71,
      languageMode: python,
      template: """#Click the Input button 
#before running the code
def greet(name):
    print(f"Hello, {name}!")

greet("World")
""",
    ),
    CodeLanguage(
      name: 'C++',
      iconColor: Colors.blue.shade400,
      icon: Icons.memory,
      judgeId: 54,
      languageMode: cpp,
      template: """#include <iostream>

int main() {
    std::cout << "Hello, World!";
    return 0;
}
""",
    ),
    CodeLanguage(
      name: 'Java',
      iconColor: Colors.red.shade400,
      icon: Icons.coffee,
      judgeId: 62,
      languageMode: java,
      template: """public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
""",
    ),
    CodeLanguage(
      name: 'JavaScript',
      iconColor: Colors.orange.shade400,
      icon: Icons.javascript,
      judgeId: 63,
      languageMode: javascript,
      template: "console.log('Hello, World!');",
    ),
  ];

  late CodeLanguage _selectedLanguage;
  String _output = '';
  String _error = '';
  bool _isRunning = false;
  String? _currentSubmissionToken;
  Timer? _pollingTimer;
  int _cursorLine = 1;
  int _cursorColumn = 1;
  double _executionTime = 0.0;
  int _memoryUsed = 0;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = _languages.first;
    _codeController = CodeController(
      text: _selectedLanguage.template,
      language: _selectedLanguage.languageMode,
    );
    _inputController = TextEditingController();
    _codeEditorFocusNode = FocusNode();

    _codeController.addListener(_updateCursorPosition);
    _codeEditorFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _codeController.removeListener(_updateCursorPosition);
    _codeController.dispose();
    _inputController.dispose();
    _codeEditorFocusNode.removeListener(_onFocusChange);
    _codeEditorFocusNode.dispose();
    _pollingTimer?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }
  
  void _updateState(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
    if (_isMaximized) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _onFocusChange() {
    if (_codeEditorFocusNode.hasFocus && !_isMaximized) {
      _toggleMaximize();
    }
  }

  void _updateCursorPosition() {
    final selection = _codeController.selection;
    if (selection.baseOffset >= 0) {
      final lines = _codeController.text.substring(0, selection.baseOffset).split('\n');
      _updateState(() {
        _cursorLine = lines.length;
        _cursorColumn = lines.last.length + 1;
      });
    }
  }

  void _toggleMaximize() {
    _updateState(() {
      if (_isMaximized) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isMaximized = false;
      } else {
        _overlayEntry = OverlayEntry(builder: (context) => _buildMaximizedView(context));
        Overlay.of(context).insert(_overlayEntry!);
        _isMaximized = true;
      }
    });
  }

  void _changeLanguage(CodeLanguage language) {
    _updateState(() {
      _selectedLanguage = language;
      _codeController.language = language.languageMode;
      _codeController.text = language.template;
      _output = '';
      _error = '';
      _executionTime = 0.0;
      _memoryUsed = 0;
      _pollingTimer?.cancel();
    });
  }
  
  void _clearOutput() {
    _updateState(() {
      _output = '';
      _error = '';
      _executionTime = 0.0;
      _memoryUsed = 0;
    });
  }

  Future<void> _runCode() async {
    if (_isRunning) return;
    if (_rapidApiKey == 'YOUR_ACTUAL_API_KEY_HERE') {
      _updateState(() {
        _error = '🔑 Please add your RapidAPI key to enable online execution.';
        _isRunning = false;
      });
      return;
    }
    _updateState(() {
      _isRunning = true;
      _output = 'Submitting...';
      _error = '';
      _executionTime = 0.0;
      _memoryUsed = 0;
      _currentSubmissionToken = null;
      _pollingTimer?.cancel();
    });
    try {
      final response = await http.post(
        Uri.parse('https://judge0-ce.p.rapidapi.com/submissions?base64_encoded=false&wait=false'),
        headers: {
          'Content-Type': 'application/json',
          'X-RapidAPI-Key': _rapidApiKey,
          'X-RapidAPI-Host': 'judge0-ce.p.rapidapi.com',
        },
        body: jsonEncode({
          'language_id': _selectedLanguage.judgeId,
          'source_code': _codeController.text,
          'stdin': _inputController.text,
        }),
      );
      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['token'];
        if (!mounted) return;
        _updateState(() => _currentSubmissionToken = token);
        _pollForResults(token);
      } else {
        _handleError('Submission failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      _handleError('API Error: $e');
    }
  }

  void _pollForResults(String token) {
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!mounted || token != _currentSubmissionToken) {
        timer.cancel();
        return;
      }
      try {
        final response = await http.get(
          Uri.parse('https://judge0-ce.p.rapidapi.com/submissions/$token?base64_encoded=false'),
          headers: {
            'Content-Type': 'application/json',
            'X-RapidAPI-Key': _rapidApiKey,
            'X-RapidAPI-Host': 'judge0-ce.p.rapidapi.com',
          },
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final statusId = result['status']['id'];
          if (statusId <= 2) {
            _updateState(() => _output = "Executing... Status: ${result['status']['description']}");
          } else {
            timer.cancel();
            _updateState(() {
              _output = result['stdout'] ?? '';
              _error = result['stderr'] ?? result['compile_output'] ?? '';
              _executionTime = double.tryParse(result['time']?.toString() ?? '0.0') ?? 0.0;
              _memoryUsed = result['memory'] ?? 0;
              _isRunning = false;
            });
            if (_output.isEmpty && _error.isEmpty) {
              _updateState(() => _output = 'Execution successful with no output.');
            }
          }
        }
      } catch (e) {
        timer.cancel();
        _handleError('Polling Error: $e');
      }
    });
  }

  void _handleError(String errorMessage) {
    _updateState(() {
      _error = errorMessage;
      _output = '';
      _isRunning = false;
      _pollingTimer?.cancel();
    });
  }

  void _showInputModal(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text('Program Input (stdin)', style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        content: SizedBox(
          width: 400,
          height: 250,
          child: TextField(
            controller: _inputController,
            autofocus: true,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: GoogleFonts.firaCode(fontSize: 12, color: Colors.white),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.firaCode(color: Colors.grey.shade500, fontSize: 11),
              filled: true,
              fillColor: const Color(0xFF0D1117),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade600)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.blue.shade400)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade600)),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey.shade400))),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white),
            child: Text('Done', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    ).then((_) {
      if (mounted) {
        FocusScope.of(this.context).requestFocus(_codeEditorFocusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _isMaximized,
      child: Container(
        width: 520,
        height: 480,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1E1E1E),
          border: Border.all(color: const Color(0xFF333333)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha:0.8), blurRadius: 40, spreadRadius: 5, offset: const Offset(0, 10)),
            BoxShadow(color: _selectedLanguage.iconColor.withValues(alpha:0.1), blurRadius: 60, spreadRadius: -5),
          ],
        ),
        child: _buildEditorContent(context),
      ),
    );
  }

  Widget _buildMaximizedView(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Material(
          color: const Color(0xFF1E1E1E),
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: _buildEditorContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildEditorContent(BuildContext context) {
    return Column(
      children: [
        _buildTitleBar(),
        _buildTabBar(context),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: _buildCodeEditor()),
              Container(width: 1, color: const Color(0xFF333333)),
              Expanded(flex: 2, child: _buildOutputAndInputPanel()),
            ],
          ),
        ),
        _buildStatusBar(),
      ],
    );
  }

  Widget _buildTitleBar() {
    return Container(
      height: _isMaximized ? 36 : 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D30),
        borderRadius: _isMaximized ? BorderRadius.zero : const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Row(
            children: [
              _buildWindowButton(Colors.red.shade400, onTap: _toggleMaximize),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.yellow.shade400, onTap: () {}),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.green.shade400, onTap: _toggleMaximize),
            ],
          ),
          const SizedBox(width: 16),
          Icon(Icons.code, size: _isMaximized ? 16 : 14, color: _selectedLanguage.iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _isMaximized ? 'Live Code Studio - Full Screen' : 'Live Code Studio',
              style: GoogleFonts.inter(fontSize: _isMaximized ? 13 : 11, color: Colors.white70, fontWeight: _isMaximized ? FontWeight.w500 : FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: _toggleMaximize,
            icon: Icon(_isMaximized ? Icons.fullscreen_exit : Icons.fullscreen, size: _isMaximized ? 18 : 16, color: Colors.grey),
            splashRadius: 16,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: _isMaximized ? 45 : 40,
      color: const Color(0xFF252526),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: _languages.map((lang) => _buildLanguageTab(lang)).toList()),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _buildRunButton(),
                const SizedBox(width: 8),
                _buildInputButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTab(CodeLanguage language) {
    final isSelected = _selectedLanguage.name == language.name;
    return InkWell(
      onTap: () => _changeLanguage(language),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _isMaximized ? 16 : 12, vertical: _isMaximized ? 12 : 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1E1E) : Colors.transparent,
          border: isSelected ? const Border(bottom: BorderSide(color: Colors.blue, width: 2)) : null,
        ),
        child: Row(
          children: [
            Icon(language.icon, size: _isMaximized ? 16 : 14, color: language.iconColor),
            const SizedBox(width: 8),
            Text(language.name, style: GoogleFonts.firaCode(fontSize: _isMaximized ? 13 : 11, color: isSelected ? Colors.white : Colors.white60, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Widget _buildRunButton() {
    return ElevatedButton.icon(
      onPressed: _isRunning ? null : _runCode,
      icon: _isRunning
          ? SizedBox(width: _isMaximized ? 14 : 12, height: _isMaximized ? 14 : 12, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Icon(Icons.play_arrow, size: _isMaximized ? 16 : 14),
      label: Text(_isRunning ? 'Running...' : 'Run'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isRunning ? Colors.grey.shade700 : Colors.green.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: _isMaximized ? 10 : 8, vertical: _isMaximized ? 8 : 6),
        textStyle: GoogleFonts.inter(fontSize: _isMaximized ? 11 : 10, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInputButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showInputModal(context),
      icon: Icon(Icons.input, size: _isMaximized ? 14 : 12),
      label: const Text('Input'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: _isMaximized ? 10 : 8, vertical: _isMaximized ? 8 : 6),
        textStyle: GoogleFonts.inter(fontSize: _isMaximized ? 11 : 10, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF21262D),
            border: Border(bottom: BorderSide(color: Color(0xFF333333))),
          ),
          child: Row(
            children: [
              Icon(Icons.code_rounded, size: _isMaximized ? 16 : 14, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Text('Source Code', style: GoogleFonts.inter(fontSize: _isMaximized ? 13 : 11, color: Colors.white.withValues(alpha:0.9), fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Expanded(
          child: CodeEditorField(
            key: ValueKey(_selectedLanguage.name),
            isMaximized: _isMaximized,
            focusNode: _codeEditorFocusNode,
            controller: _codeController,
          ),
        ),
      ],
    );
  }

  Widget _buildOutputAndInputPanel() {
    return Container(
      color: const Color(0xFF0D1117),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOutputHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(_isMaximized ? 16 : 12),
              child: SingleChildScrollView(child: _buildOutputContent()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputHeader() {
    return Container(
      height: _isMaximized ? 40 : 35,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF21262D),
        border: Border(bottom: BorderSide(color: Color(0xFF333333))),
      ),
      child: Row(
        children: [
          Icon(Icons.terminal, size: _isMaximized ? 16 : 14, color: Colors.green.shade400),
          const SizedBox(width: 8),
          Text(
            'Console Output',
            style: GoogleFonts.inter(fontSize: _isMaximized ? 13 : 11, color: Colors.white.withValues(alpha:0.9), fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          if (_executionTime > 0 || _memoryUsed > 0)
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                runSpacing: 4,
              ),
            ),
          if ((_output.isNotEmpty || _error.isNotEmpty) && !_isRunning) ...[
            const SizedBox(width: 12),
            InkWell(
              onTap: _clearOutput,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.red.shade700, borderRadius: BorderRadius.circular(3)),
                child: Icon(Icons.clear, size: _isMaximized ? 14 : 12, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOutputContent() {
    if (_error.isNotEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.red.shade900.withValues(alpha:0.3), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.red.shade600)),
        child: SelectableText(_error, style: GoogleFonts.firaCode(fontSize: _isMaximized ? 12 : 11, color: Colors.red.shade300, height: 1.6)),
      );
    }
    if (_output.isNotEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.green.shade900.withValues(alpha:0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.green.shade700)),
        child: SelectableText(_output, style: GoogleFonts.firaCode(fontSize: _isMaximized ? 12 : 11, color: Colors.green.shade300, height: 1.6)),
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.rocket_launch, color: Colors.blue.shade300, size: _isMaximized ? 18 : 16),
            const SizedBox(width: 8),
            Text('Live Code!', style: GoogleFonts.inter(fontSize: _isMaximized ? 14 : 12, color: Colors.blue.shade200, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          Text('• Select a language from the tabs above.\n• Click here or start typing to go full-screen.\n• Write your code and hit "Run".', style: GoogleFonts.firaCode(fontSize: _isMaximized ? 11 : 10, color: Colors.grey.shade300, height: 1.8)),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: _isMaximized ? 28 : 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF007ACC),
        borderRadius: _isMaximized ? BorderRadius.zero : const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(_selectedLanguage.icon, size: _isMaximized ? 13 : 12, color: Colors.white),
          const SizedBox(width: 8),
          Text(_selectedLanguage.name, style: GoogleFonts.inter(fontSize: _isMaximized ? 12 : 10, color: Colors.white, fontWeight: FontWeight.w600)),
          const SizedBox(width: 16),
          Icon(Icons.location_on, size: _isMaximized ? 11 : 9, color: Colors.white.withValues(alpha:0.7)),
          const SizedBox(width: 4),
          Text('Ln $_cursorLine, Col $_cursorColumn', style: GoogleFonts.firaCode(fontSize: _isMaximized ? 11 : 9, color: Colors.white.withValues(alpha:0.9))),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: _isRunning ? Colors.orange.shade700 : Colors.green.shade700, borderRadius: BorderRadius.circular(3)),
            child: Text(_isRunning ? '⚡ RUNNING' : '✅ READY', style: GoogleFonts.inter(fontSize: _isMaximized ? 10 : 9, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowButton(Color color, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: _isMaximized ? 12 : 10,
        height: _isMaximized ? 12 : 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class FadeAnimation extends StatefulWidget {
  final Duration delay;
  final Widget child;
  const FadeAnimation({super.key, required this.delay, required this.child});
  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

class CodeEditorField extends StatefulWidget {
  final bool isMaximized;
  final FocusNode focusNode;
  final CodeController controller;

  const CodeEditorField({super.key, required this.isMaximized, required this.focusNode, required this.controller});

  @override
  State<CodeEditorField> createState() => _CodeEditorFieldState();
}

class _CodeEditorFieldState extends State<CodeEditorField> {
  String _previousTextForAutoPairing = '';
  TextSelection _previousSelectionForAutoPairing = const TextSelection.collapsed(offset: -1);

  @override
  void initState() {
    super.initState();
    _previousTextForAutoPairing = widget.controller.text;
    _previousSelectionForAutoPairing = widget.controller.selection;
    widget.controller.addListener(_onTextChanged);
  }
  
  @override
  void didUpdateWidget(CodeEditorField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      _previousTextForAutoPairing = widget.controller.text;
      _previousSelectionForAutoPairing = widget.controller.selection;
      widget.controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.text;
    final selection = widget.controller.selection;
    if (text.length == _previousTextForAutoPairing.length && selection != _previousSelectionForAutoPairing) {
      _previousTextForAutoPairing = text;
      _previousSelectionForAutoPairing = selection;
      return;
    }
    if (text.length != _previousTextForAutoPairing.length + 1 || !selection.isCollapsed) {
      _previousTextForAutoPairing = text;
      _previousSelectionForAutoPairing = selection;
      return;
    }
    const pairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'"};
    final typedCharIndex = selection.base.offset - 1;
    if (typedCharIndex < 0) {
      _previousTextForAutoPairing = text;
      _previousSelectionForAutoPairing = selection;
      return;
    }
    final typedChar = text[typedCharIndex];
    final closingChar = pairs[typedChar];
    if (closingChar != null) {
      widget.controller.removeListener(_onTextChanged);
      final newText = text.substring(0, selection.base.offset) + closingChar + text.substring(selection.base.offset);
      widget.controller.value = widget.controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.base.offset),
        composing: TextRange.empty,
      );
      widget.controller.addListener(_onTextChanged);
    }
    _previousTextForAutoPairing = widget.controller.text;
    _previousSelectionForAutoPairing = widget.controller.selection;
  }

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: CodeField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textStyle: GoogleFonts.firaCode(fontSize: widget.isMaximized ? 14 : 12, height: 1.5),
        expands: true,
        wrap: false,
        lineNumbers: true,
      ),
    );
  }
}