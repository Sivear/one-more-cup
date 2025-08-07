import { LevelMode } from '@kit.ArkUI'
import { util } from '@kit.ArkTS'

export class BaseDialogParams {
  public id: string
  public dialogAlignment: DialogAlignment = DialogAlignment.Default
  public dialogOffset: Offset = { dx: 0, dy: 0 }
  public isModalDialog: boolean = true
  public isShowInSubWindow: boolean = false
  public isAutoCancel: boolean = true
  public dialogMaskColor: ResourceColor = '0x33000000'
  public dialogTransition?: TransitionEffect
  public dialogKeyboardAvoidMode: KeyboardAvoidMode = KeyboardAvoidMode.DEFAULT
  public dialogLevelMode: LevelMode = LevelMode.OVERLAY
  public isFocusable: boolean = true
  public onDialogWillDismiss: (action: DismissDialogAction) => void = () => {
  }
  public onDialogDidAppear: () => void = () => {
  }
  public onDialogDidDisappear: () => void = () => {
  }
  public onDialogWillAppear: () => void = () => {
  }
  public onDialogWillDisappear: () => void = () => {
  }

  constructor() {
    this.id = util.generateRandomUUID()
  }

  public alignment(alignment: DialogAlignment): BaseDialogParams {
    this.dialogAlignment = alignment
    return this
  }

  public offset(offset: Offset): BaseDialogParams {
    this.dialogOffset = offset
    return this
  }

  public isModal(isModal: boolean): BaseDialogParams {
    this.isModalDialog = isModal
    return this
  }

  public showInSubWindow(showInSubWindow: boolean): BaseDialogParams {
    this.isShowInSubWindow = showInSubWindow
    return this
  }

  public autoCancel(autoCancel: boolean): BaseDialogParams {
    this.isAutoCancel = autoCancel
    return this
  }

  public maskColor(maskColor: ResourceColor): BaseDialogParams {
    this.dialogMaskColor = maskColor
    return this
  }

  public transition(transition: TransitionEffect): BaseDialogParams {
    this.dialogTransition = transition
    return this
  }

  public keyboardAvoidMode(keyboardAvoidMode: KeyboardAvoidMode): BaseDialogParams {
    this.dialogKeyboardAvoidMode = keyboardAvoidMode
    return this
  }

  public levelMode(levelMode: LevelMode): BaseDialogParams {
    this.dialogLevelMode = levelMode
    return this
  }

  public focusable(focusable: boolean): BaseDialogParams {
    this.isFocusable = focusable
    return this
  }

  public onWillDismiss(onWillDismiss: (action: DismissDialogAction) => void): BaseDialogParams {
    this.onDialogWillDismiss = onWillDismiss
    return this
  }

  public onDidAppear(onDidAppear: () => void): BaseDialogParams {
    this.onDialogDidAppear = onDidAppear
    return this
  }

  public onDidDisappear(onDidDisappear: () => void): BaseDialogParams {
    this.onDialogDidDisappear = onDidDisappear
    return this
  }

  public onWillAppear(onWillAppear: () => void): BaseDialogParams {
    this.onDialogWillAppear = onWillAppear
    return this
  }

  public onWillDisappear(onWillDisappear: () => void): BaseDialogParams {
    this.onDialogWillDisappear = onWillDisappear
    return this
  }
}