@ComponentV2
export struct StatisticPageNoData {
  @Builder
  noData() {
    Row() {
      Text($r("app.string.no_data"))
        .fontSize(12).fontColor($r("app.color.text_02"))
    }
    .padding({
      left: 8,
      right: 8,
      top: 4,
      bottom: 4
    })
    .alignItems(VerticalAlign.Center)
    .borderRadius("50%")
    .backgroundColor($r("app.color.bg_03"))
  }

  build() {
    Column() {
      this.noData()
    }
    .width("100%")
    .height("auto")
    .padding({
      top: 24,
      bottom: 24
    })
    .borderRadius(4)
    .backgroundColor(Color.White)
    .shadow({
      offsetX: 0,
      offsetY: 2.5,
      radius: 8,
      color: $r("app.color.shadow")
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}