import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { DrinkRecord } from '../model/Record';
import { NavParams } from '../router/NavParams';
import { TimeUtil } from '../utils/TimeUtil';
import { HomePageViewModel } from '../viewmodel/HomePageViewModel';

interface IDailyRecordsParamType {
  date: Date,
  homeViewModel: HomePageViewModel
}

@HMRouter({
  pageUrl: NavParams.DAILY_RECORDS_PAGE_URL,
  singleton: true,
  dialog: true
})
@ComponentV2
export struct DailyRecordsPage {
  date: Date = new Date()
  @Local homeViewModel?: HomePageViewModel
  @Local recordList: DrinkRecord[] = []

  aboutToAppear(): void {
    let param = HMRouterMgr.getCurrentParam() as IDailyRecordsParamType;
    this.date = param.date
    this.homeViewModel = param.homeViewModel
    this.getRecordList()
  }

  @Monitor("homeViewModel.recordList")
  private getRecordList() {
    this.recordList = this.homeViewModel?.getRecordsByDate(this.date.getDate()) ?? []
  }

  build() {
    Column() {
      Column() {
        // header
        Row() {
          Row({ space: 16 }) {
            Text($r("app.string.date2", this.date.getMonth() + 1, this.date.getDate()))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Text(TimeUtil.getWeekdayName(this.date.getDay()))
              .fontColor($r("app.color.text_02"))
              .fontSize(18)
              .lineHeight(26)
          }
          .alignItems(VerticalAlign.Bottom)
        }
        .height(72)
        .width("100%")
        .alignItems(VerticalAlign.Center)
        .padding(24)

        Column() {
          List({ space: 36 }) {
            ForEach(this.recordList, (record: DrinkRecord) => {
              ListItem() {
                Row() {
                  Row({ space: 12 }) {
                    Stack() {
                      Column()
                        .height(64)
                        .width(64)
                        .borderRadius(6)
                        .backgroundColor($r("app.color.primary"))
                      // todo: 添加品牌logo
                    }

                    Column() {
                      Text(record.beverageName)
                        .fontSize(16)
                      Row({ space: 2 }) {
                        ForEach([1, 2, 3, 4, 5], (num: number) => {
                          Image(num <= record.degree ? $r("app.media.star_gold") : $r("app.media.star_gray"))
                            .width(12)
                            .height(12)
                        })
                      }
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(HorizontalAlign.Start)
                    .height("100%")
                    .padding({ top: 2, bottom: 2 })
                  }
                  .height("100%")

                  Image($r("app.media.right_arrow"))
                    .width(7)
                    .height(12)
                }
                .height("100%")
                .width("100%")
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }
              .height(64)
              .width("100%")
              .onClick(() => {
                HMRouterMgr.push({
                  pageUrl: NavParams.RECORD_DETAIL_PAGE_URL,
                  param: {
                    record,
                    homeViewModel: this.homeViewModel
                  }
                })
              })
            })
          }
          .width("100%")
          .height("100%")
          .scrollBar(BarState.Auto)
        }
        .layoutWeight(1)
        .width("100%")
        .padding({
          left: 36,
          right: 36,
          top: 24,
          bottom: 24
        })
      }
      .height("80%")
      .width("100%")
      .backgroundColor(Color.White)
      .border({
        radius: {
          topLeft: 20,
          topRight: 20
        }
      })
      .onClick(() => {
      })
    }
    .justifyContent(FlexAlign.End)
    .height("100%")
    .width("100%")
    .backgroundColor($r("app.color.mask"))
    .onClick(() => {
      HMRouterMgr.pop()
    })
  }
}