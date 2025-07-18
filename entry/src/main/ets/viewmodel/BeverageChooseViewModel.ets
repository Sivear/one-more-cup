import { LazyListModel } from '../model/LazyListModel';
import { BrandBeverageService } from '../model/BrandBeverageService';
import { IBeverage, IBrand } from 'omc_db';

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
}