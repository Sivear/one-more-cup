import { BeverageSize, BeverageSweetness, BeverageTemperature, IBeverage, IBrand } from 'omc_db'
import { DrinkRecord } from '../../../model/Record'

@ObservedV2
export class BeverageDetailViewModel {
  @Trace private drinkRecord?: DrinkRecord

  // 初始化奶茶记录
  public initRecord(beverage: IBeverage, brand: IBrand): void {
    this.drinkRecord = new DrinkRecord({
      id: Math.random(),
      time: Date.now(),
      remark: '',
      price: 11,
      size: BeverageSize.SMALL,
      sweetness: BeverageSweetness.NO_SUGAR,
      temperature: BeverageTemperature.HOT,
      condiments: [],
      beverageId: beverage.id ?? 0,
      brandId: brand.id ?? 0,
      beverageName: beverage.name,
      brandName: brand.name,
      degree: beverage.degree ?? 0
    })
  }

  // 获取奶茶记录
  public getDrinkRecord(): DrinkRecord {
    return this.drinkRecord ?? new DrinkRecord({
      time: Date.now(),
      price: 10,
      beverageId: 0,
      brandId: 0,
      beverageName: '',
      brandName: '',
      degree: 0
    })
  }

  // 更新记录时间
  public onTimeChange(newTime: number): void {
    if (this.drinkRecord && newTime > 0) {
      this.drinkRecord.time = newTime
    }
  }

  // 更新奶茶杯型
  public onBeverageCupSizeChange(newSize: BeverageSize): void {
    if (this.drinkRecord) {
      this.drinkRecord.size = newSize
    }
  }

  // 更新评分
  public onBeverageDegreeChange(newDegree: number): void {
    if (this.drinkRecord && newDegree >= 0) {
      this.drinkRecord.degree = newDegree
    }
  }

  // 更新价格
  public onBeveragePriceChange(newPrice: number): void {
    if (this.drinkRecord && newPrice >= 0) {
      this.drinkRecord.price = newPrice
    }
  }

  // 更新温度
  public onBeverageTemperatureChange(newTemperature: BeverageTemperature): void {
    if (this.drinkRecord) {
      this.drinkRecord.temperature = newTemperature
    }
  }

  // 更新甜度
  public onBeverageSweetnessChange(newSweetness: BeverageSweetness): void {
    if (this.drinkRecord) {
      this.drinkRecord.sweetness = newSweetness
    }
  }

  // 更新小料
  public onBeverageCondimentsChange(newCondiments: number[]): void {
    if (this.drinkRecord) {
      this.drinkRecord.condiments = newCondiments
    }
  }
}