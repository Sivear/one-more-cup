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

  /**
   * 根据饮品id查询饮品信息
   * @param beverageId
   * @returns
   */
  getBeverageById(beverageId: number): QueryResult<IBeverage> {
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(BeverageTableHandler.tableName)
    predicates.equalTo('id', beverageId)
    return BeverageTableHandler.query(predicates)
  }

  /**
   * 根据品牌id获取改品牌下的所有饮品信息
   * @param brandId
   * @returns
   */
  getBeverageByBrandId(brandId: number): QueryResult<IBeverage> {
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