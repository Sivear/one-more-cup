import { relationalStore } from "@kit.ArkData"
import { RecordTableHandler } from "../database/tables/RecordTable"
import { QueryResult } from "../database/types/common"
import { IRecord } from "../database/types/record"

export class RecordApi {
  private static _instance: RecordApi | undefined

  private constructor() {}

  public static getInstance() {
    if (!RecordApi._instance) {
      RecordApi._instance = new RecordApi()
    }
    return RecordApi._instance
  }

  getAllRecords(): QueryResult<IRecord> {
    return RecordTableHandler.query(new relationalStore.RdbPredicates(RecordTableHandler.tableName))
  }

  addRecord(data: IRecord): Promise<void> {
    return RecordTableHandler.insert(data)
  }

  deleteRecord(id: number): Promise<void> {
    return RecordTableHandler.delete(id)
  }

  async updateRecord(data: IRecord): Promise<void> {
    if (data.id === undefined) {
      return
    }
    return RecordTableHandler.update(data)
  }

  clear(): Promise<void> {
    return RecordTableHandler.clear()
  }

}