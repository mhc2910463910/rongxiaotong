import {HttpManager} from '../util/HttpManager'
import {RequestMethod} from '../util/RequestOption'
const apiKey='DQEDAOqFoHZFQ5v6Cq2S2/876WKQVJAWv24Mk7+9zvo9Ww6xjxTiWWoappNxX7hZ7YNBT2shhwa6XklOKdaQ5ltBFlZM/nsQnvhWAA=='

export function getMyIp(){
  return HttpManager.getInstance()
    .request({url:'https://checkip.amazonaws.com/'})

}
export function getLocation(ip:string){
  return HttpManager.getInstance()
    .request({
      url: 'https://openlocation-drcn.platform.dbankcloud.com/networklocation/v1/ipLocation',
      method: RequestMethod.POST,
      header:{
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
        'x-forwarded-for': `${ip}`
      },
      extraData:{
        ip:`${ip}`
      }
    })
}