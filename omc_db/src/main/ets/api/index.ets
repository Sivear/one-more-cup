import { BeverageTableHandler } from "../database/tables/BeverageTable";
import { BrandTableHandler } from "../database/tables/BrandTable";
import { CondimentTableHandler } from "../database/tables/CondimentTable";
import { BeverageApi } from "./BeverageApi";
import { BrandApi } from "./BrandApi";
import { CondimentApi } from "./CondimentApi";
import { RecordApi } from "./RecordApi";

export namespace DbHandler {
  // 数据库中几个表的数据初始化
  export async function initDbData() {
    await BrandTableHandler.initData()
    await BeverageTableHandler.initData()
    await CondimentTableHandler.initData()
  }

  export const brandApi = BrandApi.getInstance()

  export const beverageApi = BeverageApi.getInstance()

  export const condimentApi = CondimentApi.getInstance()

  export const recordApi = RecordApi.getInstance()

}