import { BeverageSize, BeverageSweetness, BeverageTemperature, IBeverage, IBrand } from 'omc_db'
import { DrinkRecord } from '../../../model/Record'

@ObservedV2
export class BeverageDetailViewModel {
  @Trace private drinkRecord?: DrinkRecord

  public initRecord(beverage: IBeverage, brand: IBrand): void {
    this.drinkRecord = new DrinkRecord({
      id: Math.random(),
      time: Date.now(),
      remark: '',
      price: 11,
      size: BeverageSize.MEDIUM,
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
}