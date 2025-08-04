import { DbHandler, IBrand, IconManager } from 'omc_db'
import { BeverageTime } from './BeverageTime'

@ComponentV2
export struct BeverageName {
  @Param @Require brandId: number
  @Param @Require beverageName: string
  @Param @Require time: number
  @Event onTimeChange: (newTime: number) => void = () => {}
  @Local private showBeverageNamePopup: boolean = false
  @Local private brandName: string = ''
  private isTextOverflow: boolean = false

  aboutToAppear(): void {
    // todo: 根据brandId获取brand logo
    DbHandler.brandApi.getBrandById(this.brandId).then((res: IBrand[]) => {
      (res.length == 1) && (this.brandName = res[0].name)
    })
    const textWidth = this.getUIContext().getMeasureUtils().measureTextSize({
      textContent: this.beverageName,
      fontSize: 18,
      fontWeight: 400,
      textAlign: TextAlign.Center
    }).width ?? 0
    this.isTextOverflow = px2vp(textWidth as number) > (160 - 10 - 15)
  }

  build() {
    RelativeContainer() {
      Row({ space: 20 }) {
        Image(IconManager.getIconById(IconManager.getRandomIcon()))
          .width(60)
          .height(60)
          .borderRadius(10)
          .alt('brand image')
        Row() {
          Text(this.beverageName)
            .bindPopup(this.showBeverageNamePopup, {
              message: this.beverageName,
              mask: false,
              messageOptions: {
                textColor: $r('app.color.text_03'),
                font: {
                  size: 14,
                  weight: 300
                }
              },
              enableArrow: true,
              popupColor: $r('app.color.bg_03'),
              autoCancel: true,
              onStateChange: (event) => {
                this.showBeverageNamePopup = event.isVisible
              },
              arrowPointPosition: ArrowPointPosition.CENTER,
              radius: 6,
              width: 160
            })
            .width(160)
          .height(42)
            .padding({
              left: 10,
              right: 15
            })
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

          if (this.isTextOverflow) {
            Text($r('app.string.text_unfold'))
              .fontSize(10)
              .lineHeight(12)
              .height(12)
              .width(20)
              .fontColor($r('app.color.text_01'))
              .position({ x: 140, y: 20 })
              .onClick(() => {
                !this.showBeverageNamePopup && (this.showBeverageNamePopup = true)
              })
          }
        }
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

      BeverageTime({
        time: this.time,
        onTimeChange: (newTime: number) => {
          this.onTimeChange(newTime)
        }
      })
        .alignRules({
          top: { 'anchor': '__container__', 'align': VerticalAlign.Top },
          right: { 'anchor': '__container__', 'align': HorizontalAlign.End }
        })
    }
    .width('100%')
    .height(90)
  }
}