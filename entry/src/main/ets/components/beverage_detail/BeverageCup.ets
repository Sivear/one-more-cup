import { BeverageSize } from 'omc_db'
import { BeverageParamName } from './common_ui/BeverageParamName'
import { BeverageSizeUtil } from './utils/BeverageSizeUtil'

@ComponentV2
export struct BeverageCup {
  @Param @Require beverageSize: BeverageSize
  @Event onCupSizeChange: (newSize: BeverageSize) => void = () => {
  }

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
              .fontSize(10)
              .lineHeight(12)
              .textAlign(TextAlign.Center)
              .fontColor(this.beverageSize === item ? $r('app.color.text_03') : $r('app.color.text_01'))
              .backgroundColor(
                this.beverageSize === item ?
                $r('app.color.divider') : $r('app.color.start_window_background')
              )
          }
          .onClick(() => {
            if (this.beverageSize !== item) {
              this.onCupSizeChange(item)
            }
          })
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