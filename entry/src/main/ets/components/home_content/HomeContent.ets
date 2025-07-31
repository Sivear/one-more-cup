import { EventBusHandler } from "../../utils/EventBus/EventBus"
import { Events } from "../../utils/EventBus/Events"
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

  init = () => {
    this.homePageViewModel.init()
  }

  aboutToAppear(): void {
    // 避免首次安装时与初始化数据库操作存在时序上的问题
    setTimeout(() => {
      this.init()
    }, 0)
    EventBusHandler.on(Events.RECORD_LIST_CHANGE, this.init)
  }

  aboutToDisappear(): void {
    EventBusHandler.off(Events.RECORD_LIST_CHANGE, this.init)
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