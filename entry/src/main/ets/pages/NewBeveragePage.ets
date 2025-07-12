import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { NavParams } from '../router/NavParams';

@HMRouter({
  pageUrl: NavParams.NEW_BEVERAGE_PAGE_URL,
  singleton: true
})
@ComponentV2
export struct NewBeveragePage {
  build() {
    Column() {
      Text("我是新建页面")
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          HMRouterMgr.pop()
        })
    }
    .height('100%')
    .width('100%')
  }
}