import { BeverageSize, BeverageSweetness, BeverageTemperature, DbHandler } from 'omc_db'
import { DrinkRecord } from '../../../model/Record'
import { BeverageDetailSheetContext } from '../strategy/BeverageDetailSheetContext'
import { NewBeverageStrategy } from '../strategy/implement/NewBeverageStrategy'
import { UpdateBeverageStrategy } from '../strategy/implement/UpdateBeverageStrategy'

@ObservedV2
export class BeverageDetailViewModel {
  @Trace private drinkRecord?: DrinkRecord
  private uiCtx?: UIContext

  // 初始化上下文环境
  public initUIContext(uiCtx: UIContext): void {
    this.uiCtx = uiCtx
  }

  // 初始化奶茶记录
  public initRecord(drinkRecord: DrinkRecord): void {
    this.drinkRecord = new DrinkRecord({
      id: drinkRecord.id ?? undefined,
      time: drinkRecord.time ?? Date.now(), // 新建记录的时间为当前时间
      remark: drinkRecord.remark ?? '',
      price: drinkRecord.price ?? undefined,
      size: drinkRecord.size ?? '',
      sweetness: drinkRecord.sweetness ?? '',
      temperature: drinkRecord.temperature ?? '',
      condiments: drinkRecord.condiments ?? [],
      beverageId: drinkRecord.beverageId,
      brandId: drinkRecord.brandId,
      beverageName: drinkRecord.beverageName,
      brandName: drinkRecord.brandName,
      degree: drinkRecord.degree
    })
  }

  // 获取奶茶记录
  public getDrinkRecord(): DrinkRecord {
    return this.drinkRecord ?? new DrinkRecord({
      time: Date.now(),
      price: 10,
      beverageId: 0,
      brandId: 0,
      beverageName: '',
      brandName: '',
      degree: 0
    })
  }

  // 更新记录时间
  public onTimeChange(newTime: number): void {
    if (this.drinkRecord && newTime > 0) {
      this.drinkRecord.time = newTime
    }
  }

  // 更新奶茶杯型
  public onBeverageCupSizeChange(newSize: BeverageSize): void {
    if (this.drinkRecord) {
      this.drinkRecord.size = newSize
    }
  }

  // 更新评分
  public onBeverageDegreeChange(newDegree: number): void {
    if (this.drinkRecord && newDegree >= 0) {
      this.drinkRecord.degree = newDegree
    }
  }

  // 更新价格
  public onBeveragePriceChange(newPrice: number): void {
    if (this.drinkRecord && newPrice >= 0) {
      this.drinkRecord.price = newPrice
    }
  }

  // 更新温度
  public onBeverageTemperatureChange(newTemperature: BeverageTemperature): void {
    if (this.drinkRecord) {
      this.drinkRecord.temperature = newTemperature
    }
  }

  // 更新甜度
  public onBeverageSweetnessChange(newSweetness: BeverageSweetness): void {
    if (this.drinkRecord) {
      this.drinkRecord.sweetness = newSweetness
    }
  }

  // 更新小料
  public onBeverageCondimentsChange(newCondiments: number[]): void {
    if (this.drinkRecord) {
      this.drinkRecord.condiments = newCondiments
    }
  }

  // 备注
  public onBeverageRemarkChange(newRemark: string): void {
    if (this.drinkRecord) {
      this.drinkRecord.remark = newRemark
    }
  }

  // 关闭详情面板
  public async closeBeverageDetailSheet(uiCtx: UIContext): Promise<void> {
    if (!this.drinkRecord) {
      return
    }
    const isUpdate: boolean = await DbHandler.recordApi.hasRecord(this.drinkRecord.id ?? -1)
    this.uiCtx &&
    new BeverageDetailSheetContext(isUpdate ? new UpdateBeverageStrategy() : new NewBeverageStrategy())
      .close(this.uiCtx)
  }

  // 更新数据库记录
  public async updateDrinkRecord(): Promise<void> {
    if (!this.drinkRecord) {
      return
    }
    const isUpdate: boolean = await DbHandler.recordApi.hasRecord(this.drinkRecord.id ?? -1)
    this.uiCtx &&
    new BeverageDetailSheetContext(isUpdate ? new UpdateBeverageStrategy() : new NewBeverageStrategy())
      .executeAndClose(this.uiCtx, this.drinkRecord)
  }
}