import { BeverageTime } from './BeverageTime'

@ComponentV2
export struct BeverageName {
  @Param @Require brandId: number
  @Param @Require brandName: string
  @Param @Require beverageName: string

  build() {
    RelativeContainer() {
      Row({ space: 20 }) {
        Image($r('app.media.omc_time_icon'))
          .width(60)
          .height(60)
          .borderRadius(10)
          .alt('brand image')
        Text(this.beverageName)
          .width(122)
          .height(42)
          .borderRadius(6)
          .textAlign(TextAlign.Center)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .fontFamily('SF Pro')
          .fontColor($r('app.color.text_03'))
          .fontWeight(400)
          .fontSize(18)
          .maxLines(1)
          .backgroundColor($r('app.color.bg_03'))
      }
      .alignRules({
        top: { 'anchor': '__container__', 'align': VerticalAlign.Top },
        left: { 'anchor': '__container__', 'align': HorizontalAlign.Start }
      })
      .justifyContent(FlexAlign.Center)
      .height(60)

      Text(this.brandName)
        .width(60)
        .height(30)
        .textAlign(TextAlign.Center)
        .fontFamily('SF Pro')
        .fontColor($r('app.color.text_01'))
        .fontWeight(400)
        .fontSize(14)
        .alignRules({
          bottom: { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
          left: { 'anchor': '__container__', 'align': HorizontalAlign.Start }
        })

      BeverageTime()
        .alignRules({
          top: { 'anchor': '__container__', 'align': VerticalAlign.Top },
          right: { 'anchor': '__container__', 'align': HorizontalAlign.End }
        })
    }
    .width('100%')
    .height(90)
  }
}