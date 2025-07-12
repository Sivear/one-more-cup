/**
 * @description omc统计页，展示奶茶月总结、总花费等信息
 */
@ComponentV2
struct StatisticContentComp {
  build() {
    Column() {
      Text("我是详情页")
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
  }
}

@Builder
function StatisticContentBuilder() {
  StatisticContentComp()
}

export const StatisticContent: WrappedBuilder<[]> = wrapBuilder(StatisticContentBuilder)