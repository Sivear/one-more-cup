import { IBeverage } from 'omc_db'

export class BrandSelectInfo {
  brandName: string = ''
  isChosen: boolean = false
  cb: () => void = () => {
  }
}

// 左侧品牌列表列表项
@Builder
export function BrandListItem(info: BrandSelectInfo) {
  Column() {
    Image($r('app.media.cat_drinking'))
      .width(48)
      .height(48)
      .outline({ width: info.isChosen ? 2 : 0, color: $r('app.color.primary') })
      .borderRadius(6)
      .margin({ bottom: 8 })

    Text(info.brandName)
      .fontSize(12)
      .fontColor(info.isChosen ? $r('app.color.omc_tab_active') : $r('app.color.text_02'))
  }
  .width('100%')
  .justifyContent(FlexAlign.Center)
  .onClick(() => {
    info.cb()
  })
}


// “最近”列表的列表项
@Builder
export function RecentBeverageItem(beverageItem: IBeverage) {
  Row({ space: 10 }) {
    // todo 品牌logo
    Image($r('app.media.cat_drinking'))
      .width(36)
      .height(36)
      .borderRadius(6)

    Text(beverageItem.name)
      .fontSize(14)
  }
  .justifyContent(FlexAlign.Start)
}

// 饮品列表的列表项
@Builder
export function BeverageListItem(beverageItem: IBeverage) {
  Row({ space: 10 }) {
    // todo 图标映射
    Image($r('app.media.omc_home_icon'))
      .width(16)

    Text(beverageItem.name)
      .fontSize(14)
  }
  .justifyContent(FlexAlign.Start)
}