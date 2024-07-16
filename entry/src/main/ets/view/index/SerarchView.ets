import { HttpManager } from '../../util/HttpManager'
import {RequestMethod} from '../../util/RequestOption'
import { baseUrl } from '../../api/BaseData'
import {searchGoods} from '../../api/GoodsApi'
import router from '@ohos.router'
@Preview
@Component
export struct SearchView {
  @State goodsSrc: Array<any> =[]
  @State pageNum: number=1
  @State submitValue: string = ''
  controller: SearchController = new SearchController()
  @State sta: boolean=true;
  getGoods(){
    HttpManager.getInstance()
      .request({
        url: `${baseUrl}/order/All/${this.pageNum}`,
        method: RequestMethod.GET
      })
      .then(data=>{
        let imageDataArray=JSON.parse(data.result.toString())
          .data.list;
        for(let index=0;index<imageDataArray.length;index++){
          const element=imageDataArray[index];
          this.goodsSrc.push(element);
        }
      })
      .catch(err=>{
        console.info(err)
      })
  }
  async aboutToAppear(){
    console.info('SearchView出现')
    this.getGoods()
  }
  build() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        Search({ placeholder: '搜索', controller: this.controller })
          .searchButton('确定')
          .margin(10)
          .height(50)
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
              router.pushUrl({
                url: "pages/SearchRes",
                params: {
                  word: value
                }
              })
          })

        Grid() {
            ForEach(this.goodsSrc, (item, i) => {
              GridItem() {
                Row() {
                  Image(`${baseUrl}/file/${item.picture}`)
                    .height(100)
                    .width(100)
                    .objectFit(ImageFit.Contain)
                    .borderRadius(8)
                  Flex({ direction: FlexDirection.Column }) {
                    if (item.type === "goods") {
                      Text(`[供] ${item.title}`)
                        .margin({ bottom: 24 })
                        .flexGrow(1)
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .width(220)
                    } else {
                      Text(`[需] ${item.title}`)
                        .margin({ bottom: 24 })
                        .flexGrow(1)
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .width(220)
                    }

                    // bottom:24,
                    Text(`￥ ${item.price}`).margin({ left: 12 }).fontColor(Color.Red)
                      .fontSize(20)
                    Text(`${item.ownName} | ${item.updateTime.split('T')[0]}`)
                  }.margin({ left: 5 })
                }
                .padding(10)
                .margin(10)
                .height(130)
                .width('90%')
                .borderRadius(10)
                .backgroundColor(Color.White)
                .justifyContent(FlexAlign.Center)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/GoodsInfoPage',
                    params: {
                      info: item
                    }
                  })
                })
              }
            })
        }
        .columnsTemplate('1fr')
        .backgroundImage($r('app.media.bg4'))
        .backgroundImageSize(ImageSize.Cover)
      }
  }
}