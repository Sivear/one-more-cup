import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeverageTemperature {
  build() {
    Row() {
      BeverageParamName($r('app.string.temperature'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_temperature_placeholder')
      })

    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}