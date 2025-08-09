@ComponentV2
export struct TimeSelectorComp {
  //选中日期的字体
  private static readonly selectedStyle: PickerTextStyle = {
    color: $r('app.color.text_03'),
    font: {
      size: '13fp',
      weight: FontWeight.Bold
    }
  }
  //未选中日期的字体
  private static readonly unselectedStyle: PickerTextStyle = {
    color: $r('app.color.text_04'),
    font: {
      size: '12fp',
      weight: FontWeight.Regular
    }
  }
  //实时选择到的日期
  @Param @Once selectedDate: Date = new Date
  //实时选择到的时间
  @Param @Once selectedTime: Date = new Date
  //限定选择日期的起始日
  @Param startDate: Date = new Date('2000-01-01')
  //限定选择日期的终止日
  @Param endDate: Date = new Date('2026-12-31')
  //是否显示日期选择器 true 为展示 false为不展示
  @Param showDatePicker: boolean = true
  //是否仅显示时间选择器 true 为展示 false为不展示
  @Param showTimePicker: boolean = true
  // 2025-09-21 15:16格式的实时日期和时间
  @Event onTimeChange: (currentDate: string) => void = (currentDate: string) => {
  }
  // 回传选中的Date
  @Event callBackDateChange: (currentDate: Date) => void = (currentDate: Date) => {
  }
  // 回传选中的小时-分钟
  @Event callBackTimeChange: (hours: number, minutes: number, currentTime: Date) => void =
    (hours: number, minutes: number, currentTime: Date) => {
    }

  build() {
    Row() {
      // 年月日选择器
      if (this.showDatePicker) {
        DatePicker({
          selected: this.selectedDate,
          start: this.startDate,
          end: this.endDate
        })
          .textStyle(TimeSelectorComp.unselectedStyle)
          .selectedTextStyle(TimeSelectorComp.selectedStyle)
          .disappearTextStyle(TimeSelectorComp.unselectedStyle)
          .onDateChange((value: Date) => {
            this.selectedDate = value
            this.onTimeChange(this.getDateFormat(this.selectedDate, this.selectedTime))
            this.callBackDateChange(value)
          })
          .layoutWeight(2)
      }

      // 时分选择器
      if (this.showTimePicker) {
        TimePicker({
          selected: this.selectedTime
        })
          .textStyle(TimeSelectorComp.unselectedStyle)
          .selectedTextStyle(TimeSelectorComp.selectedStyle)
          .useMilitaryTime(true)
          .onChange((value: TimePickerResult) => {
            if (value.hour >= 0) {
              this.selectedTime.setHours(value.hour, value.minute);
              this.onTimeChange(this.getDateFormat(this.selectedDate, this.selectedTime))
              this.callBackTimeChange(value.hour, value.minute, this.selectedTime)
            }
          })
          .layoutWeight(1)
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor($r('app.color.start_window_background'))
  }

  private getDateFormat(date: Date, time: Date): string {
    const year = date.getFullYear()
    let month: string = (date.getMonth() + 1).toString()
    if ((date.getMonth() + 1) < 10) {
      month = '0' + month
    }
    let day: string = date.getDate().toString()
    if (date.getDate() < 10) {
      day = '0' + day
    }
    return year + '-' + month + '-' + day + ' ' + time.toTimeString().slice(0, 5)
  }
}