/**
 * @description omc首页，展示奶茶日历等信息
 */
@ComponentV2
struct HomeContentComp {
  build() {
    Column() {
      Text("我是首页")
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
  }
}

@Builder
function HomeContentBuilder() {
  HomeContentComp()
}

export const HomeContent: WrappedBuilder<[]> = wrapBuilder(HomeContentBuilder)