@ComponentV2
export struct CommonInput {
  @Param @Require placeHolderContent: ResourceStr
  @Param inputValue: ResourceStr = ''
  @Param image: ResourceStr = ''
  @Param inputType: InputType = InputType.Normal
  @Param textAlign: TextAlign = TextAlign.Start
  @Param isUserEditable: boolean = true
  @Param maxLength: number = Infinity
  @Param showCounter: boolean = false
  @Event onInputValueChange: (newVal: string) => void = () => {
  }
  @Event onIconClick?: () => void

  build() {
    Row() {
      TextInput({ placeholder: this.placeHolderContent, text: this.inputValue })
        .width(this.image ? 231 - 47 : 231)
        .height(47)
        .padding(10)
        .backgroundColor($r('app.color.bg_03'))
        .type(this.inputType)
        .textAlign(this.textAlign)
        .focusable(this.isUserEditable)
        .maxLength(this.maxLength)
        .showCounter(this.showCounter)
        .onChange((val: string) => {
          this.onInputValueChange(val)
        })

      if (this.image) {
        Row() {
          Image(this.image)
            .width(24)
            .height(24)
            .onClick(() => {
              this.onIconClick && this.onIconClick()
            })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width(47)
        .height(47)
      }
    }
    .borderRadius(6)
    .width(231)
    .height(47)
    .backgroundColor($r('app.color.bg_03'))
  }
}