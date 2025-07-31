import { IRanking } from "../../model/Record"
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { PieChart, IPieData } from "../chart/PieChart"
import { StatisticPageNoData } from "./StatisticPageNoData"

const pieColors = [
  0X8979ff,
  0Xff928a,
  0X3cc3df,
  0Xffae4c,
  0X537ff1,
  0X6fd195,
  0X2bb7dc,
  0X1f94ff,
  0Xf4cf3b,
  0X55c4ae,
  0X6186cc,
]

@ComponentV2
export struct StatisticPageConsumption {
  @Consumer() homePageViewModel: HomePageViewModel = new HomePageViewModel()
  @Local pieData: IPieData[] = []
  @Local totalConsumption: number = this.homePageViewModel.getConsumptionInThisMonth()
  @Local canvasWidth: number = 0

  @Computed
  get canvasHeight(): number {
    return this.canvasWidth * 25 / 32
  }

  @Monitor("homePageViewModel.rankListByBrand")
  getPieData() {
    const totalConsumption = this.homePageViewModel.getConsumptionInThisMonth()
    this.totalConsumption = totalConsumption
    let rest = totalConsumption
    let res: IPieData[] = []
    for (let item of this.homePageViewModel.rankListByBrand) {
      res.push({
        name: item.name,
        value: item.consumption
      })
      rest -= item.consumption
      if (rest <= totalConsumption * 0.1 && rest > 0) {
        res.push({
          name: this.getUIContext().getHostContext()?.resourceManager.getStringSync($r("app.string.others").id) ?? "",
          value: rest
        })
        break
      }
    }
    this.pieData = res
  }

  // 饼状图中间的区域
  @Builder
  innerPie() {
    Column({ space: 4 }) {
      Text($r("app.string.total_consumption"))
        .fontSize(10)
        .fontColor($r("app.color.text_02"))
      Text(this.totalConsumption.toFixed(2))
        .fontSize(14)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
    }
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column({ space: 18 }) {
      Row() {
        Text($r("app.string.consumption"))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Row() {
          // 预留一个位置
        }
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      if (this.homePageViewModel.getCountInThisMonth() === 0) {
        StatisticPageNoData()
      } else {
        Column() {
          Row() {

          }
          .width("100%")
          .onSizeChange((oldValue, newValue) => {
            this.canvasWidth = parseInt((newValue.width ?? 0).toString())
          })

          PieChart({
            canvasWidth: this.canvasWidth,
            canvasHeight: this.canvasHeight,
            data: this.pieData,
            innerRadius: this.canvasWidth / 7,
            colors: pieColors,
            centerComp: () => {
              this.innerPie()
            }
          })
          List({ space: 16 }) {
            ForEach(this.homePageViewModel.rankListByBrand.slice(0, 4), (item: IRanking, index) => {
              ListItem() {
                Row({ space: 12 }) {
                  Stack() {
                    Column()
                      .height(32)
                      .width(32)
                      .borderRadius(8)
                      .backgroundColor($r("app.color.primary"))
                    // todo: 添加品牌logo
                  }

                  Row() {
                    Column() {
                      Row({ space: 12 }) {
                        Text(item.name)
                          .fontColor(Color.Black)
                          .fontSize(12)
                        Text(`${(item.consumption * 100 / this.totalConsumption).toFixed(1)}%`)
                          .fontColor($r("app.color.text_02"))
                          .fontSize(10.5)
                      }
                      .alignItems(VerticalAlign.Bottom)

                      Progress({
                        value: item.consumption,
                        total: this.totalConsumption,
                      })
                        .color(pieColors[index % pieColors.length])
                        .height(4.5)
                        .width("100%")
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(HorizontalAlign.Start)
                    .height("100%")
                    .width("60%")

                    Column() {
                      Text(`¥${item.consumption.toFixed(2)}`)
                        .fontSize(10.5)
                        .fontColor(Color.Black)
                      Text($r("app.string.how_many_expenses", item.count))
                        .fontSize(10.5)
                        .fontColor($r("app.color.text_02"))
                    }
                    .alignItems(HorizontalAlign.End)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .height("100%")
                  }
                  .height(40)
                  .padding({ bottom: 8 })
                  .justifyContent(FlexAlign.SpaceBetween)
                  .layoutWeight(1)

                }
                .width("100%")
                .alignItems(VerticalAlign.Center)
              }
              .width("100%")
            })
          }
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
    .width("100%")
  }
}

