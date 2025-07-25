import { DbHandler } from 'omc_db'
import { DrinkRecord } from '../../../../model/Record'
import { CloseBeverageDetailSheet } from '../../OpenBeverageDetailSheet'
import { IBeverageDetailSheetStrategy } from '../interface/IBeverageDetailSheetStrategy'

export class NewBeverageStrategy implements IBeverageDetailSheetStrategy {
  public open(): void {
  }

  public close(uiCtx: UIContext): void {
    CloseBeverageDetailSheet(uiCtx)
  }

  public async executeAndClose(uiCtx: UIContext, drinkRecord: DrinkRecord): Promise<void> {
    await DbHandler.recordApi.addRecord({
      time: drinkRecord.time,
      remark: drinkRecord.remark,
      price: drinkRecord.price,
      size: drinkRecord.size,
      sweetness: drinkRecord.sweetness,
      temperature: drinkRecord.temperature,
      condiments: drinkRecord.condiments,
      beverageId: drinkRecord.beverageId
    })
    await DbHandler.beverageApi.updateBeverage({
      id: drinkRecord.beverageId,
      degree: drinkRecord.degree
    })
    this.close(uiCtx)
  }
}