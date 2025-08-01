import { BeverageCup } from './BeverageCup'
import { BeverageName } from './BeverageName'
import { BeverageSize, BeverageSweetness, BeverageTemperature } from 'omc_db'
import { BeverageSatisfactionDegree } from './BeverageSatisfactionDegree'
import { BeveragePrice } from './BeveragePrice'
import { BeverageTemperatureComp } from './BeverageTemperature'
import { BeverageSweetnessComp } from './BeverageSweetness'
import { BeverageCondiment } from './BeverageCondiment'
import { BeverageNote } from './BeverageNote'
import { BeverageDetailViewModel } from './viewmodel/BeverageDetailViewModel'
import { DrinkRecord } from '../../model/Record'
import { EventBusHandler } from '../../utils/EventBus/EventBus'
import { Events } from '../../utils/EventBus/Events'
import { HMRouterMgr } from '@hadss/hmrouter'

@ComponentV2
struct BeverageDetailSheet {
  @Param @Once @Require drinkRecordParam: DrinkRecord
  @Local drinkRecord?: DrinkRecord
  private beverageDetailViewModel: BeverageDetailViewModel = new BeverageDetailViewModel()

  aboutToAppear(): void {
    this.beverageDetailViewModel.initUIContext(this.getUIContext())
    this.beverageDetailViewModel.initRecord(this.drinkRecordParam)
    this.drinkRecord = this.beverageDetailViewModel.getDrinkRecord()
  }

  build() {
    Column({ space: 24 }) {
      // 饮品详情
      Text($r('app.string.beverage_detail'))
        .fontSize($r('app.float.font_size_20'))
        .fontWeight(800)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(20)

      // 品牌名称，饮品名称，记录时间
      BeverageName({
        brandId: this.drinkRecord?.id,
        brandName: this.drinkRecord?.brandName,
        beverageName: this.drinkRecord?.beverageName,
        time: this.drinkRecord?.time,
        onTimeChange: (newTime: number) => {
          this.beverageDetailViewModel.onTimeChange(newTime)
        }
      })

      // 杯型
      BeverageCup({
        beverageSize: this.drinkRecord?.size as BeverageSize,
        onCupSizeChange: (newSize: BeverageSize) => {
          this.beverageDetailViewModel.onBeverageCupSizeChange(newSize)
        }
      })

      // 评价
      BeverageSatisfactionDegree({
        degree: this.drinkRecord?.degree,
        onDegreeChange: (newDegree: number) => {
          this.beverageDetailViewModel.onBeverageDegreeChange(newDegree)
        }
      })

      // 价格
      BeveragePrice({
        price: this.drinkRecord?.price,
        onPriceChange: (newPrice: number) => {
          this.beverageDetailViewModel.onBeveragePriceChange(newPrice)
        }
      })

      // 温度
      BeverageTemperatureComp({
        temperature: this.drinkRecord?.temperature as BeverageTemperature,
        onTemperatureChange: (newTemperature: BeverageTemperature) => {
          this.beverageDetailViewModel.onBeverageTemperatureChange(newTemperature)
        }
      })

      // 甜度
      BeverageSweetnessComp({
        sweetness: this.drinkRecord?.sweetness as BeverageSweetness,
        onSweetnessChange: (newSweetness: BeverageSweetness) => {
          this.beverageDetailViewModel.onBeverageSweetnessChange(newSweetness)
        }
      })

      // 小料
      BeverageCondiment({
        condiments: this.drinkRecord?.condiments,
        onCondimentsChange: (newCondiments: number[]) => {
          this.beverageDetailViewModel.onBeverageCondimentsChange(newCondiments)
        }
      })

      // 备注
      BeverageNote({
        remark: this.drinkRecord?.remark,
        onRemarkChange: (newRemark: string) => {
          this.beverageDetailViewModel.onBeverageRemarkChange(newRemark)
        }
      })

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
          .onClick(() => {
            this.beverageDetailViewModel.closeBeverageDetailSheet(this.getUIContext())
          })

        Text($r('app.string.confirm'))
          .width(120)
          .height(54)
          .borderRadius(12)
          .padding(10)
          .backgroundColor($r('app.color.bg_05'))
          .fontWeight(400)
          .fontColor($r('app.color.start_window_background'))
          .fontSize(16)
          .lineHeight('100%')
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.beverageDetailViewModel.updateDrinkRecord()
            EventBusHandler.emit(Events.RECORD_LIST_CHANGE)
            HMRouterMgr.pop()
          })
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
}

export interface IBeverageDetailParams {
  record: DrinkRecord
}

@Builder
function BeverageDetailSheetBuilder(params: IBeverageDetailParams) {
  BeverageDetailSheet({
    drinkRecordParam: params.record
  })
}

export const BeverageDetail: WrappedBuilder<[IBeverageDetailParams]> = wrapBuilder(BeverageDetailSheetBuilder)