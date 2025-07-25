import { DrinkRecord } from '../../../model/Record';
import { IBeverageDetailSheetStrategy } from './interface/IBeverageDetailSheetStrategy';

export class BeverageDetailSheetContext implements IBeverageDetailSheetStrategy {
  private strategy: IBeverageDetailSheetStrategy

  constructor(strategy: IBeverageDetailSheetStrategy) {
    this.strategy = strategy
  }

  public switchStrategy(strategy: IBeverageDetailSheetStrategy): void {
    this.strategy = strategy
  }

  public open(): void {
    this.strategy.open()
  }

  public close(uiCtx: UIContext): void {
    this.strategy.close(uiCtx)
  }

  public executeAndClose(uiCtx: UIContext, drinkRecord: DrinkRecord): Promise<void> {
    return this.strategy.executeAndClose(uiCtx, drinkRecord)
  }
}