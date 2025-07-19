import { BeverageParamName } from './BeverageParamName'
import { CommonInput } from './CommonInput'

@ComponentV2
export struct BeverageCondiment {
  build() {
    Row() {
      BeverageParamName($r('app.string.condiments'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_condiments_placeholder')
      })

    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}