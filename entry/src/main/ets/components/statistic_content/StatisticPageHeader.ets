/**
 * 这个panel是日期选择器上方有小猫图片的panel
 */
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"

@ComponentV2
export struct StatisticPagePanel1 {
  @Consumer() homePageViewModel: HomePageViewModel = new HomePageViewModel()

  build() {
    Row() {
      Row({ space: 43 }) {
        Column() {
          Text($r("app.string.total_count_of_cups"))
            .fontSize(14)
            .fontColor($r("app.color.text_01"))
            .fontWeight(FontWeight.Bold)
          Text(this.homePageViewModel.getCountInThisMonth().toString())
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
        .height(53)

        Column() {
          Text($r("app.string.total_consumption_of_cups"))
            .fontSize(14)
            .fontColor($r("app.color.text_01"))
            .fontWeight(FontWeight.Bold)
          Text(this.homePageViewModel.getConsumptionInThisMonth().toString())
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
        .height(53)
      }

      Image($r("app.media.cat_drinking"))
        .width(56)
        .height(74)

    }
    .width("100%")
    .height(98)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(22)
    .alignItems(VerticalAlign.Center)
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
