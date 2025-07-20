import { BeverageSweetness } from 'omc_db'

export class BeverageSweetnessUtil {
  private static readonly sweetnessMap: Map<BeverageSweetness, ResourceStr> = new Map([
    [BeverageSweetness.NO_SUGAR, $r('app.string.beverage_sweetness_no_sugar')],
    [BeverageSweetness.LIGHT_SUGAR, $r('app.string.beverage_sweetness_light_sugar')],
    [BeverageSweetness.HALF_SUGAR, $r('app.string.beverage_sweetness_half_sugar')],
    [BeverageSweetness.LESS_SUGAR, $r('app.string.beverage_sweetness_less_sugar')],
    [BeverageSweetness.FULL_SUGAR, $r('app.string.beverage_sweetness_full_sugar')],
  ])

  public static transferSweetnessToString(sweetness: BeverageSweetness): ResourceStr {
    return BeverageSweetnessUtil.sweetnessMap.get(sweetness) || ''
  }
}