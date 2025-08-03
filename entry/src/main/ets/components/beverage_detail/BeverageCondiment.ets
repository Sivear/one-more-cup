import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'
import { condimentsList, ICondiment } from 'omc_db'

@ComponentV2
export struct BeverageCondiment {
  @Param condiments: number[] = []
  @Event onCondimentsChange: (newCondiments: number[]) => void = () => {
  }
  @Local isExpand: boolean = false

  private generateCondimentsValue(arr: number[]): string {
    return arr.map((item: number) => condimentsList[item - 1].name).join(',')
  }

  build() {
    Column() {
      Row() {
        BeverageParamName($r('app.string.condiments'))

        CommonInput({
          placeHolderContent: $r('app.string.beverage_condiments_placeholder'),
          inputValue: this.generateCondimentsValue(this.condiments),
          image: this.isExpand ? $r('app.media.omc_arrow_up_icon') : $r('app.media.omc_arrow_down_icon'),
          onIconClick: () => {
            animateToImmediately({ duration: 300 }, () => {
              this.isExpand = !this.isExpand
            })
          },
          isUserEditable: false
        })
      }
      .width('100%')
      .height(47)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      if (this.isExpand) {
        Column({ space: 5 }) {
          ForEach(condimentsList, (item: ICondiment, index: number) => {
            Row() {
              Text(item.name)
                .fontFamily('SF Pro')
                .fontWeight(400)
                .fontSize(10)
                .lineHeight(12)
                .fontColor($r('app.color.text_01'))

              Image($r('app.media.omc_right_icon'))
                .width(16)
                .height(16)
                .visibility(this.condiments.includes(item.id) ? Visibility.Visible : Visibility.Hidden)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({
              left: 10,
              right: 15
            })
            .onClick(() => {
              if (!this.condiments.includes(item.id ?? -1)) {
                this.condiments.push(item.id ?? -1)
              } else {
                const index = this.condiments.indexOf(item.id ?? -1)
                this.condiments.splice(index, 1)
              }
              this.onCondimentsChange([...this.condiments])
            })

            if (index !== condimentsList.length - 1) {
              Divider()
                .padding({ left: 10, right: 10 })
                .height(0.5)
            }
          }, (item: ICondiment) => JSON.stringify(item))
        }
        .width(231)
        .borderRadius(6)
        .margin({
          top: 10
        })
        .backgroundColor($r('app.color.bg_03'))
        .visibility(this.isExpand ? Visibility.Visible : Visibility.None)
        .transition(
          TransitionEffect.OPACITY.animation({ duration: 500 })
            .combine(TransitionEffect.opacity(0.1))
        )
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.End)
  }
}