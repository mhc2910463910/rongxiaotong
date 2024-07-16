import http from '@ohos.net.http'
import {HttpManager} from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
//获取用户购物车信息
export function getCarInfoList(){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/cart/show`,
      method:RequestMethod.GET,
      header:{
        Authorization:globalThis.token
      }
    })
}
// 添加商品到购物车
export function addToCar(goodId:string) {
  let url = `${baseUrl}/cart/add/${goodId}`
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/cart/add/${goodId}`,
      method: RequestMethod.POST,
      header: {
        Authorization: globalThis.token
      },
      extraData: {}
    })
}

// 修改购物车商品数量
export function updateCarGoodsInfo(shoppingId:number,count:number) {
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/cart/update/${shoppingId}/${count}`,
      method: RequestMethod.PUT,
      header: {
        Authorization: globalThis.token
      },
      extraData: {}
    })
}

// 删除购物车商品
export function deleteCarGoods(shoppingId:number) {
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/cart/delete/${shoppingId}`,
      method: RequestMethod.DELETE,
      header: {
        Authorization: globalThis.token
      },
      extraData: {}
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
//获取默认收货地址
export function getDefaultAddress(){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/address/selectDefaultByOwnName`,
      method:RequestMethod.GET,
      header:{
        Authorization:globalThis.token
      }
    })
}
//购买商品
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
//购买商品
export function getMyBuys(){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/order/selectBuys`,
      method:RequestMethod.GET,
      header: {
        Authorization: globalThis.token
      }
    })
}
//卖出商品
export function getMySells(){
  return HttpManager.getInstance()
    .request({
      url:`${baseUrl}/order/selectSells`,
      method:RequestMethod.GET,
      header: {
        Authorization: globalThis.token
      }
    })
}

