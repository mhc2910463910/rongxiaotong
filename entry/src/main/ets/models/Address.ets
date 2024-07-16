interface IAddresss {
  consignee: string
  addressDetail: string
  phone: string
}

export class IAddresssModel implements IAddresss {
  consignee: string = ''
  addressDetail: string = ''
  phone: string = ''

  constructor(model: IAddresss) {
    this.consignee = model.consignee
    this.addressDetail = model.addressDetail
    this.phone = model.phone
  }
}

export { IAddresss }