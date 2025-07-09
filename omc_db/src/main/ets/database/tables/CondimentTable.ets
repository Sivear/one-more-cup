import { getRdbStore } from '../db'
import rdb from '@ohos.data.relationalStore'
import condimentsList from '../constants/presets/condiments.json'
import { AbsTableHandler } from './AbsTableHandler';
import { SqlConstants } from '../constants/db_config';
import { ICondiment } from '../types/condiment';
import { relationalStore } from '@kit.ArkData';


export class CondimentTable extends AbsTableHandler<ICondiment> {
  tableName: SqlConstants.TableNames = SqlConstants.TableNames.CONDIMENT_TABLE;
  private static _instance: CondimentTable | undefined = undefined;

  constructor() {
    super()
    if (!CondimentTable._instance) {
      CondimentTable._instance = this
    }
    return CondimentTable._instance
  }

  protected async insertDefaultData(): Promise<void> {
    for (let item of condimentsList) {
      await this.insert(item)
    }
  }

  async insert(item: ICondiment) {
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        name: item.name,
        is_preset: item.isPreset ? 1 : 0
      }
      if (item.id !== undefined) {
        valueBucket.id = item.id
      }
      db.insertSync(this.tableName, valueBucket)
    } catch (e) {
    }
  }

  async update(item: ICondiment) {
    if (item.id === undefined) {
      return
    }
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        id: item.id,
        name: item.name,
        is_preset: item.isPreset ? 1 : 0
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
      const res: Array<ICondiment> = new Array()
      while (resultSet.goToNextRow()) {
        res.push(
          {
            id: resultSet.getLong(resultSet.getColumnIndex("id")),
            name: resultSet.getString(resultSet.getColumnIndex("name")),
            isPreset: resultSet.getLong(resultSet.getColumnIndex("is_preset")) === 1,
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

export const CondimentTableHandler = new CondimentTable();

