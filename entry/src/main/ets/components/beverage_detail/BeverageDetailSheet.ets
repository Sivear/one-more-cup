import { IRecord } from '../../model/Record'
import { BeverageCup } from './BeverageCup'
import { BeverageName } from './BeverageName'
import { BeverageSize } from 'omc_db'
import { BeverageSatisfactionDegree } from './BeverageSatisfactionDegree'
import { BeveragePrice } from './BeveragePrice'
import { BeverageTemperature } from './BeverageTemperature'
import { BeverageSweetness } from './BeverageSweetness'
import { BeverageCondiment } from './BeverageCondiment'
import { BeverageNote } from './BeverageNote'

@Builder
function BeverageDetailSheet(params: IRecord) {
  Column({ space: 24 }) {
    // 饮品详情
    Text($r('app.string.beverage_detail'))
      .fontSize($r('app.float.font_size_20'))
      .fontWeight(800)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(20)

    BeverageName({
      brandId: params.id,
      brandName: params.brandName,
      beverageName: params.beverageName
    })

    BeverageCup({
      beverageSize: params.size as BeverageSize ?? BeverageSize.SMALL
    })

    BeverageSatisfactionDegree({
      degree: params.degree
    })

    BeveragePrice({
      price: params.price
    })

    BeverageTemperature()

    BeverageSweetness()

    BeverageCondiment()

    BeverageNote()

    Row() {
      Text($r('app.string.cancel'))
        .width(120)
        .height(54)
        .borderRadius(12)
        .padding(10)
        .backgroundColor($r('app.color.bg_03'))
        .fontWeight(400)
        .fontColor($r('app.color.text_03'))
        .fontSize(16)
        .lineHeight('100%')
        .textAlign(TextAlign.Center)

      Text($r('app.string.confirm'))
        .width(120)
        .height(54)
        .borderRadius(12)
        .padding(10)
        .backgroundColor($r('app.color.bg_04'))
        .fontWeight(400)
        .fontColor($r('app.color.start_window_background'))
        .fontSize(16)
        .lineHeight('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(54)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 8,
      right: 8
    })
  }
  .backgroundColor($r('app.color.start_window_background'))
  .justifyContent(FlexAlign.Center)
  .padding({
    top: 32,
    bottom: 32,
    left: 24,
    right: 24
  })
}

export const BeverageDetail: WrappedBuilder<[IRecord]> = wrapBuilder(BeverageDetailSheet)