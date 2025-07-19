import { TimeFormatUtil } from './utils/TimeFormatUtil'

@ComponentV2
export struct BeverageTime {
  @Param @Require time: number
  @Event onTimeChange: (newTime: number) => void = () => {
  }

  build() {
    Row() {
      Image($r('app.media.omc_time_icon'))
        .width(25)
        .height(25)

      Text(TimeFormatUtil.transferTimeToString(this.time))
        .width(43)
        .height(30)
        .fontFamily('SF Pro')
        .fontWeight(700)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.text_03'))
        .onClick(() => {
          // todo:完成时间选择器
          // this.onTimeChange(Date.now() + 10000086)
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width(74)
    .height(60)
  }
}