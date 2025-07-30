export interface IRecord {
  id?: number,
  time: number,
  remark?: string,
  price: number,
  size?: string,
  sweetness?: string,
  temperature?: string,
  condiments?: Array<number>,
  color?: number,
  beverageId: number
}