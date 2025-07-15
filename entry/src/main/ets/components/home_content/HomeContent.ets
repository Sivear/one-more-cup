import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { HomeCalendarBody } from "../home_calendar/HomeCalendarBody"
import { HomeCalendarDateSelector } from "../home_calendar/HomeCalendarDateSelector"
import { HomePanel } from "./HomePanel"

/**
 * @description omc首页，展示奶茶日历等信息
 */
@ComponentV2
struct HomeContentComp {
  @Provider() homePageViewModel: HomePageViewModel = new HomePageViewModel()

  aboutToAppear(): void {
    // 避免首次安装时与初始化数据库操作存在时序上的问题
    setTimeout(() => {
      this.homePageViewModel.init()
    }, 0)
  }

  build() {
    Column({
      space: 16
    }) {
      HomeCalendarDateSelector()
      HomePanel()
      HomeCalendarBody()
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.bg_02"))
    .padding({
      top: 18,
      left: 26,
      right: 26,
      bottom: 26
    })
  }
}

@Builder
function HomeContentBuilder() {
  HomeContentComp()
}

export const HomeContent: WrappedBuilder<[]> = wrapBuilder(HomeContentBuilder)