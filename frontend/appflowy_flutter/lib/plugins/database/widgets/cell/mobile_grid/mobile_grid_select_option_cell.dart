import 'package:appflowy/mobile/presentation/bottom_sheet/show_mobile_bottom_sheet.dart';
import 'package:appflowy/plugins/database/widgets/row/cells/cell_container.dart';
import 'package:appflowy/plugins/database/widgets/row/cells/select_option_cell/extension.dart';
import 'package:appflowy/plugins/database/widgets/row/cells/select_option_cell/mobile_select_option_editor.dart';
import 'package:appflowy/plugins/database/widgets/row/cells/select_option_cell/select_option_cell_bloc.dart';
import 'package:appflowy_backend/protobuf/flowy-database2/select_option.pb.dart';
import 'package:appflowy_popover/appflowy_popover.dart';
import 'package:collection/collection.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flutter/material.dart';

import '../editable_cell_skeleton/select_option.dart';

class MobileGridSelectOptionCellSkin extends IEditableSelectOptionCellSkin {
  @override
  Widget build(
    BuildContext context,
    CellContainerNotifier cellContainerNotifier,
    SelectOptionCellBloc bloc,
    SelectOptionCellState state,
    PopoverController popoverController,
  ) {
    return FlowyButton(
      hoverColor: Colors.transparent,
      radius: BorderRadius.zero,
      margin: EdgeInsets.zero,
      text: Align(
        alignment: AlignmentDirectional.centerStart,
        child: state.selectedOptions.isEmpty
            ? const SizedBox.shrink()
            : _buildOptions(context, state.selectedOptions),
      ),
      onTap: () {
        showMobileBottomSheet(
          context,
          padding: EdgeInsets.zero,
          builder: (context) {
            return MobileSelectOptionEditor(
              cellController: bloc.cellController,
            );
          },
        );
      },
    );
  }

  Widget _buildOptions(BuildContext context, List<SelectOptionPB> options) {
    final children = options
        .mapIndexed(
          (index, option) => SelectOptionTag(
            option: option,
            fontSize: 14,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        )
        .toList();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const HSpace(8),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    );
  }
}