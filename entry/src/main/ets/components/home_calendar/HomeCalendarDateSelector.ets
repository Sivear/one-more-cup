import { HomePageViewModel } from "../../viewmodel/HomePageViewModel"
import { CustomDatePickerDialog } from "./DatePickerDialog"

@ComponentV2
export struct HomeCalendarDateSelector {
  @Consumer() homePageViewModel: HomePageViewModel = new HomePageViewModel()
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDatePickerDialog({
      confirm: (year: number, month: number) => {
        this.homePageViewModel.year = year
        this.homePageViewModel.month = month
      },
      selectedYear: this.homePageViewModel.year,
      selectedMonth: this.homePageViewModel.month
    }),
  });

  build() {
    Row() {
      Row({ space: 5 }) {
        Text($r("app.string.date", this.homePageViewModel.year, this.homePageViewModel.month + 1))
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
        Image($r('app.media.down_arrow'))
          .width(18)
          .height(11)
      }
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.dialogController.open()
      })

      if (!this.homePageViewModel.isThisMonth) {
        Button($r("app.string.back_to_this_month"))
          .width(76)
          .height(39)
          .borderRadius(4)
          .shadow({
            offsetX: 0,
            offsetY: 2.5,
            radius: 8,
            color: $r("app.color.shadow")
          })
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
          .stateEffect(true)
          .fontWeight(FontWeight.Normal)
          .padding(10)
          .onClick(() => {
            this.homePageViewModel.initDate()
          })
      }
    }
    .width("100%")
    .height(40)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
