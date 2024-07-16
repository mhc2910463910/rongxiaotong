import http from '@ohos.net.http'
import {RequestOptions} from './RequestOption';
export class HttpCore{
  request(requestOption:RequestOptions):Promise<http.HttpResponse>{
    return new Promise((resolve,reject)=>{
      this.sendRequest(requestOption)
        .then((response)=>{
          if(typeof response.result!=='string'){
            reject(new Error('Invalid data type'));
          }
          else{
            if(response){
              resolve(response);
            } else{
              reject(new Error('Invalid data type,JSON to T failed'));
            }
          }
        })
        .catch((error)=>{
          reject(error);
        });
    });
  }
  private sendRequest(requestOption:RequestOptions):Promise<http.HttpResponse>{
    let httpRequest=http.createHttp();
    let resolveFunction,rejectFunction;
    const resultPromise=new Promise<http.HttpResponse>((resolve,reject)=>{
      resolveFunction=resolve;
      rejectFunction=reject;
    });
    let promise =httpRequest.request(this.appendQueryParams(requestOption.url,requestOption.queryParams),{
      method:requestOption.method,
      header:requestOption.header,
      extraData:requestOption.extraData,
    });
    promise.then((response)=>{
      // console.info('Result:'+response.result);
      // console.info('code'+response.responseCode);
      // console.info('header:'+JSON.stringify(response.header));
      resolveFunction(response);
    }).catch((err)=>{
      rejectFunction(err);
    }).finally(()=>{
      httpRequest.destroy();
    })
    return resultPromise;
  }
  private appendQueryParams(url:string,queryParams:Record<string,string>):string{
    let param=""
    for(let queryParamsKey in queryParams){
      if(param!=""){
        param+='&';
      }
      param+=queryParamsKey+'='+queryParams[queryParamsKey]
    }
    if(param==""){
      return url;
    }else{
      return url+'?'+param;
    }
  }
}
export  const httpCore=new HttpCore();