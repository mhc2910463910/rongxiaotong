import {HttpManager} from '../util/HttpManager'
import {RequestMethod, RequestOptions} from '../util/RequestOption'
import {baseUrl} from './BaseData'
// 获取商品货源或者需求
/** type:
 * @param type - 需或者求，needs，goods
 * @param pn - 页号
 * @returns The arithmetic mean of `x` and `y`
 * */

export function getGoods(type:string,pn:number) {
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/${type}/${pn}`
    })
}
export function searchGoods(key:string,pn:number){
  return HttpManager.getInstance()
    .request({
      // url: `${baseUrl}/order/searchAllByKeys/${key}/${pn}`,
      url: `${baseUrl}/order/searchAllByKeys/${encodeURI(key)}/${pn}`,
      method: RequestMethod.GET
    })
}

export async function getCartGoods(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/cart/show`,
      method: RequestMethod.GET,
      // header:
      // DONE, 将测试token改回全局变量
      header: {
        Authorization: globalThis.token
        // Authorization:'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOlt7ImF1dGhvcml0eSI6ImFkbWluIn1dLCJleHAiOjE3MjAxOTU3ODYsImlhdCI6MTcyMDE5MjE4Njk3MCwidXNlcm5hbWUiOiJhZG1pbiJ9.A7-jyzOr7I1fG15fSP3fMFq1q4q1Xu_MlbTt8GYl-v2tFbNv2spjP5QWcMuyDgUat9WHPnyGEuwZMnakLTH34Q'
      }
    })
}

export function addGoodsToCart(id:number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/cart/add/${id}`,
      method: RequestMethod.POST,
      header: {
        Authorization: globalThis.token
        // DONE, 将测试token改回全局变量
        // Authorization:'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOlt7ImF1dGhvcml0eSI6ImFkbWluIn1dLCJleHAiOjE3MjAxOTU3ODYsImlhdCI6MTcyMDE5MjE4Njk3MCwidXNlcm5hbWUiOiJhZG1pbiJ9.A7-jyzOr7I1fG15fSP3fMFq1q4q1Xu_MlbTt8GYl-v2tFbNv2spjP5QWcMuyDgUat9WHPnyGEuwZMnakLTH34Q'
      },
      extraData: {}
    })
}

/** 提交订单 */
export function buyGoods(userId:number,total:number,items:any){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/cart/commitOrder/${userId}/${total}`,
      method:RequestMethod.POST,
      header: {
        Authorization: globalThis.token
      },
      extraData:items
    })
}

//获取所有收货地址
export function getAllAddress(){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/address/selectByOwnName`,
      method:RequestMethod.GET,
      header:{
        Authorization:globalThis.token
      }
    })
}

//获取我卖的商品列表
export function getGoodsList(pageNum: number){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/search/goods/${pageNum}`,
      method: RequestMethod.GET,
      header: {
        Authorization: globalThis.token
      }
    })
}
//删除商品
export function deleteGoods(id: string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/order/${id}`,
      method: RequestMethod.DELETE,
      header:{
        Authorization: globalThis.token,
      }
    })
}
//编辑出售商品
export function updateGoods(id:string,title: string,content:string,price: string,img: string){
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
        "createTime": currentDate,
        "orderStatus": 0,
        "ownName": globalThis.info.userName,
        "price": price,
        "picture": img,
        "title": title,
        "type": "goods",
        "updateTime": currentDate
      }
    })
}
//添加商品
export function addGoods(title: string,content:string,price: string,img: string){
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
        "type": "goods",
        "updateTime": currentDate
      }
    })
}