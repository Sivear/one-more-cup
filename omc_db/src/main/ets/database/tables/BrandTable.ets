import { getRdbStore } from '../db'
import rdb from '@ohos.data.relationalStore'
import brandsList from '../constants/presets/brands.json'
import { AbsTableHandler } from './AbsTableHandler';
import { SqlConstants } from '../constants/db_config';
import { IBrand } from '../types/brand';
import { relationalStore } from '@kit.ArkData';


export class BrandTable extends AbsTableHandler<IBrand> {
  tableName: SqlConstants.TableNames = SqlConstants.TableNames.BRAND_TABLE;
  private static _instance: BrandTable | undefined = undefined;

  constructor() {
    super()
    if (!BrandTable._instance) {
      BrandTable._instance = this
    }
    return BrandTable._instance
  }

  protected async insertDefaultData(): Promise<void> {
    for (let item of brandsList) {
      await this.insert(item)
    }
  }

  async insert(item: IBrand) {
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        name: item.name,
        previous_time: item.previousTime ?? 0,
        is_preset: item.isPreset ? 1 : 0
      }
      if (item.id !== undefined) {
        valueBucket.id = item.id
      }
      db.insertSync(this.tableName, valueBucket)
    } catch (e) {
    }
  }

  async update(item: Partial<IBrand>) {
    if (item.id === undefined) {
      return
    }
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        id: item.id
      }

      if (item.name !== undefined) valueBucket.name = item.name;
      if (item.isPreset !== undefined) valueBucket.is_preset = item.isPreset ? 1 : 0;
      if (item.previousTime !== undefined) valueBucket.previous_time = item.previousTime;

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
      const res: Array<IBrand> = new Array()
      while (resultSet.goToNextRow()) {
        res.push(
          {
            id: resultSet.getLong(resultSet.getColumnIndex("id")),
            name: resultSet.getString(resultSet.getColumnIndex("name")),
            isPreset: resultSet.getLong(resultSet.getColumnIndex("is_preset")) === 1,
            previousTime: resultSet.getLong(resultSet.getColumnIndex("previous_time"))
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

export const BrandTableHandler = new BrandTable();

