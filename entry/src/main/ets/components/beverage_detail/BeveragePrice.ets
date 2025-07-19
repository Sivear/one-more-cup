import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeveragePrice {
  @Param @Once price: number = 0

  build() {
    Row() {
      BeverageParamName($r('app.string.price'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_price_placeholder')
      })

    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}