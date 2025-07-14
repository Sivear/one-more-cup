import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { HomeCalendarBody } from "../components/HomeCalendarBody"
import { HomeCalendarDateSelector } from "../components/HomeCalendarDateSelector"
import { HomePanel } from "../components/HomePanel"

@ComponentV2
export struct HomePage {
  @Local homePageViewModel: HomePageViewModel = new HomePageViewModel()

  aboutToAppear(): void {
    // 避免首次安装时与初始化数据库操作存在时序上的问题
    setTimeout(() => {
      this.homePageViewModel.initRecords()
    }, 0)
  }

  build() {
    Column({
      space: 20
    }) {
      HomeCalendarDateSelector({ homePageViewModel: this.homePageViewModel })
      HomePanel({ homePageViewModel: this.homePageViewModel })
      HomeCalendarBody({ homePageViewModel: this.homePageViewModel })
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.bg_02"))
    .padding({
      top: 18,
      left: 26,
      right: 26,
      bottom: 18
    })
  }
}