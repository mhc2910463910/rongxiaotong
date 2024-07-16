import {HttpManager} from '../util/HttpManager'
import {RequestOptions} from '../util/RequestOption'
import {baseUrl} from './BaseData'

export function getExpertInfosByPageNum(pageNum:number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/question/findExpert/${pageNum}`,
      header:{
        Authorization: globalThis.token
      }
    })
}