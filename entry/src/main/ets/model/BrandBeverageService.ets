import { DbHandler, IBeverage, IBrand, IRecord } from 'omc_db';

export class BrandBeverageService {
  /**
   * 获取品牌数据（包含"最近"选项）
   */
  async getBrandsWithRecent(): Promise<IBrand[]> {
    try {
      const brands = await DbHandler.brandApi.getAllBrands();
      const recentItem: IBrand = {
        id: 0,
        name: '最近',
        isPreset: true
      };
      return [recentItem, ...brands];
    } catch (e) {
      console.error('Error in getting brand data: ', e);
      return [];
    }
  }

  /**
   * 根据品牌ID获取饮品
   */
  async getBeveragesByBrand(brandId: number): Promise<IBeverage[]> {
    try {
      return brandId === 0
        ? this.getRecentBeverages()
        : DbHandler.beverageApi.getBeverageByBrandId(brandId);
    } catch (e) {
      console.error(`Error in getting ${brandId} beverage:  `, e);
      return [];
    }
  }

  /**
   * 获取最近30条记录的饮品数据
   */
  private async getRecentBeverages(): Promise<IBeverage[]> {
    try {
      const records = await DbHandler.recordApi.getLatest30Records();
      return this.mapRecordsToBeverages(records);
    } catch (e) {
      console.error('Error in getting recent data: ', e);
      return [];
    }
  }

  /**
   * 将记录映射为饮品数据
   */
  private async mapRecordsToBeverages(records: IRecord[]): Promise<IBeverage[]> {
    const beveragePromises = records.map(record =>
    this.getBeverageById(record.beverageId)
    );
    return Promise.all(beveragePromises);
  }

  /**
   * 根据ID获取单个饮品
   */
  private async getBeverageById(beverageId: number): Promise<IBeverage> {
    try {
      const beverage = await DbHandler.beverageApi.getBeverageById(beverageId);
      // 只会查询到一个饮品
      return beverage[0];
    } catch (e) {
      console.error(`Error in getting beverage by id: ${beverageId}`, e);
      return { id: beverageId, name: 'unknow', brandId: -1 };
    }
  }
}