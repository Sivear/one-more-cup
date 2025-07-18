// 懒加载列表数据model
export class LazyListModel<T> {
  private _data: T[] = [];
  private _listeners: DataChangeListener[] = [];

  getAllData(): T[] {
    return this._data;
  }

  totalCount(): number {
    return this._data.length;
  }

  getData(index: number): T {
    return this._data[index];
  }

  pushData(item: T): void {
    this._data.push(item);
    this._listeners.forEach(listener => {
      listener.onDataAdd(this._data.length - 1);
    });
  }

  // 用一个新数组的值替换当前数组内容
  assignData(dataList: T[]) {
    this._data = [...dataList]
    this.notifyDataReload()
  }

  // 清除所有数据
  clearData(): void {
    this._data = []
    this.notifyDataReload()
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this._listeners.forEach(listener => {
      listener.onDataReloaded();
    });
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this._listeners.forEach(listener => {
      listener.onDataChange(index);
    });
  }


  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this._listeners.forEach(listener => {
      listener.onDataDelete(index);
    });
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this._listeners.forEach(listener => {
      listener.onDataMove(from, to);
    });
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    this._listeners.push(listener);
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const index = this._listeners.indexOf(listener);
    if (index !== -1) {
      this._listeners.splice(index, 1);
    }
  }
}