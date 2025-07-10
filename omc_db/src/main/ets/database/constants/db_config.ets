import relationalStore from '@ohos.data.relationalStore'
import rdb from '@ohos.data.relationalStore'

/**
 * 数据库配置
 */
const DB_NAME = 'app.db'

export const DB_VERSION = 1

export const STORE_CONFIG: rdb.StoreConfig = {
  name: DB_NAME,
  securityLevel: relationalStore.SecurityLevel.S1
}

/**
 * 数据库常量（例如建表指令、table名称等
 */
export namespace SqlConstants {
  export enum TableNames {
    BRAND_TABLE = "BRANDS",
    BEVERAGE_TABLE = "BEVERAGES",
    RECORD_TABLE = "RECORDS",
    CONDIMENT_TABLE = "CONDIMENTS"
  }

  export namespace SqlCommands {
    // 创建品牌table
    export const CREATE_BRAND_TABLE = `CREATE TABLE IF NOT EXISTS ${TableNames.BRAND_TABLE} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          previous_time INTEGER,
          is_preset INTEGER DEFAULT 0
        )`

    // 创建饮品table
    export const CREATE_BEVERAGE_TABLE = `CREATE TABLE IF NOT EXISTS ${TableNames.BEVERAGE_TABLE} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          is_preset INTEGER DEFAULT 0,
          degree INTEGER,
          brand_id INTEGER,
          FOREIGN KEY (brand_id) REFERENCES ${TableNames.BRAND_TABLE}(id)
        )`

    // 创建小料table
    export const CREATE_CONDIMENT_TABLE = `CREATE TABLE IF NOT EXISTS ${TableNames.CONDIMENT_TABLE} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          is_preset INTEGER DEFAULT 0
        )`

    // 创建购买记录table
    export const CREATE_RECORD_TABLE = `CREATE TABLE IF NOT EXISTS ${TableNames.RECORD_TABLE} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          time INTEGER NOT NULL,
          remark TEXT,
          price INTEGER,
          size TEXT,
          sweetness TEXT,
          temperature TEXT,
          condiments TEXT,
          color INTEGER,
          icon TEXT,
          beverage_id INTEGER,
          FOREIGN KEY (beverage_id) REFERENCES ${TableNames.BEVERAGE_TABLE}(id)
        )`

  }


}