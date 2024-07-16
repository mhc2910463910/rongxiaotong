import http from '@ohos.net.http';
import { baseUrl } from './BaseData'
import { IKnowledge } from '../models/knowledge';

export const getKnowledgePageApi = (current: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/knowledge/${current}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    });
}

export const getExpertKnowledgeApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/knowledge/selectByUsername`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const deleteKnowledgeApi = (id: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/knowledge/${id}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: {
        knowledgeId: id
      }
    });
}

export const updateKnowledgeApi = (data: IKnowledge) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/knowledge/${data.knowledgeId}`),
    {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const releaseKnowledgeApi = (data: IKnowledge) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${baseUrl}/knowledge`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}