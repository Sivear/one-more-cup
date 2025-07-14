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
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .border({
    radius: {
      topLeft: 16,
      topRight: 16
    }
  })
  .linearGradient({
    direction: GradientDirection.Bottom,
    colors: [[Color.White, 0], [$r("app.color.bg_02"), 1]]
  })
  .shadow({
    offsetX: 0,
    offsetY: 2.5,
    radius: 8,
    color: $r("app.color.shadow")
  })
  .height('calc(100% - 1vp)')
  .width('100%')
}