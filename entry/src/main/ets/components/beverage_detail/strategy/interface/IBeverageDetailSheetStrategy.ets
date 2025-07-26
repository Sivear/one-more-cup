import { DrinkRecord } from '../../../../model/Record'

export interface IBeverageDetailSheetStrategy {
  open(): void

  close(uiCtx: UIContext): void

  executeAndClose(uiCtx: UIContext, drinkRecord: DrinkRecord): Promise<void>
}