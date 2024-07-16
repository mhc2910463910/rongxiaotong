/*
  管理员api
 */
import { HttpManager } from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
// 获取用户列表
export function getUserList(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user`,
      method: RequestMethod.GET,
      header:{
        Authorization: globalThis.token
      }
    })
}
//更新用户接口
export function updateUserInfo(userName: string,identity: string,nickName: string,phone: string,role: string,address: string){
  var currentDate = new Date().toISOString();
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/${userName}`,
      method: RequestMethod.PUT,
      header:{
        Authorization: globalThis.token
      },
      extraData:{
          "address": address,
          "identityNum": identity,
          "nickName": nickName,
          "phone": phone,
          "role": role,
          "updateTime": currentDate,
      }
    })
}
//删除用户接口
export function deleteUser(userName:string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/${userName}`,
      method: RequestMethod.DELETE,
      header:{
        Authorization: globalThis.token
      }
    })
}