import { DbHandler } from "omc_db"
import { ICondiment } from "omc_db/src/main/ets/database/types/condiment"
import { Record } from "../model/Record"

@ObservedV2
export class HomePageViewModel {
  @Trace year: number = new Date().getFullYear()
  @Trace month: number = new Date().getMonth()
  @Trace recordList: Record[] = []
  @Trace private recordListByDay: Array<Record[]> = new Array(32)
  @Trace latestRecord: Record | undefined = undefined
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
   *
   * @returns
   */
  @Monitor("recordList")
  onRecordListChange() {
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
}