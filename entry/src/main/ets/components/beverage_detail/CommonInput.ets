@ComponentV2
export struct CommonInput {
  @Param placeHolderContent: ResourceStr = ''

  build() {
    TextInput({ placeholder: this.placeHolderContent })
      .width(231)
      .height(47)
      .padding(10)
      .borderRadius(6)
      .backgroundColor($r('app.color.bg_03'))
  }
}