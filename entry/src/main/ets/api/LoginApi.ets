import {HttpManager} from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
//登录
export function login(username: string,password:string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/login`,
      method: RequestMethod.POST,
      extraData:{
        username,
        password
      }
    })
}
//注册
export function register(nickName: string,password:string,userName:string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/add`,
      method: RequestMethod.POST,
      extraData: {
        avatar: "rongxiaotong.gif",
        nickName,
        password,
        userName
      }
    })
}
//根据凭证获取用户信息
export function getInfo(){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/loginSelectByUsername`,
      method: RequestMethod.GET,
      header:{
        Authorization: globalThis.token
      }
    })
}
//修改密码
export function updatePassword(newpassword:string,password:string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/loginUpdatePassword`,
      method: RequestMethod.POST,
      header: {
        Authorization: globalThis.token
      },
      extraData: {
        "newPassword": newpassword,
        "oldPassword": password
      }
    })
}