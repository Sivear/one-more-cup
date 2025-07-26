import { PresetDialogKey, PresetDialogVM } from '../../viewmodel/PresetDialogViewModel'
import { DeletePresetDialog } from './DeletPresetDialog'
import { ManagePresetDialog } from './ManagePresetDialog'

@CustomDialog
export struct PresetBeverageDialogMap {
  controller: CustomDialogController
  @Require presetDialogVM: PresetDialogVM

  @Builder
  Content(key: PresetDialogKey) {
    if (key === PresetDialogKey.ADD_PRESET || key === PresetDialogKey.EDIT_PRESET) {
      ManagePresetDialog({ presetDialogVM: this.presetDialogVM })
    }
    if (key === PresetDialogKey.DELETE_PRESET) {
      DeletePresetDialog({ presetDialogVM: this.presetDialogVM })
    }
  }

  build() {
    this.Content(this.presetDialogVM.getCurDialog())
  }
}