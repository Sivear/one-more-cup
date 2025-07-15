interface IRecord {
  id: number
  name: string
  isPreset: boolean
}

@ObservedV2
export class Record {
  id: number
  @Trace isPreset: boolean
  @Trace name: string

  constructor(data: IRecord) {
    this.id = data.id
    this.name = data.name
    this.isPreset = data.isPreset

  }

}