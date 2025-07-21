import { LazyListModel } from '../model/LazyListModel';
import { BrandBeverageService } from '../model/BrandBeverageService';
import { IBeverage, IBrand } from 'omc_db';
import { OpenBeverageDetailSheet } from '../components/beverage_detail/OpenBeverageDetailSheet';
import { DrinkRecord } from '../model/Record';

@ObservedV2
export class BeverageChooseViewModel {
  brandData = new LazyListModel<IBrand>();
  beverageData = new LazyListModel<IBeverage>();
  @Trace curBrand: number = 1;
  // 注入数据服务
  private dataService = new BrandBeverageService();

  initData() {
    this.loadBrandData();
    this.loadBeverages(this.curBrand);
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

  @Monitor('curBrand')
  async changeBeverageList() {
    this.loadBeverages(this.curBrand);
  }

  changeBrand(index: number) {
    this.curBrand = index;
  }

  isChosenBrand(index: number) {
    return this.curBrand === index;
  }

  // 获取选中品牌数据
  public getChosenBrandData(): IBrand {
    return this.brandData.getData(this.curBrand)
  }

  public chooseBeverage(uiCtx: UIContext, uniqueId: number, beverage: IBeverage): void {
    OpenBeverageDetailSheet(uiCtx, uniqueId)({
      record: new DrinkRecord({
        id: Math.random(),
        time: Date.now(),
        remark: '',
        price: -1, // 新建金额使用负数标识
        size: '',
        sweetness: '',
        temperature: '',
        condiments: [],
        beverageId: beverage.id ?? 0,
        brandId: this.getChosenBrandData().id ?? 0,
        beverageName: beverage.name,
        brandName: this.getChosenBrandData().name,
        degree: beverage.degree ?? 0
      })
    })
  }
}