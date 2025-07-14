import { HMRouter } from '@hadss/hmrouter';
import { AddBeverageButton } from '../components/add_beverage_button/AddBeverageButton';
import { TabData, TabItem } from '../components/omc_tab/TabData';
import { TabContentTemplate } from '../components/omc_tab/TabTemplate';
import { NavParams } from '../router/NavParams';

@HMRouter({
  pageUrl: NavParams.HOME_PAGE_URL,
  singleton: true
})
@ComponentV2
export struct HomePage {
  @Local tabData: TabData = new TabData()

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.End,
        index: $$this.tabData.pickedIndex
      }) {
        ForEach(this.tabData.tabData, (item: TabItem) => {
          TabContentTemplate({
            tabData: item
          })
        }, (item: TabItem) => item.type.toString())
      }
      .backgroundColor($r("app.color.bg_02"))

      AddBeverageButton()
    }
    .height('100%')
    .width('100%')
  }
}