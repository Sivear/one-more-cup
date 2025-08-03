import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'
import { BeverageTemperature } from 'omc_db'
import { BeverageTemperatureUtil } from './utils/BeverageTemperatureUtil'

@ComponentV2
export struct BeverageTemperatureComp {
  @Param temperature: BeverageTemperature = BeverageTemperature.HOT
  @Event onTemperatureChange: (newTemperature: BeverageTemperature) => void = () => {
  }
  @Local isExpand: boolean = false

  build() {
    Column() {
      Row() {
        BeverageParamName($r('app.string.temperature'))

        CommonInput({
          placeHolderContent: $r('app.string.beverage_temperature_placeholder'),
          inputValue: BeverageTemperatureUtil.transferTemperatureToString(this.temperature),
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

      if (this.isExpand) {
        Column({ space: 5 }) {
          ForEach(Object.values(BeverageTemperature), (item: BeverageTemperature, index: number) => {
            Row() {
              Text(BeverageTemperatureUtil.transferTemperatureToString(item))
                .fontFamily('SF Pro')
                .fontWeight(400)
                .fontSize(10)
                .lineHeight(12)
                .fontColor($r('app.color.text_01'))

              Image($r('app.media.omc_right_icon'))
                .width(16)
                .height(16)
                .visibility(item === this.temperature ? Visibility.Visible : Visibility.Hidden)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({
              left: 10,
              right: 15
            })
            .onClick(() => {
              if (this.temperature !== item) {
                this.onTemperatureChange(item)
                animateToImmediately({ duration: 300 }, () => {
                  this.isExpand = false
                })
              }
            })

            if (index !== Object.keys(BeverageTemperature).length - 1) {
              Divider()
                .padding({ left: 10, right: 10 })
                .height(0.5)
            }
          }, (item: BeverageTemperature) => item)
        }
        .width(231)
        .borderRadius(6)
        .margin({
          top: 10
        })
        .backgroundColor($r('app.color.bg_03'))
        .visibility(this.isExpand ? Visibility.Visible : Visibility.Hidden)
        .transition(
          TransitionEffect.OPACITY.animation({ duration: 500 })
            .combine(TransitionEffect.opacity(0.1))
        )
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.End)
  }
}