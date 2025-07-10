import { SqlConstants } from "../constants/db_config";
import rdb from '@ohos.data.relationalStore'
import { QueryResult } from "../types/common";

export interface ITableHandler<T> {
  readonly tableName: SqlConstants.TableNames;

  initData(): void;

  getCount(): Promise<number>;

  insert(item: T): Promise<void>;

  update(item: T): Promise<void>;

  delete(id: number): Promise<void>;

  query(predicates: rdb.RdbPredicates, columns?: Array<string>): QueryResult<T>;

  clear(): Promise<void>;
}