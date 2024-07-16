import http from '@ohos.net.http';
import { baseUrl } from './BaseData'
import { IFinance, IIntention } from '../models/finance';

export const getRecommendUserListApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/selectRecommendByName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getIntentionApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/selectIntentionByName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const addIntentionApi = (data: IIntention) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/insertIntentionByName`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const updateIntentionApi = (data: IIntention) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/updateIntentionByName`),
    {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const deleteIntentionApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/deleteIntentionByName`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getBankApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/selectbank`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const addFinance = (data: IFinance) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/add`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const addFinanceMulti = (data: IFinance) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/addFinanceMulti`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const getUserFinanceApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/selectByName/`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const updateFinance = (data: IFinance) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/update/`),
    {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const deleteUserFinance = (financeId: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/finance/delete/${financeId}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

