import {HttpManager} from '../util/HttpManager'
import {RequestOptions} from '../util/RequestOption'
import {baseUrl} from './BaseData'
export function getFrams(pn:number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/knowledge/${pn}`
    })
}
export function getInfo(id:number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/knowledge/selectById/${id}`
    })
}
//http://localhost:9090/knowledge/1
//http://localhost:9090/knowledge/selectById/22