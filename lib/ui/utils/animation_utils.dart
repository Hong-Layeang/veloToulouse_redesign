import 'package:flutter/material.dart';

// SwipeToRentControl - Swipe gesture to confirm bike rental
class SwipeToRentControl extends StatefulWidget {
  final VoidCallback onSwipeComplete;
  final VoidCallback? onSwipeBlocked;
  final bool enabled;
  final String? blockedMessage;
  final String label;

  const SwipeToRentControl({
    super.key,
    required this.onSwipeComplete,
    this.onSwipeBlocked,
    this.enabled = true,
    this.blockedMessage,
    this.label = 'Swipe to Rent',
  });

  @override
  State<SwipeToRentControl> createState() => _SwipeToRentControlState();
}

class _SwipeToRentControlState extends State<SwipeToRentControl>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _dragPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxDistance) {
    setState(() {
      _dragPosition = (details.globalPosition.dx).clamp(0.0, maxDistance);
    });
  }

  void _handleDragEnd(double maxDistance) {
    if (_dragPosition > maxDistance * 0.85) {
      if (!widget.enabled) {
        setState(() => _dragPosition = 0.0);
        widget.onSwipeBlocked?.call();
        return;
      }

      // Completed swipe
      widget.onSwipeComplete();
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _dragPosition = 0.0);
          _animationController.reverse();
        }
      });
    } else {
      // Reset
      setState(() => _dragPosition = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 40; // Padding

    return GestureDetector(
      onHorizontalDragUpdate: (details) =>
          _handleDragUpdate(details, screenWidth),
      onHorizontalDragEnd: (_) => _handleDragEnd(screenWidth),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: widget.enabled
              ? const Color(0xFFF4F8FA)
              : const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.enabled
                ? const Color(0xFFE2E2E2)
                : const Color(0xFFD7D7D7),
          ),
        ),
        child: Stack(
          children: [
            // Background progress
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: _dragPosition / screenWidth,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFE8651A),
                  ),
                  minHeight: 60,
                ),
              ),
            ),
            // Label text
            Center(
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: Color(0xFF708C91),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Draggable thumb
            Positioned(
              left: _dragPosition,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 56,
                  height: 56,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8651A),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE8651A).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
    );
  }
}
