import 'package:flutter/material.dart';
import '../../../../models/bike.dart';
import '../../../theme/app_theme.dart';
import '../../../states/subscription_state.dart';
import '../../subscription/subscriptions_screen.dart';
import '../../subscription/confirmation_screen.dart';

class SwipeToRent extends StatefulWidget {
  final Bike bike;
  final SubscriptionState subscriptionState;
  const SwipeToRent({super.key, required this.bike, required this.subscriptionState});

  @override
  State<SwipeToRent> createState() => _SwipeToRentState();
}

class _SwipeToRentState extends State<SwipeToRent>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _rented = false;
  late AnimationController _resetController;
  static const double _height = 56;
  static const double _thumbSize = 48;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(covariant SwipeToRent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bike.id != widget.bike.id) {
      _rented = false;
      _dragPosition = 0;
      _resetController.reset();
    }
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _animateReset() {
    final start = _dragPosition;
    _resetController.reset();
    _resetController.addListener(() {
      setState(() {
        _dragPosition = start * (1 - _resetController.value);
      });
    });
    _resetController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final maxDrag = MediaQuery.of(context).size.width - 40 - _thumbSize - 8;

    if (_rented) {
      return Container(
        height: _height,
        decoration: BoxDecoration(
          color: AppTheme.green,
          borderRadius: BorderRadius.circular(_height / 2),
        ),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                'Bike Rented!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Selected bike summary
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.pedal_bike,
                color: AppTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                widget.bike.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              const Text(
                'Ready to rent',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
        // Swipe slider
        Container(
          height: _height,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(_height / 2),
            border: Border.all(color: AppTheme.divider),
          ),
          child: Stack(
            children: [
              // Fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 50),
                height: _height,
                width: _dragPosition + _thumbSize + 8,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(_height / 2),
                ),
              ),
              // Label
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 48),
                    Text(
                      'Swipe to Rent',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Thumb
              Positioned(
                left: 4 + _dragPosition,
                top: 4,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_rented) return;
                    setState(() {
                      _dragPosition =
                          (_dragPosition + details.delta.dx).clamp(0.0, maxDrag);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_rented) return;
                    if (_dragPosition > maxDrag * 0.8) {
                      // Check subscription before completing the rental
                      if (!widget.subscriptionState.hasActiveSubscription) {
                        _animateReset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SubscriptionsScreen(
                              subscriptionState: widget.subscriptionState,
                              onSubscribed: () {
                                // After subscribing, user returns to map
                              },
                            ),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _dragPosition = maxDrag;
                        _rented = true;
                      });
                      // Navigate to confirmation screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ConfirmationScreen(
                            plan: widget.subscriptionState.activeSubscription!.plan,
                            onFinish: () {
                              Navigator.of(context).popUntil(
                                (route) => route.isFirst,
                              );
                            },
                          ),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        if (mounted) {
                          setState(() {
                            _rented = false;
                            _dragPosition = 0;
                          });
                        }
                      });
                    } else {
                      _animateReset();
                    }
                  },
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
