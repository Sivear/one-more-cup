import { LazyListModel } from '../model/LazyListModel';
import { BrandBeverageService } from '../model/BrandBeverageService';
import { IBeverage, IBrand } from 'omc_db';
import { PresetDialogKey } from './PresetDialogViewModel';
import { OpenBeverageDetailSheet } from '../components/beverage_detail/OpenBeverageDetailSheet';
import { DrinkRecord } from '../model/Record';

// 当前预设管理模式
export enum PresetMode {
  NONE = 0,
  ADD, // 添加
  EDIT, // 编辑
  DELETE // 删除
}

// 预设饮品按钮类型，用于处理对应的点击事件
export enum BeverageItemType {
  ITEM = 0, // 预设饮品本身，点击后跳转至添加饮品页
  EDIT, // 预设饮品编辑按钮
  DELETE // 预设饮品删除按钮
}

// 列表项类型，用于处理点击事件
export enum ListItemType {
  BRAND = 'brand',
  BEVERAGE_EDIT = 'beverage_edit',
  BEVERAGE_DELETE = 'beverage_delete'
}

@ObservedV2
export class BeverageChooseViewModel {
  brandData = new LazyListModel<IBrand>();
  beverageData = new LazyListModel<IBeverage>();
  @Trace curBrand: number = 1;
  @Trace private presetMode: PresetMode = PresetMode.NONE
  private uiContext: UIContext | undefined = undefined
  private uniqueId: number | undefined = undefined
  // 注入数据服务
  private dataService = new BrandBeverageService();
  private openDialogEvent: (key: PresetDialogKey, presetInfo?: IBeverage) => void = () => {
  }

  initData(uiContext: UIContext, uniqueId: number, openPresetDialog: (key: PresetDialogKey) => void) {
    this.uiContext = uiContext
    this.uniqueId = uniqueId
    this.loadBrandData();
    this.loadBeverages(this.curBrand);
    // 注入打开饮品预设相关弹窗事件
    this.handleOpenDialogEvent(openPresetDialog)
  }

  handleOpenDialogEvent(action: (key: PresetDialogKey, presetInfo?: IBeverage) => void) {
    this.openDialogEvent = action
  }

  // 加载品牌数据
  private async loadBrandData() {
    const brands = await this.dataService.getBrandsWithRecent();
    this.brandData.assignData(brands);
  }

  // 加载饮品数据
  private async loadBeverages(brandId: number) {
    const beverages = await this.dataService.getBeveragesByBrand(brandId);
    this.beverageData.assignData(beverages);
  }

  // 刷新该品牌饮品数据
  private refreshBeverages() {
    this.loadBeverages(this.curBrand)
    this.beverageData.notifyDataReload()
  }

  @Monitor('curBrand')
  async changeBeverageList() {
    this.loadBeverages(this.curBrand);
  }

  changeBrand(index: number) {
    this.curBrand = index;
    // 切换品牌时，饮品预设管理状态重置
    this.presetMode = PresetMode.NONE
  }

  isChosenBrand(index: number) {
    return this.curBrand === index;
  }

  /**
   * 根据id返回品牌名称
   * @param index
   */
  getBrandName() {
    const brand = this.brandData.getAllData().find((item: IBrand) => item.id === this.curBrand)
    return brand?.name
  }

  /**
   * 切换饮品预设管理模式(无/编辑/删除)
   */
  changePresetMode(mode: PresetMode) {
    if (this.presetMode === mode) {
      this.presetMode = PresetMode.NONE
    } else {
      this.presetMode = mode
    }
  }

  /**
   * 获取当前模式
   * @returns
   */
  getPresetMode() {
    return this.presetMode
  }

  /**
   * 设置预设饮品编辑/删除按钮的文本颜色
   * @param mode: 是编辑按钮还是删除按钮
   * @returns
   */
  getModeTextColor(mode: PresetMode) {
    if (mode === this.presetMode) {
      return $r('app.color.omc_tab_active')
    } else {
      return $r('app.color.text_02')
    }
  }

  /**
   * 设置预设饮品编辑/删除按钮的激活背景色
   * @param mode: 是编辑按钮还是删除按钮
   * @returns
   */
  getModeBtnColor(mode: PresetMode) {
    if (mode === this.presetMode) {
      return $r('app.color.bg_03')
    } else {
      return Color.Transparent
    }
  }

  /**
   * 添加用户自定义饮品
   * @param name: 饮品名
   */
  addCustomBeverage(name: string) {
    if (!name) {
      this.uiContext?.getPromptAction().showToast({ message: $r('app.string.input_beverage_name') })
      return
    }
    this.dataService.addCustomBeverage(this.curBrand, name)
    this.refreshBeverages()
    this.uiContext?.getPromptAction().showToast({ message: $r('app.string.add_success') })
  }

  /**
   * 编辑用户自定义饮品
   * @param newName: 饮品名
   */
  updateCustomBeverage(newName: string, beverageInfo: IBeverage) {
    const newBeverage: IBeverage = {
      id: beverageInfo.id,
      name: newName,
      isPreset: beverageInfo.isPreset,
      brandId: beverageInfo.brandId
    }
    this.dataService.updateCustomBeverage(newBeverage)
    this.refreshBeverages()
    this.uiContext?.getPromptAction().showToast({ message: $r('app.string.edit_success') })
  }

  /**
   *  删除自定义饮品
   * @param beverageId
   */
  deleteCustomBeverage(beverageId: number) {
    this.dataService.deleteCustomBeverage(beverageId)
    this.refreshBeverages()
    this.uiContext?.getPromptAction().showToast({ message: $r('app.string.delete_success') })
  }

  /**
   * 响应自定义饮品的编辑/删除事件
   * @param type
   */
  beveragePresetEventHandler(type: BeverageItemType, presetInfo?: IBeverage) {
    switch (type) {
      case BeverageItemType.ITEM:
        if (this.uiContext && this.uniqueId !== undefined && presetInfo) {
          this.presetMode = PresetMode.NONE
          this.chooseBeverage(this.uiContext, this.uniqueId, presetInfo)
        }
        break
      case BeverageItemType.EDIT:
        this.openDialogEvent(PresetDialogKey.EDIT_PRESET, presetInfo)
        break
      case BeverageItemType.DELETE:
        this.openDialogEvent(PresetDialogKey.DELETE_PRESET, presetInfo)
        break
      default:
        break
    }
  }

  // 获取选中品牌数据
  public getChosenBrandData(): IBrand {
    return this.brandData.getData(this.curBrand)
  }

  public chooseBeverage(uiCtx: UIContext, uniqueId: number, beverage: IBeverage): void {
    OpenBeverageDetailSheet(uiCtx, uniqueId)({
      record: new DrinkRecord({
        time: Date.now(),
        remark: '',
        price: -1, // 新建金额使用负数标识
        size: '',
        sweetness: '',
        temperature: '',
        condiments: [],
        beverageId: beverage.id ?? -1,
        brandId: this.getChosenBrandData().id ?? 0,
        beverageName: beverage.name,
        brandName: this.getChosenBrandData().name,
        degree: 0
      })
    })
  }
}