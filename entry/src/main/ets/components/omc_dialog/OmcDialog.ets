import { BaseDialogParams } from './BaseDialogParams'
import { HashMap } from '@kit.ArkTS'
import { ComponentContent } from '@kit.ArkUI'

export class OmcDialog {
  private static dialogMap: HashMap<string, ComponentContent<BaseDialogParams>> = new HashMap()

  private constructor() {
  }

  public static showDialog<T extends BaseDialogParams>(
    uiContext: UIContext,
    dialog: WrappedBuilder<[T]>,
    params: T
  ): boolean {
    if (OmcDialog.dialogMap.hasKey(params.id)) {
      return false
    }
    const componentContent: ComponentContent<T> = new ComponentContent(uiContext, dialog, params)
    uiContext.getPromptAction().openCustomDialog(componentContent, {
      alignment: params.dialogAlignment,
      offset: params.dialogOffset,
      isModal: params.isModalDialog,
      showInSubWindow: params.isShowInSubWindow,
      autoCancel: params.isAutoCancel,
      maskColor: params.dialogMaskColor,
      transition: params.dialogTransition,
      keyboardAvoidMode: params.dialogKeyboardAvoidMode,
      levelMode: params.dialogLevelMode,
      onWillDismiss: params.onDialogWillDismiss,
      onDidAppear: params.onDialogDidAppear,
      onDidDisappear: params.onDialogDidDisappear,
      onWillAppear: params.onDialogWillAppear,
      onWillDisappear: params.onDialogWillDisappear
    })
    OmcDialog.dialogMap.set(params.id, componentContent)
    return true
  }

  public static closeDialog(uiContext: UIContext, dialogId: string): boolean {
    if (!OmcDialog.dialogMap.hasKey(dialogId)) {
      return false
    }
    const componentContent = OmcDialog.dialogMap.get(dialogId)
    uiContext.getPromptAction().closeCustomDialog(componentContent)
    OmcDialog.dialogMap.remove(dialogId)
    return true
  }
}