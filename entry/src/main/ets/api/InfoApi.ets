import inputMethod from '@ohos.inputMethod'
import {HttpManager} from '../util/HttpManager'
import { RequestMethod } from '../util/RequestOption'
import { baseUrl } from './BaseData'
// export function upload(path: string){
//   return HttpManager.getInstance()
//     .request({
//       url: `${baseUrl}/file/upload/avatar`,
//       method: RequestMethod.POST,
//       header:{
//         'Content-Type': 'multipart/form-data',
//       },
//
//     })
// }
// 修改头像
export function updateAvatar(fileName: string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/${globalThis.info['userName']}`,
      method: RequestMethod.PUT,
      extraData: {
        "avatar": fileName,
        "nickName": `${globalThis.info['nickName']}`,
        "userName": `${globalThis.info['userName']}`
      }
    })
}
// 上传图片
// 调用鸿蒙库上传
// 修改昵称
export function updateNickname(nickName: string,userName: string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/${userName}`,
      method: RequestMethod.PUT,
      header:{
        Authorization: globalThis.token
      },
      extraData:{
        "nickName": nickName,
        "userName": userName
      }
    })
}
// 修改电话
export function updatePhone(phone: string,userName: string){
  return HttpManager.getInstance()
    .request({
      url: `${baseUrl}/user/${userName}`,
      method: RequestMethod.PUT,
      header:{
        Authorization: globalThis.token
      },
      extraData:{
        "phone": phone,
        "nickName": globalThis.info.nickName,
        "userName": userName
      }
    })
}
