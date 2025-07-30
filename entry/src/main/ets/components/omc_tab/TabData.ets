import { HomeContent } from '../home_content/HomeContent'
import { StatisticContent } from '../statistic_content/StatisticContent'

/**
 * omc首页Tab数据结构
 */
interface ITabItem {
  type: ETabType
  icon: ResourceStr
  content?: WrappedBuilder<[]>
}

enum ETabType {
  INVALID = -1,
  HOME = 1,
  STATISTICS
}

const TabDataJSON: ITabItem[] = [
  {
    type: ETabType.HOME,
    icon: $r('app.media.omc_home_icon'),
    content: HomeContent
  },
  {
    type: ETabType.STATISTICS,
    icon: $r('app.media.omc_data_icon'),
    content: StatisticContent
  }
]

@ObservedV2
export class TabItem implements ITabItem {
  type: ETabType = ETabType.INVALID
  icon: ResourceStr = ''
  content?: WrappedBuilder<[]>
  @Trace isShow: boolean = true
  @Trace isEnable: boolean = true
  @Trace isActive: boolean = false
}

@ObservedV2
export class TabData {
  @Trace tabData: Array<TabItem> = []
  @Trace pickedIndex: number = 0

  @Monitor('pickedIndex')
  onIndexChange() {
    this.changeTab()
  }

  constructor() {
    this.init()
    this.tabData[this.pickedIndex].isActive = true
  }

  private init(): void {
    TabDataJSON.forEach((item: ITabItem) => {
      const tabItem = new TabItem()
      tabItem.type = item.type
      tabItem.icon = item.icon
      tabItem.content = item.content
      this.tabData.push(tabItem)
    })
  }

  private changeTab(): void {
    this.tabData.forEach((item: TabItem, index: number) => {
      item.isActive = index === this.pickedIndex
    })
  }
}