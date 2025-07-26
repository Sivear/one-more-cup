import { IBeverage } from 'omc_db';
import { BeverageChooseViewModel } from './BeverageChooseViewModel';

export enum PresetDialogKey {
  INIT = 'init',
  ADD_PRESET = 'addPreset',
  EDIT_PRESET = 'editPreset',
  DELETE_PRESET = 'deletePreset',
}

// 饮品选择页：预设饮品的增删改弹窗viewModel
@ObservedV2
export class PresetDialogVM {
  private dialogController: CustomDialogController | undefined = undefined
  private beverageChooseVM: BeverageChooseViewModel | undefined = undefined
  @Trace private curDialog: PresetDialogKey = PresetDialogKey.INIT
  // 当前弹窗所管理的预设饮品信息
  private curPresetInfo: IBeverage | undefined

  init(dialogController: CustomDialogController, beverageChooseVM: BeverageChooseViewModel) {
    this.dialogController = dialogController
    this.beverageChooseVM = beverageChooseVM
  }

  getCurDialog() {
    return this.curDialog
  }

  openDialog(key: PresetDialogKey, curPresetInfo?: IBeverage) {
    this.curDialog = key
    this.dialogController?.open()
    this.curPresetInfo = curPresetInfo
  }

  closeDialog() {
    this.dialogController?.close()
    this.curPresetInfo = undefined
  }

  executeConfirm(param: string = '') {
    switch (this.curDialog) {
      case PresetDialogKey.ADD_PRESET:
        this.addCustomOnConfirm(param)
        break
      case PresetDialogKey.EDIT_PRESET:
        this.editCustomOnConfirm(param)
        break
      case PresetDialogKey.DELETE_PRESET:
        this.deleteCustomOnConfirm()
        break
      default:
        this.closeDialog()
        break
    }
  }

  executeCancel(param: string = '') {
    switch (this.curDialog) {
      case PresetDialogKey.ADD_PRESET:
        this.closeDialog()
        break
      case PresetDialogKey.EDIT_PRESET:
        this.closeDialog()
        break
      case PresetDialogKey.DELETE_PRESET:
        this.closeDialog()
        break
      default:
        this.closeDialog()
        break
    }
  }

  private addCustomOnConfirm(param: string) {
    this.beverageChooseVM?.addCustomBeverage(param)
    this.closeDialog()
  }

  private editCustomOnConfirm(param: string) {
    if (!this.curPresetInfo) {
      return
    }
    this.beverageChooseVM?.updateCustomBeverage(param, this.curPresetInfo)
    this.closeDialog()
  }

  private deleteCustomOnConfirm() {
    if (!this.curPresetInfo || !this.curPresetInfo.id) {
      return
    }
    this.beverageChooseVM?.deleteCustomBeverage(this.curPresetInfo.id)
    this.closeDialog()
  }
}