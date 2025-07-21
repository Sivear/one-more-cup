import { HMRouter } from '@hadss/hmrouter';
import { BeverageBrand } from '../components/new_beverage/BeverageBrand';
import { NavParams } from '../router/NavParams';

@HMRouter({
  pageUrl: NavParams.NEW_BEVERAGE_PAGE_URL,
  singleton: true
})
@ComponentV2
export struct NewBeveragePage {
  @Local searchValue: string = ''

  build() {
    Column() {
      Text($r('app.string.beverage_choose'))
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
      Search({ value: this.searchValue, placeholder: $r('app.string.input_brand') })
        .borderRadius(0)
        .searchIcon({
          src: $r('sys.media.ohos_ic_public_search_filled'),
          size: '14vp',
          color: '#99000000'
        })
        .cancelButton({
          style: CancelButtonStyle.INPUT,
          icon: {
            src: $r('sys.media.ohos_ic_public_cancel_filled')
          },
        })
        .width('90%')
        .height(40)
        .maxLength(20)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .onChange((value: string) => {
          //todo 节流
        })
        .margin(20)

      BeverageBrand()
    }
    .height('100%')
    .width('100%')
  }
}