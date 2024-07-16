import http from '@ohos.net.http';
import { baseUrl } from '../api/BaseData'
type IAddress = {
  addressDetail?: string
  consignee?: string
  id?: number
  isDefault?: boolean
  ownName?: string
  phone?: string
}

export const getAllAddressApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/address/selectByOwnName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getDefaultAddressApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/address/selectDefaultByOwnName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const deleteAddressApi = (id: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/address/delete/${id}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const editAddressApi = (data: IAddress) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/address/defaultAddressInfoUpdate`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const addAddressApi = (data: IAddress) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/address/add`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}