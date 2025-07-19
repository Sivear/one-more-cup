import { HMRouter } from '@hadss/hmrouter';
import { BeverageBrand } from '../components/new_beverage/BeverageBrand';
import { NavParams } from '../router/NavParams';
import { OpenBeverageDetailSheet } from '../components/beverage_detail/OpenBeverageDetailSheet';
import { IRecord } from '../model/Record';
import { BeverageSize } from 'omc_db';

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
        .onClick(() => {
          const a: IRecord = {
            id: 0,
            time: 1,
            remark: 'string',
            price: 8,
            size: BeverageSize.MEDIUM,
            sweetness: 'string',
            temperature: 'string',
            condiments: [],
            color: 0,
            icon: 'string',
            beverageId: 0,
            brandId: 1,
            beverageName: '与你伯伯',
            brandName: "喜茶",
            degree: 7
          } as IRecord
          OpenBeverageDetailSheet(this.getUIContext(), this.getUniqueId())(a)
        })
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