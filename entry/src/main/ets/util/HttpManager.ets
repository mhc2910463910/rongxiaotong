import { RequestOptions } from './RequestOption';
import { httpCore as HttpCore } from './HttpCore';
import http from '@ohos.net.http';


export class HttpManager {
  private static mInstance: HttpManager;

  private constructor() {
  }

  static getInstance():HttpManager {
    if(!HttpManager.mInstance) {
      HttpManager.mInstance = new HttpManager();
    }
    return HttpManager.mInstance;
  }
  request(option:RequestOptions):Promise<http.HttpResponse>{
    return HttpCore.request(option)
  }
}