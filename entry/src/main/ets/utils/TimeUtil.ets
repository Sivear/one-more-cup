export class TimeUtil {
  static isToday(time: number): boolean {
    const now = new Date()
    const start = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0, 0).getTime()
    const end = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59, 999).getTime()
    return time <= end && time >= start
  }

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
}