import { PresetDialogVM } from '../../viewmodel/PresetDialogViewModel'

@ComponentV2
export struct DeletePresetDialog {
  @Param @Require presetDialogVM: PresetDialogVM

  build() {
    Column({ space: 60 }) {
      Text($r("app.string.delete_confirm_text"))
        .fontSize(20)
      
      Row() {
        Button($r("app.string.cancel"))
          .width("36%")
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.bg_03"))
          .fontColor(Color.Black)
          .onClick(() => {
            this.presetDialogVM.executeCancel()
          })
        Button($r("app.string.delete"))
          .width("36%")
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.primary"))
          .onClick(() => {
            this.presetDialogVM.executeConfirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
    .padding(24)
  }
}