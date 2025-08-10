import { HMRouterMgr } from '@hadss/hmrouter'
import { DbHandler } from 'omc_db'
import { DrinkRecord } from '../../../../model/Record'
import { EventBusHandler } from '../../../../utils/EventBus/EventBus'
import { Events } from '../../../../utils/EventBus/Events'
import { OmcDialog } from '../../../omc_dialog/OmcDialog'
import { ConfirmDialogIdStore } from '../../BeverageDetailSheet'
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
      degree: drinkRecord.degree,
      price: drinkRecord.price,
      size: drinkRecord.size,
      sweetness: drinkRecord.sweetness,
      temperature: drinkRecord.temperature,
      condiments: drinkRecord.condiments,
      beverageId: drinkRecord.beverageId
    })
    // 关确认弹窗
    OmcDialog.closeDialog(uiCtx, ConfirmDialogIdStore.confirmDialogId)
    // 通知首页数据刷新
    EventBusHandler.emit(Events.RECORD_LIST_CHANGE)
    // 关sheet菜单
    this.close(uiCtx)
    // 路由跳转
    HMRouterMgr.pop()
    // 添加成功提示
    uiCtx.getPromptAction().showToast({
      message: $r('app.string.add_success')
    })
  }
}