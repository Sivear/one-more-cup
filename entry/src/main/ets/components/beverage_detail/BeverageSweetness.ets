import { BeverageSweetness } from 'omc_db'
import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'
import { BeverageSweetnessUtil } from './utils/BeverageSweetnessUtil'

@ComponentV2
export struct BeverageSweetnessComp {
  @Param sweetness: BeverageSweetness = BeverageSweetness.NO_SUGAR
  @Event onSweetnessChange: (newSweetness: BeverageSweetness) => void = () => {
  }
  @Local isExpand: boolean = false

  build() {
    Column() {
      Row() {
        BeverageParamName($r('app.string.sweetness'))

        CommonInput({
          placeHolderContent: $r('app.string.beverage_sweetness_placeholder'),
          inputValue: BeverageSweetnessUtil.transferSweetnessToString(this.sweetness),
          image: this.isExpand ? $r('app.media.omc_arrow_up_icon') : $r('app.media.omc_arrow_down_icon'),
          onIconClick: () => {
            animateToImmediately({ duration: 300 }, () => {
              this.isExpand = !this.isExpand
            })
          },
          isUserEditable: false
        })
      }
      .width('100%')
      .height(47)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: 5 }) {
        ForEach(Object.values(BeverageSweetness), (item: BeverageSweetness, index: number) => {
          Row() {
            Text(BeverageSweetnessUtil.transferSweetnessToString(item))
              .fontFamily('SF Pro')
              .fontWeight(400)
              .fontSize(10)
              .lineHeight(12)
              .fontColor($r('app.color.text_01'))

            Image($r('app.media.omc_right_icon'))
              .width(16)
              .height(16)
              .visibility(item === this.sweetness ? Visibility.Visible : Visibility.Hidden)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({
            left: 10,
            right: 15
          })
          .onClick(() => {
            if (this.sweetness !== item) {
              this.onSweetnessChange(item)
              animateToImmediately({ duration: 300 }, () => {
                this.isExpand = false
              })
            }
          })

          if (index !== Object.keys(BeverageSweetness).length - 1) {
            Divider()
              .padding({ left: 10, right: 10 })
              .height(0.5)
          }
        }, (item: BeverageSweetness) => item)
      }
      .width(231)
      .borderRadius(6)
      .margin({
        top: 10
      })
      .backgroundColor($r('app.color.bg_03'))
      .visibility(this.isExpand ? Visibility.Visible : Visibility.None)
    }
    .width('100%')
    .alignItems(HorizontalAlign.End)
  }
}