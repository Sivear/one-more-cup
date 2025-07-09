import { relationalStore } from "@kit.ArkData"
import { CondimentTableHandler } from "../database/tables/CondimentTable"
import { QueryResult } from "../database/types/common"
import { ICondiment } from "../database/types/condiment"

export class CondimentApi {
  private static _instance: CondimentApi | undefined

  private constructor() {}

  public static getInstance() {
    if (!CondimentApi._instance) {
      CondimentApi._instance = new CondimentApi()
    }
    return CondimentApi._instance
  }

  getAllCondiments(): QueryResult<ICondiment> {
    return CondimentTableHandler.query(new relationalStore.RdbPredicates(CondimentTableHandler.tableName))
  }

  addCondiment(data: ICondiment): Promise<void> {
    return CondimentTableHandler.insert(data)
  }

  deleteCondiment(id: number): Promise<void> {
    return CondimentTableHandler.delete(id)
  }

  async updateCondiment(data: ICondiment): Promise<void> {
    if (data.id === undefined) {
      return
    }
    return CondimentTableHandler.update(data)
  }

  clear(): Promise<void> {
    return CondimentTableHandler.clear()
  }

}