interface ICondiment {
  id: number
  name: string
  isPreset: boolean
}

@ObservedV2
export class Condiment {
  id: number
  @Trace isPreset: boolean
  @Trace name: string

  constructor(data: ICondiment) {
    this.id = data.id
    this.name = data.name
    this.isPreset = data.isPreset

  }

}