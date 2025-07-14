import { getRdbStore } from '../db'
import rdb from '@ohos.data.relationalStore'
import { AbsTableHandler } from './AbsTableHandler';
import { SqlConstants } from '../constants/db_config';
import { IRecord } from '../types/record';
import { relationalStore } from '@kit.ArkData';
import { IconManager } from '../constants/presets/icons';
import mockData from '../constants/presets/mockRecords.json'


export class RecordTable extends AbsTableHandler<IRecord> {
  tableName: SqlConstants.TableNames = SqlConstants.TableNames.RECORD_TABLE;
  private static _instance: RecordTable | undefined = undefined;

  constructor() {
    super()
    if (!RecordTable._instance) {
      RecordTable._instance = this
    }
    return RecordTable._instance
  }

  protected async insertDefaultData(): Promise<void> {
    for (let item of mockData) {
      await this.insert(item)
    }
  }

  async insert(item: IRecord) {
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        time: item.time,
        remark: item.remark ?? "",
        price: item.price,
        size: item.size ?? "",
        sweetness: item.sweetness ?? "",
        temperature: item.temperature ?? "",
        condiments: item.condiments ? item.condiments.join(",") : "",
        color: item.color ?? 14221013,
        icon: item.icon ?? IconManager.getRandomIcon(),
        beverage_id: item.beverageId
      }
      if (item.id !== undefined) {
        valueBucket.id = item.id
      }
      db.insertSync(this.tableName, valueBucket)
    } catch (e) {
    }
  }

  async update(item: Partial<IRecord>) {
    if (item.id === undefined) {
      return
    }
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        id: item.id,
      }
      if (item.time !== undefined) valueBucket.time = item.time;
      if (item.remark !== undefined) valueBucket.remark = item.remark;
      if (item.price !== undefined) valueBucket.price = item.price;
      if (item.size !== undefined) valueBucket.size = item.size;
      if (item.sweetness !== undefined) valueBucket.sweetness = item.sweetness;
      if (item.temperature !== undefined) valueBucket.temperature = item.temperature;
      if (item.condiments !== undefined) valueBucket.condiments = item.condiments.join(",");
      if (item.color !== undefined) valueBucket.color = item.color;
      if (item.icon !== undefined) valueBucket.icon = item.icon;
      if (item.beverageId !== undefined) valueBucket.beverage_id = item.beverageId;

      const predicates = new rdb.RdbPredicates(this.tableName)
      predicates.equalTo("id", item.id)
      db.updateSync(valueBucket, predicates)
    } catch (e) {
    }
  }

  async query(predicates: rdb.RdbPredicates, columns?: Array<string>) {
    try {
      const db = await getRdbStore()

      const resultSet = db.querySync(predicates, columns)
      const res: Array<IRecord> = new Array()
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
            beverageId: resultSet.getLong(resultSet.getColumnIndex("beverage_id"))
          }
        )
      }
      resultSet.close()
      return res

    } catch (e) {
      return []
    }
  }

  async querySql(sql: string, callback: (resultSet: rdb.ResultSet) => void) {
    try {
      const db = await getRdbStore()

      const resultSet = db.querySqlSync(sql)
      callback(resultSet)
      resultSet.close()
    } catch (e) {

    }
  }
}

export const RecordTableHandler = new RecordTable();

