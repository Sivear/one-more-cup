export class TimeFormatUtil {
  // todo:补充获取各种格式的时间逻辑
  public static transferTimeToString(time: number): string {
    const date = new Date(time)
    const h: number = date.getHours()
    const m: number = date.getMinutes()
    return `${h < 10 ? '0' + h : h.toString()}: ${m < 10 ? '0' + m : m.toString()}`
  }
}

export enum TimeFormat {
  Y_M_D = 1, // 年月日
  Y_M_D_H_M, // 年月日时分
  Y_M_D_H_M_S, // 年月日时分秒
  Y_M, // 年月
  M_D, // 月日
  M_D_H_M, // 月日时分
  M_D_H_M_S, // 月日时分秒
  H_M_S, // 时分秒
  H_M // 时分
}