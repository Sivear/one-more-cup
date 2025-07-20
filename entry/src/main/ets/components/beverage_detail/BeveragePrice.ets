import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeveragePrice {
  @Param price: number = 0
  @Event onPriceChange: (newPrice: number) => void = () => {
  }

  build() {
    Row() {
      BeverageParamName($r('app.string.price'))

      CommonInput({
        inputValue: this.price.toString(),
        placeHolderContent: $r('app.string.beverage_price_placeholder'),
        inputType: InputType.NUMBER_DECIMAL,
        onInputValueChange: (newPrice: string) => {
          this.onPriceChange(parseFloat(newPrice))
        }
      })
    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}