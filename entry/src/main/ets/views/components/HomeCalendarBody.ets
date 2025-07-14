import { IconManager } from "omc_db"
import { Record } from "../../model/Record"
import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"

interface ICalendarItem {
  day: number
  inCurrentMonth: boolean
  date: Date
}

const header: Resource[] = [
  $r("app.string.Sunday"),
  $r("app.string.Monday"),
  $r("app.string.Tuesday"),
  $r("app.string.Wednesday"),
  $r("app.string.Thursday"),
  $r("app.string.Friday"),
  $r("app.string.Saturday")
]

@Preview
@ComponentV2
export struct HomeCalendarBody {
  @Param @Require homePageViewModel: HomePageViewModel
  @Local calendarList: ICalendarItem[] = []
  @Local rowCount: number = 6

  @Monitor("homePageViewModel.month", "homePageViewModel.year")
  init() {
    this.calendarList = this.getCalendar()
    this.rowCount = this.calendarList[this.calendarList.length - 14].inCurrentMonth ?
      (this.calendarList[this.calendarList.length - 7].inCurrentMonth ? 6 : 5) : 4
  }

  aboutToAppear(): void {
    this.init()
  }

  private getCalendar(): ICalendarItem[] {
    let result: ICalendarItem[] = []

    let firstDate = new Date(this.homePageViewModel.year, this.homePageViewModel.month, 1)
    let startWeek = firstDate.getDay()
    let daysInMonth = new Date(this.homePageViewModel.year, this.homePageViewModel.month + 1, 0).getDate()
    let daysInPrevMonth = new Date(this.homePageViewModel.year, this.homePageViewModel.month, 0).getDate()

    // 上月补位
    for (let i = startWeek - 1; i >= 0; i--) {
      let day = daysInPrevMonth - i
      result.push({
        day,
        inCurrentMonth: false,
        date: new Date(this.homePageViewModel.year, this.homePageViewModel.month - 1, day)
      })
    }

    // 本月
    for (let d = 1; d <= daysInMonth; d++) {
      result.push({
        day: d,
        inCurrentMonth: true,
        date: new Date(this.homePageViewModel.year, this.homePageViewModel.month, d)
      })
    }

    // 下月补齐
    while (result.length < 42) {
      let d = result.length - (startWeek + daysInMonth) + 1
      result.push({
        day: d,
        inCurrentMonth: false,
        date: new Date(this.homePageViewModel.year, this.homePageViewModel.month + 1, d)
      })
    }

    return result
  }

  build() {
    Column() {
      // 星期标题行
      Row() {
        ForEach(header, (day: Resource) => {
          Text(day)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
        })
      }
      .margin({ left: 14, right: 14 })
      .justifyContent(FlexAlign.SpaceAround)
      .width("100%")
      .height(34)

      // // 日期网格
      Grid() {
        ForEach(this.calendarList, (item: ICalendarItem, index) => {
          GridItem() {
            CalendarItem({
              calendarItem: item,
              recordList: this.homePageViewModel.getRecordsByDate(item.day),
              hasDivider: index < 7 * (this.rowCount - 1)
            })

          }

        })
      }
      .columnsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr") // 7 列
      .rowsTemplate(`repeat(${this.rowCount}, 1fr)`) // 6 行
      .width("100%")
      .layoutWeight(1) // 占据父容器剩余空间

    }
    .width("100%")
    .layoutWeight(1)
    .padding({
      top: 13,
      bottom: 13,
      left: 11,
      right: 11
    })
    .backgroundColor(Color.White)
    .shadow({
      offsetX: 0,
      offsetY: 2.5,
      radius: 8,
      color: $r("app.color.shadow")
    })
    .borderRadius(4)

  }
}


@ComponentV2
struct CalendarItem {
  @Param @Require calendarItem: ICalendarItem
  @Param @Require recordList: Record[]
  @Param @Require hasDivider: boolean
  // 计算每个日历格子最多能放多少项
  @Local containerHeight: number = 0
  @Local maxCount: number = 0

  @Monitor("containerHeight", "recordList")
  calcMaxVisibleItems() {
    const itemHeight: number = 12
    const itemSpacing: number = 3
    // 每项真实高度 = itemHeight + spacing（除最后一项）
    let total = 0
    let count = 0
    while (true) {
      const nextHeight = itemHeight + itemSpacing
      if (total + nextHeight <= this.containerHeight) {
        total += nextHeight
        count++
      } else {
        // 为+x留出空间
        if (this.maxCount < this.recordList.length) {
          count --
        }
        break
      }
    }

    this.maxCount = count
  }


  build() {
    Column() {
      if (this.calendarItem.inCurrentMonth) {
        Column() {
          Text(this.calendarItem.day.toString())
            .textAlign(TextAlign.Center)
            .fontSize(12)
            .height(13)
            .margin({
              top: 2,
              bottom: 4
            })

          // 饮品list
          Column({ space: 3 }) {
            ForEach(this.recordList, (item: Record, index) => {
              if (index < this.maxCount) {
                Row() {
                  Image(IconManager.getIconById(item.icon!!))
                    .width(7)
                    .height(7)
                  // .margin({ right: 1 })
                  Row() {
                    Text(item.brandName)

                      .fontSize(7)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .lineHeight(9)
                  }
                  .height("100%")
                  .layoutWeight(1)
                  .clip(true)
                }
                .height(12)
                .borderRadius(2)
                .backgroundColor(item.color)
                .alignItems(VerticalAlign.Center)
                .padding({
                  left: 2,
                  right: 2
                })
              }
            })
            if (this.maxCount < this.recordList.length) {
              Text(`+${this.recordList.length - this.maxCount}`)
                .fontSize(7)
                .margin({ left: 2 })
            }
          }
          .width("100%")
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .onSizeChange((oldValue, newValue) => {
            this.containerHeight = parseInt((newValue.height ?? 0).toString())
          })
          .padding({ bottom: 2 })
        }
        .margin({
          top: 11,
          bottom: 11
        })
        .padding(2)
        .width("calc(100% - 6vp)")
        .backgroundColor(this.recordList.length === 0 ? Color.White : $r("app.color.bg_01"))
        .layoutWeight(1)
        .borderRadius(4)
      } else {
        Blank()
      }
      if (this.hasDivider) {
        Divider()
          .strokeWidth(0.5)
          .color($r("app.color.divider"))
      }
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.End)
  }
}