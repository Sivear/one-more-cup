import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { HomeCalendarDateSelector } from "../home_calendar/HomeCalendarDateSelector"
import { StatisticPageConsumption } from "./StatisticPageConsumption"
import { StatisticPagePanel1 } from "./StatisticPageHeader"
import { StatisticPagePanel2 } from "./StatisticPageOverallPanel"
import { StatisticPageRanking } from "./StatisticPageRanking"

/**
 * @description omc统计页，展示奶茶月总结、总花费等信息
 */
@ComponentV2
struct StatisticContentComp {
  @Provider() homePageViewModel: HomePageViewModel = new HomePageViewModel()

  aboutToAppear(): void {
    // 避免首次安装时与初始化数据库操作存在时序上的问题
    setTimeout(() => {
      this.homePageViewModel.init()
    }, 0)
  }

  build() {
    Scroll() {
      Column({
        space: 16
      }) {
        StatisticPagePanel1()
        HomeCalendarDateSelector()
        StatisticPagePanel2()
        StatisticPageRanking()
        StatisticPageConsumption()
      }
      .width("100%")
      .backgroundColor($r("app.color.bg_02"))
      .padding({
        top: 18,
        left: 26,
        right: 26,
        bottom: 26
      })
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Auto) // 显示滚动条
    .scrollable(ScrollDirection.Vertical)
    .scrollBarColor(0x20000000) // 滚动条颜色
    .scrollBarWidth(4) // 滚动条宽度
    .align(Alignment.TopStart)
  }
}

@Builder
function StatisticContentBuilder() {
  StatisticContentComp()
}

export const StatisticContent: WrappedBuilder<[]> = wrapBuilder(StatisticContentBuilder)