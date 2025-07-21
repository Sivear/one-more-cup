import { BeverageSize } from 'omc_db'

export class BeverageSizeUtil {
  private static readonly sizeNameMap: Map<BeverageSize, ResourceStr> = new Map([
    [BeverageSize.SMALL, $r('app.string.beverage_size_small')],
    [BeverageSize.MEDIUM, $r('app.string.beverage_size_medium')],
    [BeverageSize.LARGE, $r('app.string.beverage_size_large')],
    [BeverageSize.EXTRA_LARGE, $r('app.string.beverage_size_extra_large')]
  ])
  private static readonly sizeMap: Map<BeverageSize, Size> = new Map<BeverageSize, Size>([
    [BeverageSize.SMALL, { width: 25, height: 41 }],
    [BeverageSize.MEDIUM, { width: 30, height: 49 }],
    [BeverageSize.LARGE, { width: 35, height: 57 }],
    [BeverageSize.EXTRA_LARGE, { width: 40, height: 65 }]
  ])

  public static transferSizeToString(size: BeverageSize): ResourceStr {
    return BeverageSizeUtil.sizeNameMap.get(size) || ''
  }

  public static transferSizeToNumber(size: BeverageSize): Size {
    return BeverageSizeUtil.sizeMap.get(size) || { width: 25, height: 41 }
  }
}