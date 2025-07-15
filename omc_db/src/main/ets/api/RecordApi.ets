import { relationalStore } from "@kit.ArkData"
import { RecordTableHandler } from "../database/tables/RecordTable"
import { QueryResult } from "../database/types/common"
import { IRecord } from "../database/types/record"

interface IRecordRes extends IRecord {
  brandId: number,
  brandName: string,
  beverageId: number,
  beverageName: string,
  degree: number
}

export class RecordApi {
  private static _instance: RecordApi | undefined

  private constructor() {}

  public static getInstance() {
    if (!RecordApi._instance) {
      RecordApi._instance = new RecordApi()
    }
    return RecordApi._instance
  }

  getAllRecords(): QueryResult<IRecordRes> {
    const SQL = `
      SELECT
        r.*,
        b.name AS beverage_name,
        br.id AS brand_id,
        br.name AS brand_name,
        b.degree AS degree
      FROM
        RECORDS r
      INNER JOIN
        BEVERAGES b ON r.beverage_id = b.id
      INNER JOIN
        BRANDS br ON b.brand_id = br.id
    `

    return this._getAllRecords(SQL)
  }

  getAllRecordsByMonth(year: number, month: number): QueryResult<IRecordRes> {
    const start = new Date(year, month, 1)
    const end = new Date(year, month + 1, 0, 23, 59, 59, 999) // 下个月的第0天即为本月最后一天
    const SQL = `
      SELECT
        r.*,
        b.name AS beverage_name,
        br.id AS brand_id,
        br.name AS brand_name,
        b.degree AS degree
      FROM
        RECORDS r
      INNER JOIN
        BEVERAGES b ON r.beverage_id = b.id
      INNER JOIN
        BRANDS br ON b.brand_id = br.id
      WHERE
        r.time >= ${start.getTime()} AND r.time <= ${end.getTime()}
    `

    return this._getAllRecords(SQL)
  }

  private _getAllRecords(SQL: string): QueryResult<IRecordRes> {
    return new Promise((resolve) => {
      RecordTableHandler.querySql(SQL, (resultSet: relationalStore.ResultSet) => {
        const res: Array<IRecordRes> = new Array()
        while (resultSet.goToNextRow()) {
          const condiments = resultSet.getString(resultSet.getColumnIndex("condiments"))
          res.push(
            {
              id: resultSet.getLong(resultSet.getColumnIndex("id")),
              time: resultSet.getLong(resultSet.getColumnIndex("time")),
              remark: resultSet.getString(resultSet.getColumnIndex("remark")),
              price: resultSet.getLong(resultSet.getColumnIndex("price")),
              size: resultSet.getString(resultSet.getColumnIndex("size")),
              sweetness: resultSet.getString(resultSet.getColumnIndex("sweetness")),
              temperature: resultSet.getString(resultSet.getColumnIndex("temperature")),
              condiments: condiments.length === 0 ? [] : condiments.split(",").map((num) => parseInt(num)),
              color: resultSet.getLong(resultSet.getColumnIndex("color")),
              icon: resultSet.getString(resultSet.getColumnIndex("icon")),
              beverageId: resultSet.getLong(resultSet.getColumnIndex("beverage_id")),
              brandId: resultSet.getLong(resultSet.getColumnIndex("brand_id")),
              beverageName: resultSet.getString(resultSet.getColumnIndex("beverage_name")),
              brandName: resultSet.getString(resultSet.getColumnIndex("brand_name")),
              degree: resultSet.getLong(resultSet.getColumnIndex("degree"))
            }
          )
        }
        resolve(res)
      })
    })
  }

  addRecord(data: IRecord): Promise<void> {
    return RecordTableHandler.insert(data)
  }

  deleteRecord(id: number): Promise<void> {
    return RecordTableHandler.delete(id)
  }

  async updateRecord(data: Partial<IRecord>): Promise<void> {
    if (data.id === undefined) {
      return
    }
    return RecordTableHandler.update(data)
  }

  clear(): Promise<void> {
    return RecordTableHandler.clear()
  }

}