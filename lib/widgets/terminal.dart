import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';

class Terminal extends StatefulWidget {
  final bool isMaximized;
  final VoidCallback? onToggleMaximize;

  const Terminal({
    super.key,
    this.isMaximized = false,
    this.onToggleMaximize,
  });

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> with TickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  
  final List<TerminalLine> _lines = [];
  final List<String> _commandHistory = [];
  int _historyIndex = -1;
  String _currentInput = '';
  String _currentDirectory = '~';
  Map<String, dynamic> _fileSystem = {};
  
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;
  
  final List<String> _availableCommands = [
    'help', 'about', 'skills', 'projects', 'contact', 'clear', 'ls', 'cd',
    'cat', 'whoami', 'pwd', 'history', 'theme', 'social', 'resume', 'joke',
    'date', 'uptime', 'neofetch', 'tree', 'exit'
  ];

  @override
  void initState() {
    super.initState();
    _initializeFileSystem();
    _initializeTerminal();
    _initializeCursorAnimation();
  }

  void _initializeCursorAnimation() {
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _cursorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cursorController, curve: Curves.easeInOut),
    );
    _cursorController.repeat(reverse: true);
  }

  void _initializeFileSystem() {
    final projects = DataService.getProjects();
    final skills = DataService.getCategorizedSkills();
    
    _fileSystem = {
      'home': {
        'type': 'directory',
        'contents': {
          'projects': {
            'type': 'directory',
            'contents': {
              for (var project in projects)
                '${project.name.toLowerCase().replaceAll(' ', '_')}.md': {
                  'type': 'file',
                  'content': _generateProjectFile(project),
                }
            }
          },
          'skills': {
            'type': 'directory',
            'contents': {
              for (var category in skills.keys)
                '${category.toLowerCase().replaceAll(' & ', '_').replaceAll(' ', '_')}.txt': {
                  'type': 'file',
                  'content': skills[category]!.map((s) => s.name).join(', '),
                }
            }
          },
          'about.txt': {
            'type': 'file',
            'content': 'Akshat Singh - Flutter Developer\n\nPassionate developer creating beautiful mobile applications with Flutter.\nCurrently pursuing Computer Science at DTU, focusing on cutting-edge software development and machine learning.',
          },
          'contact.txt': {
            'type': 'file',
            'content': 'Email: akshatsingh2474@gmail.com\nGitHub: https://github.com/akshat2474\nLinkedIn: https://www.linkedin.com/in/akshat-singh-48a03b312',
          },
          'resume.pdf': {
            'type': 'file',
            'content': 'PDF file - Use "resume" command to download',
          }
        }
      }
    };
  }

  String _generateProjectFile(project) {
    return '''# ${project.name}

## Overview
${project.overview}

## Key Features
${project.keyFeatures.map((f) => '• $f').join('\n')}

## Technical Details
${project.technicalDetails}

## Technologies
${project.technologies.join(', ')}

## Links
${project.liveUrl != null ? 'Live Demo: ${project.liveUrl}' : ''}
${project.githubUrl != null ? 'Source Code: ${project.githubUrl}' : ''}
''';
  }

  void _initializeTerminal() {
    _addLine('', TerminalLineType.system);
    _addLine('Welcome to Akshat\'s Portfolio Terminal!', TerminalLineType.success);
    _addLine('Type "help" to see available commands.', TerminalLineType.info);
    _addLine('', TerminalLineType.system);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  void _addLine(String text, TerminalLineType type, {String? prompt}) {
    setState(() {
      _lines.add(TerminalLine(
        text: text,
        type: type,
        prompt: prompt ?? (type == TerminalLineType.input ? _getPrompt() : null),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getPrompt() {
    return 'akshat@portfolio:$_currentDirectory\$ ';
  }

  void _handleCommand(String input) {
    if (input.trim().isEmpty) return;

    // Add input to history
    _commandHistory.add(input);
    _historyIndex = -1;

    // Add command to terminal
    _addLine(input, TerminalLineType.input);

    // Parse and execute command
    final parts = input.trim().split(' ');
    final command = parts[0].toLowerCase();
    final args = parts.skip(1).toList();

    _executeCommand(command, args);
  }

  void _executeCommand(String command, List<String> args) {
    switch (command) {
      case 'help':
        _handleHelp();
        break;
      case 'about':
        _handleAbout();
        break;
      case 'skills':
        _handleSkills(args);
        break;
      case 'projects':
        _handleProjects(args);
        break;
      case 'contact':
        _handleContact();
        break;
      case 'social':
        _handleSocial();
        break;
      case 'clear':
        _handleClear();
        break;
      case 'ls':
        _handleLs(args);
        break;
      case 'cd':
        _handleCd(args);
        break;
      case 'cat':
        _handleCat(args);
        break;
      case 'pwd':
        _handlePwd();
        break;
      case 'whoami':
        _handleWhoami();
        break;
      case 'history':
        _handleHistory();
        break;
      case 'theme':
        _handleTheme();
        break;
      case 'resume':
        _handleResume();
        break;
      case 'date':
        _handleDate();
        break;
      case 'uptime':
        _handleUptime();
        break;
      case 'neofetch':
        _handleNeofetch();
        break;
      case 'tree':
        _handleTree();
        break;
      case 'joke':
        _handleJoke();
        break;
      case 'exit':
        _handleExit();
        break;
      default:
        _addLine('Command not found: $command', TerminalLineType.error);
        _addLine('Type "help" to see available commands.', TerminalLineType.info);
    }
  }

  void _handleHelp() {
    _addLine('Available commands:', TerminalLineType.success);
    _addLine('', TerminalLineType.system);
    
    final commands = {
      'help': 'Show this help message',
      'about': 'About Akshat Singh',
      'skills [category]': 'List technical skills',
      'projects [name]': 'Show projects',
      'contact': 'Contact information',
      'social': 'Social media links',
      'resume': 'Download resume',
      'clear': 'Clear terminal',
      'ls [path]': 'List directory contents',
      'cd <path>': 'Change directory',
      'cat <file>': 'Display file contents',
      'pwd': 'Print working directory',
      'whoami': 'Display current user',
      'history': 'Show command history',
      'theme': 'Toggle theme',
      'date': 'Show current date',
      'uptime': 'Show system uptime',
      'neofetch': 'Show system info',
      'tree': 'Display directory tree',
      'joke': 'Random programming joke',
      'exit': 'Close terminal',
    };
    
    for (final entry in commands.entries) {
      _addLine('  ${entry.key.padRight(20)} ${entry.value}', TerminalLineType.output);
    }
  }

  void _handleAbout() {
    _addLine('About Akshat Singh', TerminalLineType.success);
    _addLine('', TerminalLineType.system);
    _addLine('🚀 Flutter Developer & Computer Science Student', TerminalLineType.output);
    _addLine('🎓 Studying at Delhi Technological University (DTU)', TerminalLineType.output);
    _addLine('💡 Passionate about mobile app development and ML', TerminalLineType.output);
    _addLine('🔧 Creating beautiful, high-performance applications', TerminalLineType.output);
    _addLine('', TerminalLineType.system);
    _addLine('Currently focusing on cutting-edge software development', TerminalLineType.output);
    _addLine('and machine learning technologies.', TerminalLineType.output);
  }

  void _handleSkills(List<String> args) {
    final skills = DataService.getCategorizedSkills();
    
    if (args.isEmpty) {
      _addLine('Technical Skills:', TerminalLineType.success);
      _addLine('', TerminalLineType.system);
      
      for (final category in skills.keys) {
        _addLine('📁 $category:', TerminalLineType.info);
        for (final skill in skills[category]!) {
          _addLine('  • ${skill.name}', TerminalLineType.output);
        }
        _addLine('', TerminalLineType.system);
      }
    } else {
      final category = args.join(' ');
      final matchedCategory = skills.keys.firstWhere(
        (k) => k.toLowerCase().contains(category.toLowerCase()),
        orElse: () => '',
      );
      
      if (matchedCategory.isNotEmpty) {
        _addLine('$matchedCategory:', TerminalLineType.success);
        for (final skill in skills[matchedCategory]!) {
          _addLine('  • ${skill.name}', TerminalLineType.output);
        }
      } else {
        _addLine('Category not found: $category', TerminalLineType.error);
      }
    }
  }

  void _handleProjects(List<String> args) {
    final projects = DataService.getProjects();
    
    if (args.isEmpty) {
      _addLine('Featured Projects:', TerminalLineType.success);
      _addLine('', TerminalLineType.system);
      
      for (final project in projects) {
        _addLine('🚀 ${project.name}', TerminalLineType.info);
        _addLine('   ${project.overview}', TerminalLineType.output);
        _addLine('   Technologies: ${project.technologies.take(3).join(', ')}', TerminalLineType.output);
        if (project.liveUrl != null) {
          _addLine('   Live: ${project.liveUrl}', TerminalLineType.output);
        }
        _addLine('', TerminalLineType.system);
      }
    } else {
      final projectName = args.join(' ');
      final project = projects.firstWhere(
        (p) => p.name.toLowerCase().contains(projectName.toLowerCase()),
        orElse: () => projects.first,
      );
      
      _addLine('Project: ${project.name}', TerminalLineType.success);
      _addLine('', TerminalLineType.system);
      _addLine(project.overview, TerminalLineType.output);
      _addLine('', TerminalLineType.system);
      _addLine('Key Features:', TerminalLineType.info);
      for (final feature in project.keyFeatures) {
        _addLine('• $feature', TerminalLineType.output);
      }
      _addLine('', TerminalLineType.system);
      _addLine('Technologies: ${project.technologies.join(', ')}', TerminalLineType.output);
      if (project.liveUrl != null) {
        _addLine('Live Demo: ${project.liveUrl}', TerminalLineType.output);
      }
      if (project.githubUrl != null) {
        _addLine('Source Code: ${project.githubUrl}', TerminalLineType.output);
      }
    }
  }

  void _handleContact() {
    _addLine('Contact Information:', TerminalLineType.success);
    _addLine('', TerminalLineType.system);
    _addLine('📧 Email: akshatsingh2474@gmail.com', TerminalLineType.output);
    _addLine('💼 LinkedIn: linkedin.com/in/akshat-singh-48a03b312', TerminalLineType.output);
    _addLine('🐙 GitHub: github.com/akshat2474', TerminalLineType.output);
    _addLine('', TerminalLineType.system);
    _addLine('Feel free to reach out for collaborations or opportunities!', TerminalLineType.info);
  }

  void _handleSocial() {
    _addLine('Social Media & Profiles:', TerminalLineType.success);
    _addLine('', TerminalLineType.system);
    
    final links = {
      'GitHub': 'https://github.com/akshat2474',
      'LinkedIn': 'https://www.linkedin.com/in/akshat-singh-48a03b312',
      'Lichess': 'https://lichess.org/@/akshat2474',
      'Chess.com': 'https://www.chess.com/member/akshat2474',
    };
    
    for (final entry in links.entries) {
      _addLine('${entry.key}: ${entry.value}', TerminalLineType.output);
    }
  }

  void _handleClear() {
    setState(() {
      _lines.clear();
    });
  }

  void _handleLs(List<String> args) {
    // Simplified ls implementation
    _addLine('Projects/', TerminalLineType.info);
    _addLine('Skills/', TerminalLineType.info);
    _addLine('about.txt', TerminalLineType.output);
    _addLine('contact.txt', TerminalLineType.output);
    _addLine('resume.pdf', TerminalLineType.output);
  }

  void _handleCd(List<String> args) {
    if (args.isEmpty) {
      _currentDirectory = '~';
    } else {
      final path = args[0];
      if (path == '..') {
        _currentDirectory = '~';
      } else if (['projects', 'skills'].contains(path.toLowerCase())) {
        _currentDirectory = '~/$path';
      } else {
        _addLine('Directory not found: $path', TerminalLineType.error);
        return;
      }
    }
    _addLine('Changed directory to $_currentDirectory', TerminalLineType.success);
  }

  void _handleCat(List<String> args) {
    if (args.isEmpty) {
      _addLine('Usage: cat <filename>', TerminalLineType.error);
      return;
    }
    
    final filename = args[0];
    switch (filename.toLowerCase()) {
      case 'about.txt':
        _handleAbout();
        break;
      case 'contact.txt':
        _handleContact();
        break;
      case 'resume.pdf':
        _addLine('This is a binary file. Use "resume" command to download.', TerminalLineType.info);
        break;
      default:
        _addLine('File not found: $filename', TerminalLineType.error);
    }
  }

  void _handlePwd() {
    _addLine('/home/akshat/portfolio$_currentDirectory', TerminalLineType.output);
  }

  void _handleWhoami() {
    _addLine('akshat', TerminalLineType.output);
  }

  void _handleHistory() {
    _addLine('Command History:', TerminalLineType.success);
    for (int i = 0; i < _commandHistory.length; i++) {
      _addLine('${i + 1}  ${_commandHistory[i]}', TerminalLineType.output);
    }
  }

  void _handleTheme() {
    // This would need to be connected to your theme notifier
    _addLine('Theme toggle feature - implement theme switching here', TerminalLineType.info);
  }

  void _handleResume() {
    _addLine('Downloading resume...', TerminalLineType.success);
    _launchUrl('assets/assets/resume/Resume.pdf');
  }

  void _handleDate() {
    final now = DateTime.now();
    _addLine(now.toString(), TerminalLineType.output);
  }

  void _handleUptime() {
    _addLine('System uptime: Portfolio running since page load', TerminalLineType.output);
  }

  void _handleNeofetch() {
    _addLine('', TerminalLineType.system);
    _addLine('     ██████████████     akshat@portfolio', TerminalLineType.success);
    _addLine('   ██                ██ ─────────────────', TerminalLineType.success);
    _addLine('  ██    ████████    ██  OS: Portfolio Web', TerminalLineType.output);
    _addLine(' ██    ██      ██    ██ Host: Flutter Web', TerminalLineType.output);
    _addLine(' ██    ██      ██    ██ Theme: ${AppTheme.primaryColor}', TerminalLineType.output);
    _addLine(' ██    ████████    ██  Shell: terminal.dart', TerminalLineType.output);
    _addLine('  ██                ██  Skills: Flutter, Python, C++', TerminalLineType.output);
    _addLine('   ██              ██   Location: Delhi, India', TerminalLineType.output);
    _addLine('     ██████████████     University: DTU', TerminalLineType.output);
    _addLine('', TerminalLineType.system);
  }

  void _handleTree() {
    _addLine('Portfolio Structure:', TerminalLineType.success);
    _addLine('├── Projects/', TerminalLineType.output);
    _addLine('│   ├── CarbonEye', TerminalLineType.output);
    _addLine('│   ├── Color Harmony', TerminalLineType.output);
    _addLine('│   ├── RetroDash', TerminalLineType.output);
    _addLine('│   └── Hand2Hand', TerminalLineType.output);
    _addLine('├── Skills/', TerminalLineType.output);
    _addLine('│   ├── Languages', TerminalLineType.output);
    _addLine('│   ├── Frameworks', TerminalLineType.output);
    _addLine('│   └── Tools', TerminalLineType.output);
    _addLine('├── about.txt', TerminalLineType.output);
    _addLine('├── contact.txt', TerminalLineType.output);
    _addLine('└── resume.pdf', TerminalLineType.output);
  }

  void _handleJoke() {
    final jokes = [
      'Why do programmers prefer dark mode? Because light attracts bugs!',
      'How many programmers does it take to change a light bulb? None, that\'s a hardware problem.',
      'Why do Java developers wear glasses? Because they can\'t C#!',
      '99 little bugs in the code, 99 little bugs. Take one down, patch it around, 117 little bugs in the code.',
      'A SQL query goes into a bar, walks up to two tables and asks... "Can I join you?"',
    ];
    final joke = jokes[Random().nextInt(jokes.length)];
    _addLine(joke, TerminalLineType.success);
  }

  void _handleExit() {
    if (widget.isMaximized) {
      widget.onToggleMaximize?.call();
    }
    _addLine('Goodbye! Thanks for visiting my portfolio! 👋', TerminalLineType.success);
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      _addLine('Could not launch $url', TerminalLineType.error);
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _navigateHistory(-1);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _navigateHistory(1);
      } else if (event.logicalKey == LogicalKeyboardKey.tab) {
        _handleTabCompletion();
      }
    }
  }

  void _navigateHistory(int direction) {
    if (_commandHistory.isEmpty) return;

    if (_historyIndex == -1) {
      _currentInput = _inputController.text;
    }

    _historyIndex += direction;
    _historyIndex = _historyIndex.clamp(-1, _commandHistory.length - 1);

    if (_historyIndex == -1) {
      _inputController.text = _currentInput;
    } else {
      _inputController.text = _commandHistory[_commandHistory.length - 1 - _historyIndex];
    }
    
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: _inputController.text.length),
    );
  }

  void _handleTabCompletion() {
    final input = _inputController.text;
    final matches = _availableCommands.where((cmd) => cmd.startsWith(input)).toList();
    
    if (matches.length == 1) {
      _inputController.text = matches.first;
      _inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: _inputController.text.length),
      );
    } else if (matches.length > 1) {
      _addLine('Available commands:', TerminalLineType.info);
      _addLine(matches.join('  '), TerminalLineType.output);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(widget.isMaximized ? 0 : 12),
        border: Border.all(
          color: AppTheme.borderColor,
          width: widget.isMaximized ? 0 : 1,
        ),
      ),
      child: Column(
        children: [
          _buildTerminalHeader(),
          Expanded(child: _buildTerminalBody()),
          _buildTerminalInput(),
        ],
      ),
    );
  }

  Widget _buildTerminalHeader() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.isMaximized ? 0 : 12),
        ),
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Window controls
            Row(
              children: [
                _buildWindowButton(Colors.red, onTap: widget.onToggleMaximize),
                const SizedBox(width: 6),
                _buildWindowButton(Colors.yellow, onTap: () {}),
                const SizedBox(width: 6),
                _buildWindowButton(Colors.green, onTap: widget.onToggleMaximize),
              ],
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.terminal,
              size: 16,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Terminal - Akshat\'s Portfolio',
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (widget.onToggleMaximize != null)
              IconButton(
                onPressed: widget.onToggleMaximize,
                icon: Icon(
                  widget.isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
                splashRadius: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWindowButton(Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTerminalBody() {
    return Container(
      color: AppTheme.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _lines.length,
        itemBuilder: (context, index) {
          final line = _lines[index];
          return _buildTerminalLine(line);
        },
      ),
    );
  }

  Widget _buildTerminalLine(TerminalLine line) {
    Color textColor;
    switch (line.type) {
      case TerminalLineType.input:
        textColor = AppTheme.textPrimary;
        break;
      case TerminalLineType.output:
        textColor = AppTheme.textSecondary;
        break;
      case TerminalLineType.error:
        textColor = AppTheme.accentRed;
        break;
      case TerminalLineType.success:
        textColor = AppTheme.accentGreen;
        break;
      case TerminalLineType.info:
        textColor = AppTheme.accentBlue;
        break;
      case TerminalLineType.system:
        textColor = AppTheme.textMuted;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: SelectableText.rich(
        TextSpan(
          children: [
            if (line.prompt != null)
              TextSpan(
                text: line.prompt,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            TextSpan(
              text: line.text,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: textColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            _getPrompt(),
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: _handleKeyEvent,
              child: TextField(
                controller: _inputController,
                focusNode: _focusNode,
                autofocus: true,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a command...',
                  hintStyle: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                  ),
                ),
                onSubmitted: (input) {
                  _handleCommand(input);
                  _inputController.clear();
                  _focusNode.requestFocus();
                },
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _cursorAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _cursorAnimation.value,
                child: Container(
                  width: 8,
                  height: 16,
                  color: AppTheme.primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

enum TerminalLineType {
  input,
  output,
  error,
  success,
  info,
  system,
}

class TerminalLine {
  final String text;
  final TerminalLineType type;
  final String? prompt;

  TerminalLine({
    required this.text,
    required this.type,
    this.prompt,
  });
}
