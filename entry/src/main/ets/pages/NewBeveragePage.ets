import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { IBeverage, IBrand } from 'omc_db';
import { PresetBeverageDialogMap } from '../components/dialogs/PresetBeverageDialogMap';
import { BeverageListItem, BrandListItem, RecentBeverageItem } from '../components/new_beverage/ListItem';
import { NavParams } from '../router/NavParams';
import { debounce } from '../utils/debounce';
import { BeverageChooseViewModel, BeverageItemType, PresetMode } from '../viewmodel/BeverageChooseViewModel';
import { PresetDialogKey, PresetDialogVM } from '../viewmodel/PresetDialogViewModel';

@HMRouter({
  pageUrl: NavParams.NEW_BEVERAGE_PAGE_URL,
  singleton: true
})
@ComponentV2
export struct NewBeveragePage {
  @Local searchValue: string = ''
  beverageChooseVM: BeverageChooseViewModel = new BeverageChooseViewModel()
  presetDialogVM: PresetDialogVM = new PresetDialogVM()
  presetDialogCtl: CustomDialogController = new CustomDialogController({
    builder: PresetBeverageDialogMap({
      presetDialogVM: this.presetDialogVM
    })
  })
  private debounceSearch = (brandName: string) => {
  }

  aboutToAppear(): void {
    this.beverageChooseVM.initData(this.getUIContext(), this.getUniqueId(),
      (key: PresetDialogKey, curPresetInfo?: IBeverage) => {
        this.presetDialogVM.openDialog(key, curPresetInfo)
      })
    this.presetDialogVM.init(this.presetDialogCtl, this.beverageChooseVM)
    this.debounceSearch = debounce((name: string) => {
      this.beverageChooseVM.searchBrand(name)
    })
  }

  @Builder
  PageHeader() {
    Column() {
      Row() {
        Image($r('app.media.left_arrow'))
          .width(36)
          .height(36)
          .position({ x: 0, y: -6 })
          .onClick(() => {
            HMRouterMgr.pop()
          })
        Text($r('app.string.beverage_choose'))
          .fontSize($r('app.float.font_size_20'))
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.Center)

      Search({ value: this.searchValue!!, placeholder: $r('app.string.input_brand') })
        .borderRadius(6)
        .searchIcon({
          src: $r('sys.media.ohos_ic_public_search_filled'),
          size: '20vp',
          color: $r('app.color.text_02')
        })
        .cancelButton({
          style: CancelButtonStyle.INPUT,
          icon: {
            src: $r('sys.media.ohos_ic_public_cancel_filled')
          },
        })
        .width('90%')
        .height(52)
        .maxLength(20)
        .backgroundColor('#F5F5F5')
        .placeholderColor($r('app.color.text_02'))
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .onChange((value: string) => {
          this.debounceSearch(value)
        })
        .margin(20)
    }
    .padding({ top: 24 })
  }

  // 饮品预设管理按钮-编辑/删除 (选择非“最近”列表时,默认在饮品列表置顶显示)
  @Builder
  addPresetBeverage() {
    Column() {
      // 添加饮品预设
      Row() {
        Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
          Row() {
            Image($r('app.media.omc_new_preset')).width(19).height(19).margin({ right: 9 })
            Text($r('app.string.add_beverage')).fontSize(14)
          }
        }
        .onClick(() => {
          this.presetDialogVM.openDialog(PresetDialogKey.ADD_PRESET)
        })
        .padding(4)
        .borderRadius(6)
        .fontColor(Color.Black)

        Row() {
          // 编辑饮品预设
          Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
            Image($r('app.media.edit'))
              .width(14)
              .height(14)
              .fillColor(this.beverageChooseVM.getModeTextColor(PresetMode.EDIT))
          }
          .backgroundColor(this.beverageChooseVM.getModeBtnColor(PresetMode.EDIT))
          .borderRadius(4)
          .padding(2)
          .margin({ right: 9 })
          .onClick(() => {
            this.beverageChooseVM.changePresetMode(PresetMode.EDIT)
          })

          // 删除饮品预设
          Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
            Image($r('app.media.delete'))
              .height(14)
              .fillColor(this.beverageChooseVM.getModeTextColor(PresetMode.DELETE))
          }
          .backgroundColor(this.beverageChooseVM.getModeBtnColor(PresetMode.DELETE))
          .borderRadius(4)
          .padding(2)
          .onClick(() => {
            this.beverageChooseVM.changePresetMode(PresetMode.DELETE)
          })
        }
        .visibility(this.beverageChooseVM.isHasCustomBeverage ? Visibility.Visible : Visibility.Hidden)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 10 })

      Divider()
        .strokeWidth(1)
        .borderRadius(2)
        .color($r('app.color.divider'))
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  build() {
    Column() {
      this.PageHeader()
      Row() {
        // 左侧品牌的懒加载列表
        List({ space: 20, initialIndex: 0 }) {
          LazyForEach(this.beverageChooseVM.brandData, (item: IBrand, index: number) => {
            ListItem() {
              BrandListItem({
                brandInfo: item,
                isChosen: this.beverageChooseVM.curBrand === index,
                cb: () => {
                  this.beverageChooseVM.changeBrand(index)
                }
              })
            }
          }, (item: IBrand) => JSON.stringify(item))
        }
        .width('25%')
        .friction(0.6)
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)

        Divider()
          .strokeWidth(1)
          .vertical(true)
          .borderRadius(2)
          .color($r('app.color.divider'))

        Column() {
          // 不是最近列表,则显示预设管理按钮
          if (this.beverageChooseVM.curBrand) {
            this.addPresetBeverage()
          }
          // 右侧饮品的懒加载列表
          List({ space: 24, initialIndex: 0 }) {
            LazyForEach(this.beverageChooseVM.beverageData, (item: IBeverage) => {
              ListItem() {
                if (this.beverageChooseVM.curBrand) {
                  BeverageListItem({
                    beverageItem: item,
                    mode: this.beverageChooseVM.getPresetMode(),
                    cb: (type: BeverageItemType, presetInfo?: IBeverage) => {
                      this.beverageChooseVM.beveragePresetEventHandler(type, presetInfo)
                    }
                  })
                } else {
                  // 最近列表
                  RecentBeverageItem({
                    beverageItem: item,
                    mode: this.beverageChooseVM.getPresetMode(),
                    cb: (type: BeverageItemType, presetInfo?: IBeverage) => {
                      this.beverageChooseVM.beveragePresetEventHandler(type, presetInfo)
                    }
                  })
                }
              }
            }, (item: IBrand) => JSON.stringify(item))
          }
          .layoutWeight(1)
          .friction(0.6)
          .alignListItem(ListItemAlign.Start)
          .scrollBar(BarState.Off)
        }
        .layoutWeight(1)
        .margin({ left: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 0,
        right: 24,
        top: 12,
        bottom: 12
      })
    }
    .height('100%')
    .width('100%')
  }
}