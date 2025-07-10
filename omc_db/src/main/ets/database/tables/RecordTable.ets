import { getRdbStore } from '../db'
import rdb from '@ohos.data.relationalStore'
import { AbsTableHandler } from './AbsTableHandler';
import { SqlConstants } from '../constants/db_config';
import { IRecord } from '../types/record';
import { relationalStore } from '@kit.ArkData';
import { IconManager } from '../constants/presets/icons';


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

  protected async insertDefaultData(): Promise<void> {}

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

  async update(item: IRecord) {
    if (item.id === undefined) {
      return
    }
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        id: item.id,
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
}

export const RecordTableHandler = new RecordTable();

