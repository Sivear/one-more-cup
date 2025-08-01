import { IBeverage, IconManager } from 'omc_db'
import { BeverageItemType, PresetMode } from '../../viewmodel/BeverageChooseViewModel'

export class BrandSelectInfo {
  brandName: string = ''
  isChosen: boolean = false
  cb: () => void = () => {
  }
}

export interface BeverageManageInfo {
  beverageItem: IBeverage
  mode: PresetMode
  cb: (type: BeverageItemType, itemInfo?: IBeverage) => void
}

// 左侧品牌列表列表项
@Builder
export function BrandListItem(info: BrandSelectInfo) {
  Column() {
    Image($r('app.media.cat_drinking'))
      .width(48)
      .height(48)
      .outline({ width: info.isChosen ? 2 : 0, color: $r('app.color.primary'), radius: 6 })
      .borderRadius(6)
      .margin({ top: 4, bottom: 4 })

    Text(info.brandName)
      .fontSize(12)
      .fontColor(info.isChosen ? $r('app.color.omc_tab_active') : $r('app.color.text_02'))
      .maxLines(3)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .padding({ left: 4, right: 4 })
  }
  .width('100%')
  .justifyContent(FlexAlign.Center)
  .onClick(() => {
    info.cb()
  })
}


// “最近”列表的列表项
@Builder
export function RecentBeverageItem(brInfo: BeverageManageInfo) {
  Row({ space: 10 }) {
    // todo 品牌logo
    Image($r('app.media.cat_drinking'))
      .width(36)
      .height(36)
      .borderRadius(6)

    Text(brInfo.beverageItem.name)
      .fontSize(14)
  }
  .justifyContent(FlexAlign.Start)
  .onClick(() => {
    brInfo.cb(BeverageItemType.ITEM, brInfo.beverageItem)
  })
}

// 饮品列表的列表项
@Builder
export function BeverageListItem(brInfo: BeverageManageInfo) {
  Row() {
    // 饮品名称和logo
    Row({ space: 10 }) {
      // todo 图标映射
      Image(IconManager.getIconById(brInfo.beverageItem.icon ?? ""))
        .width(16)

      Text(brInfo.beverageItem.name)
        .fontSize(14)
    }
    .padding(1)
    .justifyContent(FlexAlign.Start)
    .layoutWeight(1)
    .onClick(() => {
      brInfo.cb(BeverageItemType.ITEM, brInfo.beverageItem)
    })

    // 非系统预设的饮品可以进行编辑和删除
    if (!brInfo.beverageItem.isPreset) {
      Row({ space: 9 }) {
        if (brInfo.mode === PresetMode.EDIT) {
          // 编辑饮品预设
          Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
            Image($r('app.media.edit'))
              .width(14)
              .height(14)
              .fillColor($r('app.color.omc_tab_active'))
          }
          .borderRadius(4)
          .padding(2)
          .onClick(() => {
            brInfo.cb(BeverageItemType.EDIT, brInfo.beverageItem)
          })
        }

        if (brInfo.mode === PresetMode.DELETE) {
          // 删除饮品预设
          Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
            Image($r('app.media.delete'))
              .width(14)
              .height(14)
              .fillColor($r('app.color.omc_tab_active'))
          }
          .borderRadius(4)
          .padding(2)
          .onClick(() => {
            brInfo.cb(BeverageItemType.DELETE, brInfo.beverageItem)
          })
        }
      }
      .justifyContent(FlexAlign.End)
    }

  }
  .width('100%')
  .padding({ left: 4 })
  .justifyContent(FlexAlign.SpaceBetween)

}