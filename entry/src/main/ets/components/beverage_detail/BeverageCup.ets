import { BeverageSize } from 'omc_db'
import { BeverageParamName } from './BeverageParamName'
import { BeverageSizeUtil } from './utils/BeverageSizeUtil'

@ComponentV2
export struct BeverageCup {
  @Param @Require beverageSize: BeverageSize

  build() {
    Row() {
      BeverageParamName($r('app.string.beverage_size'))

      Row() {
        ForEach(Object.values(BeverageSize), (item: BeverageSize) => {
          Column({ space: 6 }) {
            Image($r('app.media.omc_beverage_icon'))
              .width(BeverageSizeUtil.transferSizeToNumber(item).width)
              .height(BeverageSizeUtil.transferSizeToNumber(item).height)

            Text(BeverageSizeUtil.transferSizeToString(item))
              .width(BeverageSizeUtil.transferSizeToNumber(item).width)
              .height(18)
              .borderRadius(6)
              .fontFamily('SF Pro')
              .fontWeight(400)
              .fontSize(12)
              .lineHeight(12)
              .textAlign(TextAlign.Center)
              .fontColor($r('app.color.text_01'))
          }
        }, (item: BeverageSize) => item)
      }
      .constraintSize({
        maxWidth: `${275 / 382 * 100}%`
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Bottom)
      .width(275)
      .height('100%')

    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height(90)
  }
}