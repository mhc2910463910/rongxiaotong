/*
  我的需求api
 */
import { HttpManager } from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
export function getMyNeeds(pn: number){
  return HttpManager.getInstance()
    .request({
      // url: `${baseUrl}/order/needs/${pn}`,
      url: `${baseUrl}/order/search/needs/${pn}`,
      method: RequestMethod.GET,
      header: {
        Authorization: globalThis.token
      }
    })
}

//添加求购商品
export function addBuys(title: string,content:string,price: string,img: string){
  var currentDate = new Date().toISOString();
  return HttpManager.getInstance()
    .request({
        url: `${baseUrl}/order`,
        method: RequestMethod.POST,
        header:{
          Authorization: globalThis.token,
        },
        extraData:{
            "content": content,
            "createTime": currentDate,
            "orderStatus": 0,
            "ownName": globalThis.info.userName,
            "price": price,
            "picture": img,
            "title": title,
            "type": "needs",
            "updateTime": currentDate
        }
    })
}

//编辑求购商品
export function updateNeeds(id:string,title: string,content:string,price: string,img: string){
  var currentDate = new Date().toISOString();
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/${id}`,
      method: RequestMethod.PUT,
      header:{
        Authorization: globalThis.token,
      },
      extraData:{
        "content": content,
        "orderStatus": 0,
        "ownName": globalThis.info.userName,
        "price": price,
        "picture": img,
        "title": title,
        "type": "needs",
        "updateTime": currentDate
      }
    })
}
//删除求购商品
export function deleteNeeds(id:string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/${id}`,
      method: RequestMethod.DELETE,
      header:{
        Authorization: globalThis.token,
      }
    })
}

