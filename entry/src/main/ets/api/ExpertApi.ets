/*
专家模块api
 */
import { HttpManager } from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
//获取专家详情
export function getExpertInfo(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/searchexpert`,
      method: RequestMethod.GET,
      header:{
        Authorization: globalThis.token
      }
    })
}
//修改专家信息
export function updateExpertInfo(realName: string,phone: string,profession: string,positionInf: string,belong: string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/updateexpert`,
      method: RequestMethod.PUT,
      header:{
        Authorization: globalThis.token
      },
      extraData:{
        "belong": belong,
        "phone": phone,
        "position": positionInf,
        "profession": profession,
        "realName": realName,
        "userName": globalThis.info.userName
      }
    })
}