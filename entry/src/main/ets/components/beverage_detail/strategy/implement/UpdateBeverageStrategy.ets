import { DbHandler } from 'omc_db'
import { DrinkRecord } from '../../../../model/Record'
import { CloseBeverageDetailSheet } from '../../OpenBeverageDetailSheet'
import { IBeverageDetailSheetStrategy } from '../interface/IBeverageDetailSheetStrategy'

export class UpdateBeverageStrategy implements IBeverageDetailSheetStrategy {
  public open(): void {
  }

  public close(uiCtx: UIContext): void {
    CloseBeverageDetailSheet(uiCtx)
  }

  public async executeAndClose(uiCtx: UIContext, drinkRecord: DrinkRecord): Promise<void> {
    await DbHandler.recordApi.updateRecord({
      id: drinkRecord.id,
      time: drinkRecord.time,
      remark: drinkRecord.remark,
      degree: drinkRecord.degree,
      price: drinkRecord.price,
      size: drinkRecord.size,
      sweetness: drinkRecord.sweetness,
      temperature: drinkRecord.temperature,
      condiments: drinkRecord.condiments
    })
    this.close(uiCtx)
  }
}
