import { expect } from '@ohos/hypium'
import {HttpManager} from '../util/HttpManager'
import {RequestMethod, RequestOptions} from '../util/RequestOption'
import {baseUrl} from './BaseData'
// 获取所有问答
export function getExpertFAQsByPageNum(pageNum:number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/question/findAllQues/${pageNum}`,
      header:{
        Authorization: globalThis.token
      }
    })
}
//根据用户获取问答情况
export function getQuestionList(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/question/selectByKind/questioner`,
      method: RequestMethod.GET,
      header:{
        Authorization: globalThis.token
      }
    })
}
//获取所有预约
export function getReverseList(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/reserve/selectByKind/questioner`,
      header:{
        Authorization: globalThis.token
      }
    })
}
// 我买的
export function getMyBuysList(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/selectBuys`,
      header:{
        Authorization: globalThis.token
      }
    })
}
//我卖的
export function getMySellsList(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/selectSells`,
      header:{
        Authorization: globalThis.token
      }
    })
}


