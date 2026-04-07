import 'package:flutter/material.dart';
import '../../../domain/entities/staff_reservation.dart';
import '../../../domain/entities/staff_table.dart';
import 'timeline_constants.dart';
import 'timeline_grid_painter.dart';
import 'reservation_block.dart';

/// A horizontally scrollable timeline grid showing all active reservations for
/// a given day, organised by table row, with a current-time indicator when
/// viewing today.
class ReservationTimelineView extends StatefulWidget {
  final List<StaffTable> tables;
  final List<StaffReservation> reservations;
  final String openAt;
  final String closeAt;
  final String selectedDate;
  final String? actionInProgressId;
  final void Function(StaffReservation reservation)? onTapReservation;

  const ReservationTimelineView({
    super.key,
    required this.tables,
    required this.reservations,
    required this.openAt,
    required this.closeAt,
    required this.selectedDate,
    this.actionInProgressId,
    this.onTapReservation,
  });

  @override
  State<ReservationTimelineView> createState() =>
      _ReservationTimelineViewState();
}

class _ReservationTimelineViewState extends State<ReservationTimelineView> {
  late ScrollController _horizontalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToCurrentTime());
  }

  @override
  void didUpdateWidget(covariant ReservationTimelineView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tables != widget.tables ||
        oldWidget.openAt != widget.openAt) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollToCurrentTime());
    }
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  bool get _isToday {
    final now = DateTime.now();
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return widget.selectedDate == today;
  }

  void _scrollToCurrentTime() {
    if (!_horizontalController.hasClients) return;
    if (!_isToday) return;
    final now = TimeOfDay.now();
    final open = _parseTime(widget.openAt);
    final nowMinutes = now.hour * 60 + now.minute;
    final openMinutes = open.hour * 60 + open.minute;
    final offsetMinutes = nowMinutes - openMinutes;
    const pxPadding = (30 / 60.0) * TimelineConstants.pixelsPerHour;
    final targetPx =
        pxPadding + (offsetMinutes / 60.0) * TimelineConstants.pixelsPerHour;
    final viewportWidth = MediaQuery.of(context).size.width - TimelineConstants.tableLabelWidth;
    final scrollTo = (targetPx - viewportWidth * 0.25)
        .clamp(0.0, _horizontalController.position.maxScrollExtent);
    _horizontalController.animateTo(
      scrollTo,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    final open = _parseTime(widget.openAt);
    final close = _parseTime(widget.closeAt);
    final totalHours =
        (close.hour * 60 + close.minute - open.hour * 60 - open.minute) / 60.0;
    final paddingMinutes = 30;
    final paddingPx = (paddingMinutes / 60.0) * TimelineConstants.pixelsPerHour;
    final totalWidth = totalHours * TimelineConstants.pixelsPerHour + 2 * paddingPx;
    final totalHeight =
        widget.tables.length * TimelineConstants.rowHeight;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: TimelineConstants.tableLabelWidth,
          child: Column(
            children: [
              const SizedBox(height: TimelineConstants.headerHeight),
              ...widget.tables.map(
                (t) => Container(
                  height: TimelineConstants.rowHeight,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8, right: 4),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Text(
                    t.label,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: Column(
                children: [
                  _TimelineHeader(
                    openHour: open.hour,
                    openMinute: open.minute,
                    totalHours: totalHours.ceil(),
                    pixelsPerHour: TimelineConstants.pixelsPerHour,
                    paddingPx: paddingPx,
                  ),
                  SizedBox(
                    height: totalHeight,
                    width: totalWidth,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: paddingPx),
                          child: CustomPaint(
                            size: Size(totalWidth - 2 * paddingPx, totalHeight),
                            painter: TimelineGridPainter(
                              tableCount: widget.tables.length,
                              rowHeight: TimelineConstants.rowHeight,
                              pixelsPerHour: TimelineConstants.pixelsPerHour,
                              totalHours: totalHours,
                            ),
                          ),
                        ),
                        ..._buildReservationBlocks(open, totalWidth, paddingPx),
                        if (_isToday)
                          _buildCurrentTimeIndicator(open, totalHeight, paddingPx),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildReservationBlocks(TimeOfDay open, double totalWidth, double paddingPx) {
    final openMinutes = open.hour * 60 + open.minute;
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;

    return widget.reservations
        .where((r) => !['CANCELLED', 'REJECTED'].contains(r.status))
        .map((r) {
      final tableIndex =
          widget.tables.indexWhere((t) => t.id == r.tableId);
      if (tableIndex < 0) return const SizedBox.shrink();

      final startParts = r.startTime.split(':');
      final startMinutes =
          int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
      final left = paddingPx + ((startMinutes - openMinutes) / 60.0) *
          TimelineConstants.pixelsPerHour;

      double durationHours;
      bool isDashed = false;
      bool isPulsing = false;

      if (r.endTime != null) {
        final endParts = r.endTime!.split(':');
        final endMinutes =
            int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
        durationHours = (endMinutes - startMinutes) / 60.0;
      } else if (r.status == 'CHECKED_IN') {
        final elapsed = (nowMinutes - startMinutes) / 60.0;
        durationHours = elapsed.clamp(
            TimelineConstants.minCheckedInDurationHours, 24.0);
        isPulsing = true;
      } else {
        durationHours = TimelineConstants.defaultDurationHours;
        isDashed = true;
      }

      final width = (durationHours * TimelineConstants.pixelsPerHour)
          .clamp(TimelineConstants.minBlockWidth, totalWidth - left);

      final top = tableIndex * TimelineConstants.rowHeight +
          TimelineConstants.blockVerticalPadding;

      return Positioned(
        left: left,
        top: top,
        child: ReservationBlock(
          reservation: r,
          width: width,
          height: TimelineConstants.blockHeight,
          isDashed: isDashed,
          isPulsing: isPulsing,
          isActionInProgress: widget.actionInProgressId == r.id,
          onTap: () => widget.onTapReservation?.call(r),
        ),
      );
    }).toList();
  }

  Widget _buildCurrentTimeIndicator(TimeOfDay open, double totalHeight, double paddingPx) {
    final now = TimeOfDay.now();
    final openMinutes = open.hour * 60 + open.minute;
    final nowMinutes = now.hour * 60 + now.minute;
    final offsetMinutes = nowMinutes - openMinutes;

    final rawLeft =
        paddingPx + (offsetMinutes / 60.0) * TimelineConstants.pixelsPerHour;
    final left = rawLeft.clamp(0.0, double.infinity);

    return Positioned(
      left: left,
      top: 0,
      child: Container(
        width: 2,
        height: totalHeight,
        color: const Color(0xFFDC2626),
      ),
    );
  }
}

/// A fixed-height row that labels each hour (and half-hour) across the top of the timeline.
class _TimelineHeader extends StatelessWidget {
  final int openHour;
  final int openMinute;
  final int totalHours;
  final double pixelsPerHour;
  final double paddingPx;

  const _TimelineHeader({
    required this.openHour,
    this.openMinute = 0,
    required this.totalHours,
    required this.pixelsPerHour,
    required this.paddingPx,
  });

  @override
  Widget build(BuildContext context) {
    final halfHourWidth = pixelsPerHour / 2;
    final slotCount = totalHours * 2 + 1;
    final totalWidth = totalHours * pixelsPerHour + 2 * paddingPx;

    return SizedBox(
      height: TimelineConstants.headerHeight,
      width: totalWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(slotCount, (i) {
          final totalMinutes = openHour * 60 + openMinute + i * 30;
          final hour = (totalMinutes ~/ 60) % 24;
          final minute = totalMinutes % 60;
          final label = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
          final isHalf = minute == 30;
          final x = paddingPx + i * halfHourWidth;

          return Positioned(
            left: x - 20,
            top: 0,
            bottom: 0,
            width: 40,
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: isHalf ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontWeight: isHalf ? FontWeight.w300 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
