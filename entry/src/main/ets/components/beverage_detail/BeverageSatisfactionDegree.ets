import { BeverageParamName } from './BeverageParamName'

@ComponentV2
export struct BeverageSatisfactionDegree {
  @Param @Once degree: number = 0
  private readonly degreeArr: number[] = Array.from({ length: 5 }, (_: number, index: number) => index + 1)

  build() {
    Row() {
      BeverageParamName($r('app.string.beverage_satisfaction_degree'))

      Row() {
        ForEach(this.degreeArr, (degree: number) => {
          Image($r('app.media.star_gray'))
            .width(27)
            .height(27)
            .fillColor(this.degree >= degree ? $r('app.color.omc_star_gold') : $r('app.color.omc_star_gray'))
            .onClick(() => {
              this.degree = degree
            })
        }, (degree: number) => degree.toString())
      }
      .width(203)
      .height(27)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height(47)
  }
}