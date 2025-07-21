/**
 * 这个panel是日期选择器下方的panel
 */
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"

interface IListItem {
  title: string | Resource
  data: number
  precision?: number
}

@ComponentV2
export struct StatisticPagePanel2 {
  @Consumer() homePageViewModel: HomePageViewModel = new HomePageViewModel()

  @Builder
  ListItemBuilder(data: IListItem) {
    ListItem() {
      Column({ space: 8 }) {
        Text(data.title)
          .fontSize(10)
          .fontColor($r("app.color.text_02"))
        Text(data.data.toFixed(data.precision ?? 0))
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
      }
      .width("100%")
      .backgroundColor($r("app.color.bg_04"))
      .border({
        color: $r("app.color.border_01"),
        width: 1,
        radius: 6
      })
      .padding(6)
      .alignItems(HorizontalAlign.Start)
    }
  }

  build() {
    Row() {
      List({ space: 12 }) {
        this.ListItemBuilder({ title: $r("app.string.cup_count_in_this_month1"), data: this.homePageViewModel.getCountInThisMonth() })
        this.ListItemBuilder({ title: $r("app.string.average_number_of_days_between"), data: this.homePageViewModel.getAverageInterval(), precision: 1 })
        this.ListItemBuilder({ title: $r("app.string.consumption_in_this_month"), data: this.homePageViewModel.getConsumptionInThisMonth(), precision: 2 })
        this.ListItemBuilder({ title: $r("app.string.average_consumption_per_day"), data: this.homePageViewModel.getAveragePrice(), precision: 2 })
      }
      .lanes(2, 12)
      .width("100%")
      .height("auto")
    }
    .width("100%")
    .padding(12)
    .borderRadius(4)
    .backgroundColor(Color.White)
    .shadow({
      offsetX: 0,
      offsetY: 2.5,
      radius: 8,
      color: $r("app.color.shadow")
    })
  }
}
