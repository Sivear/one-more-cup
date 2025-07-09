import { BrandTableHandler } from "../database/tables/BrandTable"
import { relationalStore } from "@kit.ArkData"
import { QueryResult } from "../database/types/common"
import { IBrand } from "../database/types/brand"

export class BrandApi {
  private static _instance: BrandApi | undefined

  private constructor() {}

  public static getInstance() {
    if (!BrandApi._instance) {
      BrandApi._instance = new BrandApi()
    }
    return BrandApi._instance
  }

  getAllBrands(): QueryResult<IBrand> {
    return BrandTableHandler.query(new relationalStore.RdbPredicates(BrandTableHandler.tableName))
  }

  addBrand(data: IBrand): Promise<void> {
    return BrandTableHandler.insert(data)
  }

  deleteBrand(id: number): Promise<void> {
    return BrandTableHandler.delete(id)
  }

  async updateBrand(data: IBrand): Promise<void> {
    if (data.id === undefined) {
      return
    }
    return BrandTableHandler.update(data)
  }

  clear(): Promise<void> {
    return BrandTableHandler.clear()
  }

}