import { DbHandler } from "omc_db"
import { ICondiment } from "omc_db/src/main/ets/database/types/condiment"
import { IRanking, Record } from "../model/Record"

@ObservedV2
export class HomePageViewModel {
  @Trace year: number = new Date().getFullYear()
  @Trace month: number = new Date().getMonth()
  @Trace recordList: Record[] = []
  @Trace private recordListByDay: Array<Record[]> = new Array(32)
  @Trace latestRecord: Record | undefined = undefined
  @Trace rankListByBrand: IRanking[] = []
  @Trace rankListByBeverage: IRanking[] = []
  condimentList: ICondiment[] = []
  // id 与 name 的映射，便于处理数据
  condimentMap: Map<number, string> = new Map()

  get isThisMonth() {
    return this.month === new Date().getMonth() && this.year === new Date().getFullYear()
  }

  initDate() {
    this.year = new Date().getFullYear()
    this.month = new Date().getMonth()
  }

  @Monitor("year", "month")
  private async initRecords() {
    try {
      this.recordList = await DbHandler.recordApi.getAllRecordsByMonth(this.year, this.month)
    } catch(e) {}
  }

  private async initCondiments() {
    try {
      this.condimentList = await DbHandler.condimentApi.getAllCondiments()
      this.condimentList.forEach((condiment) => {
        this.condimentMap.set(condiment.id!, condiment.name)
      })
    } catch(e) {}
  }

  async init() {
    await this.initCondiments()
    await this.initRecords()
  }

  /**
   * 根据date获取当天的列表
   * @param date 1~31
   * @returns
   */
  getRecordsByDate(date: number) {
    return this.recordListByDay[date] ?? []
  }

  /**
   * 获取当月杯数
   * @returns
   */
  getCountInThisMonth(): number {
    return this.recordList.length
  }

  /**
   * 获取当月消费
   * @returns
   */
  getConsumptionInThisMonth(): number {
    return this.recordList.reduce((res: number, item: Record) => res + item.price, 0)
  }

  /**
   * recordList变化的回调函数
   */
  @Monitor("recordList")
  onRecordListChange() {
    // 将记录按日期存放在map中
    const temp: Record[][] = new Array(32)
    this.recordList.forEach(item => {
      const day = new Date(item.time).getDate()
      if (temp[day]) {
        temp[day].push(item)
      } else {
        temp[day] = [item]
      }
    })
    this.recordListByDay = temp
    if (this.recordList.length > 0) {
      this.latestRecord = this.recordList.reduce((max, item) => (item.time > max.time ? item : max), this.recordList[0])
    }

    // 获取排行
    this.rankListByBrand = this.getRankingListByBrand()
    this.rankListByBeverage = this.getRankingListByBeverage()
  }

  condimentIdToName(list: number[]) {
    return list.map(item => this.condimentMap.get(item) ?? "")
  }

  /**
   * 删除记录
   * @param recordId
   */
  async deleteRecord(recordId: number) {
    await DbHandler.recordApi.deleteRecord(recordId)
    this.recordList = this.recordList.filter(item => item.id !== recordId)
  }

  /**
   * 本月喝奶茶的天数
   */
  getDayCountInThisMonth(): number {
    return this.recordListByDay.filter(item => item !== undefined).length
  }

  /**
   * 平均间隔天数
   */
  getAverageInterval(): number {
    const dayCount = this.getDayCountInThisMonth()
    return dayCount / (new Date(this.year, this.month + 1, 0).getDate())
  }

  /**
   * 获取平均每天金额
   */
  getAveragePrice(): number {
    return this.getConsumptionInThisMonth() / this.getDayCountInThisMonth()
  }

  /**
   * 获取品牌排行
   */
  getRankingListByBrand(): IRanking[] {
    // 1. 按 brandId 分组
    const grouped = this.recordList.reduce<Map<number, Record[]>>((acc, item) => {
      if (!acc.get(item.brandId)) {
        acc.set(item.brandId, [])
      }
      acc.get(item.brandId)!.push(item);
      return acc;
    }, new Map());

    // 2. 排序
    const sortedBrandIds = Array.from(grouped.keys())
      .sort((a, b) => (grouped.get(b)?.length ?? 0) - (grouped.get(a)?.length ?? 0));

    return sortedBrandIds.map(item => {
      const data: IRanking = {
        id: item,
        name: grouped.get(item)![0].brandName,
        count: grouped.get(item)!.length ?? 0,
        consumption: grouped.get(item)!.reduce((res: number, item: Record) => res + item.price, 0)
      }
      return data
    })

  }

  /**
   * 获取饮品排行
   */
  getRankingListByBeverage(): IRanking[] {
    const grouped = this.recordList.reduce<Map<number, Record[]>>((acc, item) => {
      if (!acc.get(item.beverageId)) {
        acc.set(item.beverageId, [])
      }
      acc.get(item.beverageId)!.push(item);
      return acc;
    }, new Map());

    const sortedBeverageIdIds = Array.from(grouped.keys())
      .sort((a, b) => (grouped.get(b)?.length ?? 0) - (grouped.get(a)?.length ?? 0));

    return sortedBeverageIdIds.map(item => {
      const data: IRanking = {
        id: item,
        name: grouped.get(item)![0].beverageName,
        count: grouped.get(item)!.length ?? 0,
        consumption: grouped.get(item)!.reduce((res: number, item: Record) => res + item.price, 0)
      }
      return data
    })

  }

}