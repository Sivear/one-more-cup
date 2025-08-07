import { BaseDialogParams } from '../omc_dialog/BaseDialogParams'
import { OmcDialog } from '../omc_dialog/OmcDialog'
import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeverageNote {
  @Param remark: string = ''
  @Event onRemarkChange: (newRemark: string) => void = () => {
  }
  private noteDialogParams: NoteDialogParams = new NoteDialogParams()
  private static readonly MAX_NOTE_LENGTH: number = 200

  aboutToAppear(): void {
    this.noteDialogParams
      .setRemark(this.remark)
      .setNoteChange(this.onRemarkChange)
      .autoCancel(true)
      .onWillDismiss(() => {
        OmcDialog.closeDialog(this.getUIContext(), this.noteDialogParams.id)
      })
  }

  build() {
    Row() {
      BeverageParamName($r('app.string.remark'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_note_placeHolder', $r('app.string.note_length_limit')),
        inputValue: this.remark,
        image: $r('app.media.enlarge'),
        maxLength: BeverageNote.MAX_NOTE_LENGTH,
        onInputValueChange: (newValue: string) => {
          this.onRemarkChange(newValue)
        },
        onIconClick: () => {
          this.noteDialogParams.setRemark(this.remark)
          OmcDialog.showDialog(
            this.getUIContext(),
            wrapBuilder(NoteDialogBuilder),
            this.noteDialogParams
          )
        }
      })
    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

class NoteDialogParams extends BaseDialogParams {
  public remark: string = ''
  public onNoteChange: (newRemark: string) => void = () => {
  }

  public setNoteChange(onNoteChange: (newRemark: string) => void): NoteDialogParams {
    this.onNoteChange = onNoteChange
    return this
  }

  public setRemark(remark: string): NoteDialogParams {
    this.remark = remark
    return this
  }
}

@Builder
function NoteDialogBuilder(params: NoteDialogParams) {
  NoteDialogComp({
    remark: params.remark,
    onRemarkChange: params.onNoteChange,
    dialogId: params.id
  })
}

@ComponentV2
struct NoteDialogComp {
  @Param @Require remark: string = ''
  @Param @Require dialogId: string = ''
  @Event onRemarkChange: (newRemark: string) => void = () => {
  }
  private remarkContent: string = this.remark
  private static readonly MAX_NOTE_LENGTH: number = 200

  build() {
    Column({ space: 24 }) {
      Text($r('app.string.remark'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontWeight(400)
        .fontColor($r('app.color.text_03'))


      TextArea({
        placeholder: $r('app.string.beverage_note_placeHolder', $r('app.string.note_length_limit')),
        text: this.remark
      })
        .width('100%')
        .maxLength(NoteDialogComp.MAX_NOTE_LENGTH)
        .showCounter(true)
        .borderRadius(6)
        .onChange((val: string) => {
          if (!val || !val.trim()) {
            this.remarkContent = ''
            return
          }
          this.remarkContent = val.trim()
        })

      Row() {
        Button($r("app.string.cancel"))
          .width("25%")
          .constraintSize({
            minWidth: 100,
            maxWidth: 120
          })
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.bg_03"))
          .fontColor(Color.Black)
          .onClick(() => {
            OmcDialog.closeDialog(this.getUIContext(), this.dialogId)
          })
        Button($r("app.string.confirm"))
          .width("25%")
          .constraintSize({
            minWidth: 100,
            maxWidth: 120
          })
          .height(54)
          .borderRadius(12)
          .backgroundColor($r("app.color.primary"))
          .onClick(() => {
            this.onRemarkChange(this.remarkContent)
            OmcDialog.closeDialog(this.getUIContext(), this.dialogId)
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("80%")
    .alignItems(HorizontalAlign.Center)
    .backgroundColor($r('app.color.start_window_background'))
    .borderRadius(16)
    .padding(24)
  }
}