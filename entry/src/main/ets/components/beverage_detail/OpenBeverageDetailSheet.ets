import { ComponentContent } from '@kit.ArkUI'
import { BeverageDetail, IBeverageDetailParams } from './BeverageDetailSheet'

export function OpenBeverageDetailSheet(uiCtx: UIContext, uniqueId: number) {
  const node: FrameNode | null = uiCtx.getFrameNodeByUniqueId(uniqueId)
  const targetId = node?.getFirstChild()?.getUniqueId()

  return (args: IBeverageDetailParams) => {
    const compContent = new ComponentContent(uiCtx, BeverageDetail, args)
    node && uiCtx.openBindSheet(compContent, {
      maskColor: $r('app.color.mask'),
      enableOutsideInteractive: false,
      showClose: false,
      height: '90%',
      width: '100%',
      shadow: {
        radius: 26,
        color: $r('app.color.omc_beverage_detail_sheet_shadow'),
        type: ShadowType.COLOR
      },
      uiContext: uiCtx
    }, targetId)
      .then(() => {
        OmcSheetHolder.setSheet(compContent)
      })
  }
}

export function CloseBeverageDetailSheet(uiCtx: UIContext) {
  const sheet: ComponentContent<ESObject> = OmcSheetHolder.getSheet()
  sheet && uiCtx.closeBindSheet(sheet)
}

// todo: 暂时使用，后续维护一套统一的sheet创建管理类
class OmcSheetHolder {
  private static sheetCompContent: ComponentContent<ESObject>

  public static getSheet(): ComponentContent<ESObject> {
    return OmcSheetHolder.sheetCompContent
  }

  public static setSheet(sheet: ComponentContent<ESObject>): void {
    OmcSheetHolder.sheetCompContent = sheet
  }
}