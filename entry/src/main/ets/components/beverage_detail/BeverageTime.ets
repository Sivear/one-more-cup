@ComponentV2
export struct BeverageTime {
  build() {
    Row() {
      Image($r('app.media.omc_time_icon'))
        .width(25)
        .height(25)

      Text('00:21')
        .width(43)
        .height(30)
        .fontFamily('SF Pro')
        .fontWeight(700)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.text_03'))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width(74)
    .height(60)
  }
}