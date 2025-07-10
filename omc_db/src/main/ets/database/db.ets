import relationalStore from '@ohos.data.relationalStore'
import rdb from '@ohos.data.relationalStore'
import { DB_VERSION, STORE_CONFIG, SqlConstants } from './constants/db_config'
import { BusinessError } from '@kit.BasicServicesKit'


let store: rdb.RdbStore
let uiContext: UIContext | undefined

const createTableSqlList = [
  SqlConstants.SqlCommands.CREATE_BRAND_TABLE,
  SqlConstants.SqlCommands.CREATE_BEVERAGE_TABLE,
  SqlConstants.SqlCommands.CREATE_RECORD_TABLE,
  SqlConstants.SqlCommands.CREATE_CONDIMENT_TABLE
]

export async function getRdbStore(): Promise<rdb.RdbStore> {
  if (store) return store
  if (!uiContext) {
    uiContext = AppStorage.get("uiContext")
  }

  return new Promise((resolve, reject) => {
    rdb.getRdbStore(uiContext?.getHostContext(), STORE_CONFIG, (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
      if (err) {
        reject(err)
      } else {
        store = rdbStore
        if (store) {
          for(let sql of createTableSqlList) {
            try {
              store.executeSync(sql)
            } catch (e) {}
          }
          resolve(store)
        }
      }
    })
  })
}
