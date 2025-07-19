import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeverageNote {
  build() {
    Row() {
      BeverageParamName($r('app.string.remark'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_note_placeHolder')
      })

    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}