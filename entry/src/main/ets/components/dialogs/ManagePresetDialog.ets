import { PresetDialogKey, PresetDialogVM } from '../../viewmodel/PresetDialogViewModel'

// 添加/编辑预设饮品dialog
@ComponentV2
export struct ManagePresetDialog {
  @Param brandName: string = ''
  @Param @Require presetDialogVM: PresetDialogVM
  @Local beverageName: string = ''
  private title: ResourceStr = ''

  aboutToAppear(): void {
    if (this.presetDialogVM.getCurDialog() === PresetDialogKey.ADD_PRESET) {
      this.title = $r('app.string.add_beverage_preset')
    } else if (this.presetDialogVM.getCurDialog() === PresetDialogKey.EDIT_PRESET) {
      this.title = $r('app.string.edit_beverage_preset')
    }
  }

  build() {
    Column({ space: 24 }) {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Row() {
        // 品牌logo
        Image($r('app.media.app_logo_bg'))
          .width(60)
          .height(60)
          .borderRadius(6)
          .margin({ right: 6 })
        Text(this.brandName)
          .fontSize(16)
      }.justifyContent(FlexAlign.Center)

      TextInput({ text: this.beverageName!!, placeholder: $r('app.string.input_beverage_name') })
        .height(47)
        .borderRadius(6)

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
        Button($r("app.string.confirm"))
          .width("36%")
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.primary"))
          .onClick(() => {
            this.presetDialogVM.executeConfirm(this.beverageName)
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
    .padding({
      left: 12,
      right: 12,
      top: 24,
      bottom: 24
    })
  }
}