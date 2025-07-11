import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { NavParams } from '../router/NavParams';

@HMRouter({
  pageUrl: NavParams.HOME_PAGE_URL,
  singleton: true
})
@ComponentV2
export struct HomePage {

  build() {
    Column() {
      Text("HomePage")
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          HMRouterMgr.push({
            pageUrl: NavParams.NEW_BEVERAGE_PAGE_URL
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}