export interface IRecord {
  id?: number
  time: number
  remark?: string
  price: number
  size?: string
  sweetness?: string
  temperature?: string
  condiments?: Array<number>
  color?: number
  icon?: string
  beverageId: number
  brandId: number
  beverageName: string
  brandName: string,
  degree: number
}

@ObservedV2
export class Record {
  id?: number
  @Trace time: number
  @Trace remark?: string
  @Trace price: number
  @Trace size?: string
  @Trace sweetness?: string
  @Trace temperature?: string
  @Trace condiments?: Array<number>
  @Trace color?: number
  @Trace icon?: string
  @Trace beverageId: number
  @Trace brandId: number
  @Trace beverageName: string
  @Trace brandName: string
  @Trace degree: number

  constructor(data: IRecord) {
    this.id = data.id
    this.time = data.time
    this.remark = data.remark
    this.price = data.price
    this.size = data.size
    this.sweetness = data.sweetness
    this.temperature = data.temperature
    this.condiments = data.condiments
    this.color = data.color
    this.icon = data.icon
    this.beverageId = data.beverageId
    this.brandId = data.brandId
    this.beverageName = data.beverageName
    this.brandName = data.brandName
    this.degree = data.degree
  }

}