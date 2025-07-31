import { Events } from './Events';

type EventHandler = () => void

class EventBus {
  private static instance: EventBus;
  private handlers = new Map<Events, Set<EventHandler>>();
  private onceHandlers = new Map<Events, Set<EventHandler>>();

  private constructor() {
    // 私有构造函数防止外部实例化
  }

  /**
   * 获取EventBus单例实例
   */
  public static getInstance(): EventBus {
    if (!EventBus.instance) {
      EventBus.instance = new EventBus();
    }
    return EventBus.instance;
  }

  /**
   * 订阅事件
   * @param event 事件名称
   * @param handler 事件处理器
   * @returns 取消订阅的函数
   */
  public on(event: Events, handler: EventHandler): () => void {
    if (!this.handlers.has(event)) {
      this.handlers.set(event, new Set());
    }
    this.handlers.get(event)!.add(handler);
    return () => this.off(event, handler);
  }

  /**
   * 一次性订阅事件
   * @param event 事件名称
   * @param handler 事件处理器
   * @returns 取消订阅的函数
   */
  public once(event: Events, handler: EventHandler): () => void {
    if (!this.onceHandlers.has(event)) {
      this.onceHandlers.set(event, new Set());
    }
    this.onceHandlers.get(event)!.add(handler);
    return () => this.off(event, handler);
  }

  /**
   * 取消订阅事件
   * @param event 事件名称
   * @param handler 事件处理器
   */
  public off(event: Events, handler?: EventHandler): void {
    if (handler) {
      this.handlers.get(event)?.delete(handler);
      this.onceHandlers.get(event)?.delete(handler);
    } else {
      this.handlers.delete(event)
      this.onceHandlers.delete(event)
    }

  }

  /**
   * 发布事件
   * @param event 事件名称
   * @param payload 事件负载
   */
  public emit(event: Events): void {
    // 调用常规处理器
    this.handlers.get(event)?.forEach((handler) => handler());

    // 调用一次性处理器并清除
    if (this.onceHandlers.has(event)) {
      const handlersToCall = new Set(this.onceHandlers.get(event));
      this.onceHandlers.get(event)?.clear();
      handlersToCall.forEach((handler) => handler());
    }
  }

  /**
   * 清除所有订阅
   */
  public clear(): void {
    this.handlers.clear();
    this.onceHandlers.clear();
  }

  /**
   * 获取某个事件的所有订阅者数量
   * @param event 事件名称
   * @returns 订阅者数量
   */
  public listenerCount(event: Events): number {
    const normalCount = this.handlers.get(event)?.size || 0;
    const onceCount = this.onceHandlers.get(event)?.size || 0;
    return normalCount + onceCount;
  }
}

export const EventBusHandler = EventBus.getInstance()