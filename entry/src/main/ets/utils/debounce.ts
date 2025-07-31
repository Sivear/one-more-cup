/**
 * 防抖函数，用法见NewBeveragePage中的debounceSearch函数
 * @param func
 * @param wait
 * @param immediate 是否立即执行
 * @returns
 */
export function debounce<T extends (...args: any[]) => void>(
  func: T,
  wait: number = 500,
  immediate: boolean = false // 是否立即执行
): (...args: Parameters<T>) => void {
  let timeoutId: number | undefined = undefined;
  type FunctionParams = Parameters<T>;

  return function (this: ThisParameterType<T>, ...args: FunctionParams): void {
    const context = this;
    const later = () => {
      timeoutId = undefined;
      if (!immediate) {
        func.apply(context, args);
      }
    };

    const shouldCallNow = immediate && timeoutId === undefined;

    // 清除已有定时器
    if (timeoutId !== undefined) {
      clearTimeout(timeoutId);
    }

    // 设置新的定时器
    timeoutId = setTimeout(later, wait);

    // 立即执行模式且首次触发
    if (shouldCallNow) {
      func.apply(context, args);
    }
  };
}