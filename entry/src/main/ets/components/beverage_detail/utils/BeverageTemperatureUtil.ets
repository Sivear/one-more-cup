import { BeverageTemperature } from 'omc_db'

export class BeverageTemperatureUtil {
  private static readonly temperatureMap: Map<BeverageTemperature, ResourceStr> = new Map([
    [BeverageTemperature.HOT, $r('app.string.beverage_temperature_hot')],
    [BeverageTemperature.WARM, $r('app.string.beverage_temperature_warm')],
    [BeverageTemperature.NORMAL, $r('app.string.beverage_temperature_normal')],
    [BeverageTemperature.NO_ICE, $r('app.string.beverage_temperature_no_ice')],
    [BeverageTemperature.LESS_COLD, $r('app.string.beverage_temperature_less_cold')],
    [BeverageTemperature.COLD, $r('app.string.beverage_temperature_cold')]
  ])

  public static transferTemperatureToString(temperature: BeverageTemperature): ResourceStr {
    return BeverageTemperatureUtil.temperatureMap.get(temperature) || ''
  }
}