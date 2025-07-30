import { getRdbStore } from '../db'
import rdb from '@ohos.data.relationalStore'
import beverageList from '../constants/presets/beverages.json'
import { AbsTableHandler } from './AbsTableHandler';
import { SqlConstants } from '../constants/db_config';
import { IBeverage } from '../types/beverage';
import { relationalStore } from '@kit.ArkData';
import { IconManager } from '../constants/presets/icons';


export class BeverageTable extends AbsTableHandler<IBeverage> {
  tableName: SqlConstants.TableNames = SqlConstants.TableNames.BEVERAGE_TABLE;
  private static _instance: BeverageTable | undefined = undefined;

  constructor() {
    super()
    if (!BeverageTable._instance) {
      BeverageTable._instance = this
    }
    return BeverageTable._instance
  }

  protected async insertDefaultData(): Promise<void> {
    for (let item of beverageList) {
      await this.insert(item)
    }
  }

  async insert(item: IBeverage) {
    try {
      const db = await getRdbStore()
      const valueBucket: relationalStore.ValuesBucket = {
        name: item.name,
        degree: item.degree ?? 0,
        is_preset: item.isPreset ? 1 : 0,
        icon: item.icon ?? IconManager.getRandomIcon(),
        brand_id: item.brandId
      }
      if (item.id !== undefined) {
        valueBucket.id = item.id
      }
      db.insertSync(this.tableName, valueBucket)
    } catch (e) {
    }
  }

  async update(item: Partial<IBeverage>) {
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
      if (item.degree !== undefined) valueBucket.degree = item.degree;
      if (item.icon !== undefined) valueBucket.icon = item.icon;

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
      const res: Array<IBeverage> = new Array()
      while (resultSet.goToNextRow()) {
        res.push(
          {
            id: resultSet.getLong(resultSet.getColumnIndex("id")),
            name: resultSet.getString(resultSet.getColumnIndex("name")),
            isPreset: resultSet.getLong(resultSet.getColumnIndex("is_preset")) === 1,
            degree: resultSet.getLong(resultSet.getColumnIndex("degree")),
            icon: resultSet.getString(resultSet.getColumnIndex("icon")),
            brandId: resultSet.getLong(resultSet.getColumnIndex("brand_id"))
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

export const BeverageTableHandler = new BeverageTable();

