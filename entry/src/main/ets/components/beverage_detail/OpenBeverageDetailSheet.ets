import { ComponentContent } from '@kit.ArkUI'
import { IRecord } from '../../model/Record'
import { BeverageDetail } from './BeverageDetailSheet'

export function OpenBeverageDetailSheet(uiCtx: UIContext, uniqueId: number) {
  const node: FrameNode | null = uiCtx.getFrameNodeByUniqueId(uniqueId)
  const targetId = node?.getFirstChild()?.getUniqueId()

  return (args: IRecord) => {
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
  }
}