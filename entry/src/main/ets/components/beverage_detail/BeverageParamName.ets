@Builder
export function BeverageParamName(paramName: ResourceStr) {
  Text(paramName)
    .fontFamily('SF Pro')
    .fontWeight(400)
    .fontSize(20)
    .lineHeight(27)
    .height(27)
    .width(40)
    .fontColor($r('app.color.text_03'))
}
