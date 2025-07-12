import { TabItem } from './TabData'

interface ITabTemplateParams {
  tabData: TabItem
}

/**
 * @description omc首页Tab模板
 * @param params
 */
@Builder
export function TabContentTemplate(params: ITabTemplateParams) {
  TabContent() {
    params.tabData.content?.builder()
  }
  .tabBar(TabBarTemplate(params.tabData))
}

@Builder
function TabBarTemplate(params: TabItem) {
  Column() {
    Image(params.icon)
      .width(32)
      .height(32)
      .objectFit(ImageFit.Contain)
      .fillColor(params.isActive ? $r('app.color.omc_tab_active') : $r('app.color.omc_tab_inactive'))
  }
  .shadow({
    radius: 10,
    color: '#000000',
    offsetX: 0,
    offsetY: 10
  })
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .border({
    radius: {
      topLeft: 16,
      topRight: 16
    },
    width: { top: 1 },
    color: $r('app.color.omc_tab_shadow_color')
  })
  .height('calc(100% - 1vp)')
  .width('100%')
}