import { IRanking } from "../../model/Record"
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { StatisticPageNoData } from "./StatisticPageNoData"

@ComponentV2
export struct StatisticPageRanking {
  @Consumer() homePageViewModel: HomePageViewModel = new HomePageViewModel()
  @Local isBrandRanking: boolean = true

  @Builder
  getRankIcon(rank: number) {
    if (rank === 1) {
      Image($r("app.media.diyiming"))
        .width(24)
        .height(24)
    } else if (rank === 2) {
      Image($r("app.media.dierming_1"))
        .width(24)
        .height(24)
    } else if (rank === 3) {
      Image($r("app.media.disanming"))
        .width(24)
        .height(24)
    } else {
      Row() {
        Text(rank.toString())
          .fontSize(12)
          .fontColor(Color.Black)
      }
      .width(24)
      .height(24)
      .backgroundColor($r("app.color.bg_03"))
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
  }

  build() {
    Column({ space: 18 }) {
      Row() {
        Text($r("app.string.ranking_list"))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Row({ space: 2 }) {
          Image($r("app.media.change"))
            .width(16)
            .height(16)
          Text(this.isBrandRanking ? $r("app.string.beverage") : $r("app.string.brand"))
            .fontSize(12)
            .fontColor($r("app.color.text_02"))
        }
        .onClick(() => {
          this.isBrandRanking = !this.isBrandRanking
        })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      if (this.homePageViewModel.getCountInThisMonth() === 0) {
        StatisticPageNoData()
      } else {
        List({ space: 13 }) {
          ForEach((this.isBrandRanking ? this.homePageViewModel.rankListByBrand : this.homePageViewModel.rankListByBeverage).slice(0, 4), (item: IRanking, index) => {
            ListItem() {
              Row({ space: 12 }) {
                this.getRankIcon(index + 1)
                Row() {
                  Text(item.name)
                    .fontSize(12)
                    .fontColor(Color.Black)
                  Text(item.count.toString())
                    .fontSize(12)
                    .fontColor(Color.Black)
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }
              .width("100%")
            }
            .width("100%")
            .layoutWeight(1)
          })
        }
        .width("100%")
        .height("auto")
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
    .width("100%")
  }
}