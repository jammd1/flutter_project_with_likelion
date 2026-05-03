import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/providers/trip_planning_provider.dart';
import 'package:provider/provider.dart';

class CreatePlanWidget extends StatefulWidget {
  const CreatePlanWidget({super.key});

  @override
  State<CreatePlanWidget> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlanWidget> {
  final TextEditingController _dController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  late TripPlanningProvider _provider;
  int days = 1;
  String budget = '';
  static final List<String> _companionOptions = ['혼자', '친구', '연인', '가족'];
  static final List<String> _styleOptions = [
    '빡빡한 일정',
    '여유/휴식',
    '핫플 위주',
    '자연/힐링',
    '맛집 투어',
    '문화 체험',
    '하이킹',
    '등산'
  ];
  static final List<String> _foodPrefsOptions = [
    '로컬 맛집',
    '가성비',
    '파인다이닝',
    '카페 투어',
    '채식 위주',
    '육식 위주',
  ];

  String _selectedCompanionOpt = '';
  String _selectedStyleOpt = '';
  final Set<String> _selectedFoodPrefsOpts = {};

  double _progress = 0.0;
  Timer? _progressTimer;

  void _startProgress() {
    _progress = 0.0;
    _progressTimer = Timer.periodic(Duration(milliseconds: 300), (_) {
      if (_progress < 0.85) {
        setState(() => _progress += 0.02);
      }
    });
  }

  void _stopProgress() {
    _progressTimer?.cancel();
    setState(() => _progress = 1.0);
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) setState(() => _progress = 0.0);
    });
  }

  void _onGenerate(BuildContext context) {
    if (_dController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('목적지를 입력해주세요.')));
      return;
    }
    if (_selectedCompanionOpt.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('누구와 가시는 지 선택해주세요.')));
      return;
    }
    if (_selectedFoodPrefsOpts.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('선호하는 식사 스타일을 선택해주세요.')));
      return;
    }
    if (_selectedStyleOpt.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('선호하는 여행 스타일을 선택해주세요.')));
      return;
    }
    if (_bController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('예산을 입력해주세요.')));
      return;
    }

    _startProgress();
    context.read<TripPlanningProvider>().generateAndSavePlan(
      destination: _dController.text,
      days: days,
      companion: _selectedCompanionOpt,
      style: _selectedStyleOpt,
      foodPrefs: _selectedFoodPrefsOpts.toList(),
      budget: _bController.text,
    ).whenComplete(() {
      _stopProgress();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.done_outline, color: Colors.lightBlue),
                Text('일정이 생성되었어요. 내 일정을 확인해주세요.'),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = context.read<TripPlanningProvider>();
      _provider.addListener(_onError);
    });
  }

  void _onError() {
    if (!mounted) return;
    final error = context.read<TripPlanningProvider>().error;
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      context.read<TripPlanningProvider>().clearError();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _progressTimer?.cancel();
    _provider.removeListener(_onError);
    _dController.dispose();
    _bController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            '1. 어디로 가시나요? (필수)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            cursorColor: Colors.lightBlueAccent,
            controller: _dController,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: '(ex: 일본 오사카)',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.flight_takeoff),
              prefixIconColor: WidgetStateColor.resolveWith((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.focused)) {
                  return Colors.lightBlueAccent;
                }
                return Theme.of(context).iconTheme.color!;
              }),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '2. 얼마나 있을 예정인가요? (1일 이상)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (days > 1) days--;
                  });
                },
                icon: Icon(Icons.remove, size: 30, color: Colors.redAccent,),
              ),
              SizedBox(width: 20),
              Text(
                days.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 5),
              Text('(일)', style: TextStyle(fontSize: 15)),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  setState(() {
                    days++;
                  });
                },
                icon: Icon(Icons.add, size: 30, color: Colors.lightBlueAccent,),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            '3. 누구와 가시나요? (필수)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Wrap(
              spacing: 22,
              children: _companionOptions.map((e) {
                return ChoiceChip(
                  showCheckmark: false,
                  selectedColor: Colors.lightBlueAccent,
                  label: Text(e, style: TextStyle(fontWeight: FontWeight.w700)),
                  selected: _selectedCompanionOpt == e,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCompanionOpt = e;

                      });
                    }
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '4. 어떤 스타일의 여행을 선호하시나요?\n    (필수)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Wrap(
              spacing: 12,
              children: _styleOptions.map((e) {
                return ChoiceChip(
                  showCheckmark: false,
                  selectedColor: Colors.lightBlueAccent,
                  label: Text(e, style: TextStyle(fontWeight: FontWeight.w700)),
                  selected: _selectedStyleOpt == e,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedStyleOpt = e;

                      });
                    }
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '5. 어떤 스타일의 식사를 선호하시나요? \n    (필수) (다중 선택 가능)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Wrap(
              spacing: 20,
              children: _foodPrefsOptions.map((e) {
                return FilterChip(
                  showCheckmark: false,
                  selectedColor: Colors.lightBlueAccent,
                  label: Text(e, style: TextStyle(fontWeight: FontWeight.w700)),
                  selected: _selectedFoodPrefsOpts.contains(e),
                  onSelected: (selected) {
                    setState(() {
                      selected
                          ? _selectedFoodPrefsOpts.add(e)
                          : _selectedFoodPrefsOpts.remove(e);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '6. 마지막으로 예산을 입력해주세요.(필수)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            cursorColor: Colors.lightBlueAccent,
            controller: _bController,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: '(ex: 500만원)',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
              prefixIconColor: WidgetStateColor.resolveWith((
                  Set<WidgetState> states,
                  ) {
                if (states.contains(WidgetState.focused)) {
                  return Colors.lightBlueAccent;
                }
                return Theme.of(context).iconTheme.color!;
              }),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
            ),
          ),
          SizedBox(height: 24),
          if (_progress > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('일정 생성 중...', style: TextStyle(color: Colors.grey)),
                Text('${(_progress * 100).toInt()}%',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 8,
                backgroundColor: Colors.grey.withAlpha(20),
                valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent),
              ),
            ),
            SizedBox(height: 16),
          ],
          Consumer<TripPlanningProvider>(
            builder: (context, provider, child) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : () => _onGenerate(context),
                  child: Text(
                    'AI 일정 생성하기',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
