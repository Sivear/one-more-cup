import { Record } from "../../model/Record"
import { TimeUtil } from "../../utils/TimeUtil"
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"

@ComponentV2
export struct HomePanel {
  @Param @Require @Once homePageViewModel: HomePageViewModel

  build() {
    Row() {
      Row({ space: 36 }) {
        Column({ space: 24 }) {
          Text($r("app.string.cup_count_in_this_month"))
            .fontSize(16)
            .fontColor($r("app.color.text_01"))
            .fontWeight(FontWeight.Bold)
          Row() {
            Text(this.homePageViewModel.getCountInThisMonth().toString().padEnd(2, " "))
              .fontSize(38)
              .fontWeight(FontWeight.Medium)

            Text($r("app.string.cup"))
              .fontSize(12)
              .fontColor($r("app.color.text_02"))
              .fontWeight(FontWeight.Bold)
              .lineHeight(48)

          }
          .alignItems(VerticalAlign.Bottom)
        }

        if (this.homePageViewModel.isThisMonth && this.homePageViewModel.recordList.length > 0 && this.homePageViewModel.latestRecord) {
          Column({ space: 24 }) {
            Text($r("app.string.the_last_time_drinking"))
              .fontSize(16)
              .fontColor($r("app.color.text_01"))
              .fontWeight(FontWeight.Bold)
            Row() {
              // if (TimeUtil.isToday(this.homePageViewModel.latestRecord?.time)) {
              //   Text($r("app.string.today"))
              //     .fontSize(38)
              //     .fontWeight(FontWeight.Medium)
              // } else {
                Text(TimeUtil.daysAgo(this.homePageViewModel.latestRecord?.time).toString().padEnd(2, " "))
                  .fontSize(38)
                  .fontWeight(FontWeight.Medium)
                Text($r("app.string.days_before"))
                  .fontSize(12)
                  .fontColor($r("app.color.text_02"))
                  .fontWeight(FontWeight.Bold)
                  .lineHeight(48)
              // }
            }
            .alignItems(VerticalAlign.Bottom)
          }
        }

      }

      Image($r("app.media.cat_drinking"))
        .width(76)
        .height(100)

    }
    .width("100%")
    .height(128)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(17)
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
