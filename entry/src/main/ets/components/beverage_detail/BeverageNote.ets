import { BeverageParamName } from './common_ui/BeverageParamName'
import { CommonInput } from './common_ui/CommonInput'

@ComponentV2
export struct BeverageNote {
  @Param remark: string = ''
  @Event onRemarkChange: (newRemark: string) => void = () => {
  }

  build() {
    Row() {
      BeverageParamName($r('app.string.remark'))

      CommonInput({
        placeHolderContent: $r('app.string.beverage_note_placeHolder'),
        inputValue: this.remark,
        image: $r('app.media.enlarge'),
        onInputValueChange: (newValue: string) => {
          this.onRemarkChange(newValue)
        },
        onIconClick: () => {
          // todo: 添加dialog
          this.getUIContext().getPromptAction().showToast({
            message: 'todo：展示弹窗'
          })
        }
      })
    }
    .width('100%')
    .height(47)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}