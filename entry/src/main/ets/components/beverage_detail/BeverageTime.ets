import { BaseDialogParams } from '../omc_dialog/BaseDialogParams'
import { OmcDialog } from '../omc_dialog/OmcDialog'
import { TimeSelectorComp } from './common_ui/TimeSelectorComp'
import { TimeFormatUtil } from './utils/TimeFormatUtil'

@ComponentV2
export struct BeverageTime {
  @Param @Require time: number
  @Event onTimeChange: (newTime: number) => void = () => {
  }
  private timeSelectorDialogParams: TimeSelectorDialogParams = new TimeSelectorDialogParams()

  aboutToAppear(): void {
    this.timeSelectorDialogParams
      .startDate(new Date('2000-01-01'))
      .endDate(new Date(this.time))
      .onTimeChange((curDate: string) => {
        this.onTimeChange(Date.parse(curDate))
      })
      .autoCancel(true)
      .onWillDismiss(() => {
        OmcDialog.closeDialog(this.getUIContext(), this.timeSelectorDialogParams.id)
      })
  }

  build() {
    Row() {
      Image($r('app.media.omc_time_icon'))
        .width(25)
        .height(25)

      Text(TimeFormatUtil.transferTimeToString(this.time))
        .width(43)
        .height(30)
        .fontFamily('SF Pro')
        .fontWeight(700)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.text_03'))
        .onClick(() => {
          // 打开时间修改弹窗
          OmcDialog.showDialog(
            this.getUIContext(),
            wrapBuilder(BeverageTimeSelectorDialogBuilder),
            this.timeSelectorDialogParams
          )
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width(74)
    .height(60)
  }
}

class TimeSelectorDialogParams extends BaseDialogParams {
  public mStartDate: Date = new Date('2000-01-01')
  public mEndDate: Date = new Date('2026-12-31')
  public mOnTimeChange: (currentDate: string) => void = (currentDate: string) => {
  }

  public startDate(date: Date): TimeSelectorDialogParams {
    this.mStartDate = date
    return this
  }

  public endDate(date: Date): TimeSelectorDialogParams {
    this.mEndDate = date
    return this
  }

  public onTimeChange(func: (curDate: string) => void): TimeSelectorDialogParams {
    this.mOnTimeChange = func
    return this
  }
}

@ComponentV2
struct BeverageTimeSelectorDialogComp {
  @Local selectDate: string = ''
  @Param @Require startDate: Date
  @Param @Require endDate: Date
  @Param @Require dialogId: string = ''
  @Event onTimeChange: (currentDate: string) => void = (currentDate: string) => {
  }

  build() {
    Column({ space: 24 }) {
      TimeSelectorComp({
        startDate: this.startDate,
        endDate: this.endDate,
        onTimeChange: (currentDate: string) => {
          this.selectDate = currentDate
        }
      })

      Row() {
        Button($r("app.string.cancel"))
          .width("25%")
          .constraintSize({
            minWidth: 100,
            maxWidth: 120
          })
          .height(54)
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .onClick(() => {
            OmcDialog.closeDialog(this.getUIContext(), this.dialogId)
          })
        Button($r("app.string.confirm"))
          .width("25%")
          .constraintSize({
            minWidth: 100,
            maxWidth: 120
          })
          .height(54)
          .backgroundColor(Color.Transparent)
          .fontColor($r("app.color.primary"))
          .onClick(() => {
            this.onTimeChange(this.selectDate)
            OmcDialog.closeDialog(this.getUIContext(), this.dialogId)
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("90%")
    .alignItems(HorizontalAlign.Center)
    .backgroundColor($r('app.color.start_window_background'))
    .borderRadius(16)
    .padding(24)
  }
}

@Builder
function BeverageTimeSelectorDialogBuilder(params: TimeSelectorDialogParams) {
  BeverageTimeSelectorDialogComp({
    startDate: params.mStartDate,
    endDate: params.mEndDate,
    dialogId: params.id,
    onTimeChange: params.mOnTimeChange
  })
}