export class TimeUtil {
  /**
   * 判断时间戳是不是在今天范围内
   * @param time
   * @returns
   */
  static isToday(time: number): boolean {
    const now = new Date()
    const start = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0, 0).getTime()
    const end = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59, 999).getTime()
    return time <= end && time >= start
  }

  /**
   * 计算时间戳是几天前
   * @param timestamp
   * @returns
   */
  static daysAgo(timestamp: number): number {
    const target = new Date(timestamp)
    const now = new Date()

    // 将当前时间和目标时间的小时分钟秒都设为 0，只保留日期部分
    const targetDate = new Date(target.getFullYear(), target.getMonth(), target.getDate())
    const nowDate = new Date(now.getFullYear(), now.getMonth(), now.getDate())

    const msPerDay = 1000 * 60 * 60 * 24
    const diff = nowDate.getTime() - targetDate.getTime()

    return Math.floor(diff / msPerDay)
  }

  /**
   * 将0~6转成周日到周六字符串
   * @param day
   */
  static getWeekdayName(day: number): Resource {
    switch (day % 7) {
      case 0:
        return $r('app.string.weekday_0')
      case 1:
        return $r('app.string.weekday_1')
      case 2:
        return $r('app.string.weekday_2')
      case 3:
        return $r('app.string.weekday_3')
      case 4:
        return $r('app.string.weekday_4')
      case 5:
        return $r('app.string.weekday_5')
      case 6:
        return $r('app.string.weekday_6')
      default:
        throw new Error(`Invalid day value: ${day}`)
    }
  }
}