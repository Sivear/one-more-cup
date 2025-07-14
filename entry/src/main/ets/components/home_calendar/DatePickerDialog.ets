@CustomDialog
export struct CustomDatePickerDialog {
  cancel: () => void = () => {
    this.controller.close()
  }
  confirm: (year: number, month: number) => void = (year: number, month: number) => {

  }
  controller: CustomDialogController;
  yearList: number[] = new Array(new Date().getFullYear() - 2000 + 5).fill(0).map((item: number, index) => {
    if (index >= 2 && index <= new Date().getFullYear() - 2000 + 2) {
      return 2000 + index - 2
    } else {
      return 0
    }
  })
  monthList: number[] = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 0]
  itemHeight = 36
  yearListScroller = new Scroller()
  monthListScroller = new Scroller()
  @State selectedYear: number = new Date().getFullYear()
  @State selectedMonth: number = new Date().getMonth()

  build() {
    Column() {
      Stack() {
        // 两个列表
        Row() {
          List({ scroller: this.yearListScroller }) {
            ForEach(this.yearList, (year: number) => {
              ListItem() {
                Row() {
                  if (!!year) {
                    Row() {
                      Text(year.toString())
                        .opacity(year === this.selectedYear ? 1 : 0.5)
                    }
                    .height("100%")
                    .width("100%")
                    .justifyContent(FlexAlign.Center)
                    .onClick(() => {
                      this.selectedYear = year
                      this.yearListScroller.scrollToIndex(this.selectedYear - 2000, true)
                    })
                  }
                }
                .width("100%")
                .justifyContent(FlexAlign.Center)
              }
              .height(this.itemHeight)
            })
          }
          .scrollBar(BarState.Off)
          .height("100%")
          .width("50%")
          .onSizeChange(() => {
            this.yearListScroller.scrollToIndex(this.selectedYear - 2000);
          })
          .onScrollStop(() => {
            const y = this.yearListScroller.currentOffset().yOffset
            const index = Math.round(y / this.itemHeight)
            this.yearListScroller.scrollToIndex(index, true)
            this.selectedYear = index + 2000
          })

          List({ scroller: this.monthListScroller }) {
            ForEach(this.monthList, (month: number) => {
              ListItem() {
                Row() {
                  if (!!month) {
                    Row() {
                      Text(month.toString())
                        .opacity(month - 1 === this.selectedMonth ? 1 : 0.5)
                    }
                    .height("100%")
                    .width("100%")
                    .justifyContent(FlexAlign.Center)
                    .onClick(() => {
                      this.selectedMonth = month - 1
                      this.monthListScroller.scrollToIndex(this.selectedMonth, true)
                    })
                  }
                }
                .width("100%")
                .justifyContent(FlexAlign.Center)
              }
              .height(this.itemHeight)
            })
          }
          .scrollBar(BarState.Off)
          .height("100%")
          .width("50%")
          .onSizeChange(() => {
            this.monthListScroller.scrollToIndex(this.selectedMonth);
          })
          .onScrollStop(() => {
            const y = this.monthListScroller.currentOffset().yOffset
            const index = Math.round(y / this.itemHeight)
            this.monthListScroller.scrollToIndex(index, true)
            this.selectedMonth = index
          })
        }
        .justifyContent(FlexAlign.SpaceAround)

        // 两条线
        Column({ space: this.itemHeight }) {
          Divider()
          Divider()
        }
        .hitTestBehavior(HitTestMode.Transparent)
      }
      .height(this.itemHeight * 5)
      .width("70%")

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button($r("app.string.cancel"))
          .onClick(() => {
            this.controller.close();
            if (this.cancel) {
              this.cancel();
            }
          })
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
        Button($r("app.string.confirm"))
          .onClick(() => {
            this.controller.close();
            if (this.confirm) {
              this.confirm(this.selectedYear, this.selectedMonth);
            }
          }).backgroundColor(Color.Transparent).fontColor($r("app.color.primary"))
      }.margin({ top: 20 }).padding({ left: 48, right: 48 })
    }
    .padding({ top: 20, bottom: 20 })
  }
}
