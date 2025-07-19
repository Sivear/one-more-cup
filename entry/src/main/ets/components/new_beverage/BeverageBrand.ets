import { IBeverage, IBrand } from 'omc_db'
import { BeverageChooseViewModel } from '../../viewmodel/BeverageChooseViewModel'
import { BrandListItem, RecentBeverageItem } from './ListItem'

@ComponentV2
export struct BeverageBrand {
  beverageChooseVM: BeverageChooseViewModel = new BeverageChooseViewModel()

  aboutToAppear(): void {
    this.beverageChooseVM.initData()
  }

  build() {
    Row({ space: 30 }) {
      // 左侧品牌的懒加载列表
      List({ space: 20, initialIndex: 0 }) {
        LazyForEach(this.beverageChooseVM.brandData, (item: IBrand, index: number) => {
          ListItem() {
            BrandListItem({
              brandName: item.name,
              isChosen: this.beverageChooseVM.curBrand === index,
              cb: () => {
                this.beverageChooseVM.changeBrand(index)
              }
            })
          }
        }, (item: IBrand) => JSON.stringify(item))
      }
      .width('25%')
      .height('100%')
      .friction(0.6)
      .alignListItem(ListItemAlign.Center)
      .scrollBar(BarState.Off)

      Divider()
        .strokeWidth(1)
        .vertical(true)

      // 右侧饮品的懒加载列表
      List({ space: 24, initialIndex: 0 }) {
        LazyForEach(this.beverageChooseVM.beverageData, (item: IBeverage) => {
          ListItem() {
            RecentBeverageItem(item)
          }
          .onClick(() => {
            this.beverageChooseVM.chooseBeverage(this.getUIContext(), this.getUniqueId(), item)
          })
        }, (item: IBeverage) => JSON.stringify(item))
      }
      .layoutWeight(1)
      .height('100%')
      .friction(0.6)
      .alignListItem(ListItemAlign.Start)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 24,
      right: 24,
      top: 12,
      bottom: 12
    })
  }
}