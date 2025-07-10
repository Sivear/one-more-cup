import { SqlConstants } from "../constants/db_config";
import { getRdbStore } from "../db";
import { ITableHandler } from "./ITableHandler";
import { relationalStore } from "@kit.ArkData";
import rdb from '@ohos.data.relationalStore'

export abstract class AbsTableHandler<T> implements ITableHandler<T> {
  abstract tableName: SqlConstants.TableNames

  async initData() {
    try {
      const count = await this.getCount()
      if (count === 0) {
        await this.insertDefaultData()
      }
    } catch (e) {

    }
  }

  protected abstract insertDefaultData(): Promise<void>;

  async getCount(): Promise<number> {
    try {
      const db = await getRdbStore()
      let count = 0
      const res = db.querySqlSync(`SELECT COUNT(*) as count FROM ${this.tableName}`)
      if (res.goToFirstRow()) {
        count = res.getLong(res.getColumnIndex('count'))
      }
      res.close()
      return Promise.resolve(count)
    } catch (e) {
      return Promise.reject(e)
    }

  }

  async delete(id: number) {
    try {
      const db = await getRdbStore()
      const predicate = new relationalStore.RdbPredicates(this.tableName)
      predicate.equalTo("id", id)
      db.deleteSync(predicate)
    } catch (e) {}
  }

  async clear() {
    try {
      const db = await getRdbStore()
      db.executeSync(`DELETE FROM ${this.tableName}`)
    } catch (e) {}
  }


  abstract insert(item: T);

  abstract update(item: T);

  abstract query(predicates: rdb.RdbPredicates, columns?: Array<string>);
}