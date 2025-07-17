import { relationalStore } from '@kit.ArkData'
import { QueryResult } from '../database/types/common'
import { IBeverage } from '../database/types/beverage'
import { BeverageTableHandler } from '../database/tables/BeverageTable'

export class BeverageApi {
  private static _instance: BeverageApi | undefined

  private constructor() {
  }

  public static getInstance() {
    if (!BeverageApi._instance) {
      BeverageApi._instance = new BeverageApi()
    }
    return BeverageApi._instance
  }

  getAllBeverages(): QueryResult<IBeverage> {
    return BeverageTableHandler.query(new relationalStore.RdbPredicates(BeverageTableHandler.tableName))
  }

  getBeverageByBrand(brandId: number): QueryResult<IBeverage> {
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(BeverageTableHandler.tableName)
    predicates.equalTo('brand_id', brandId)
    return BeverageTableHandler.query(predicates)
  }

  addBeverage(data: IBeverage): Promise<void> {
    return BeverageTableHandler.insert(data)
  }

  deleteBeverage(id: number): Promise<void> {
    return BeverageTableHandler.delete(id)
  }

  async updateBeverage(data: Partial<IBeverage>): Promise<void> {
    if (data.id === undefined) {
      return
    }
    return BeverageTableHandler.update(data)
  }

  clear(): Promise<void> {
    return BeverageTableHandler.clear()
  }
}