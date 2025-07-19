import { BeverageParamName } from './BeverageParamName'
import { CommonInput } from './CommonInput'

@ComponentV2
export struct BeverageSweetness {
  build() {
    Row() {
      BeverageParamName($r('app.string.sweetness'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_sweetness_placeholder')
      })

    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}