import router from '@ohos.router';
import { baseUrl } from '../api/BaseData';
import { searchGoods } from '../api/GoodsApi';
@Entry
@Component
struct SearchRes{
  @State type: string="搜索结果";
  @State searchGoods: Array<any> =[]
  @State word: string='';
  @State pageNum: number=1;
  scroller: Scroller=new Scroller()
  aboutToAppear(){
    const params = router.getParams(); // 获取传递过来的参数对象
    const value = params['word']; // 获取word属性的值
    this.word = value
    console.info("搜索"+this.word)
    searchGoods(this.word, this.pageNum).then((res) => {
      let DataArray = JSON.parse(res.result.toString())
        .data.list;
      if(DataArray.length==0){
        console.info("查询结果为空")
        AlertDialog.show({ message: '查询结果为空' })
      }else{
        console.info("查询结果")
        console.info(JSON.parse(res.result.toString()).data.list)
        for (let index = 0;index < DataArray.length; index++) {
          const element = DataArray[index];
          this.searchGoods.push(element);
        }
      }

    })
      .catch(err => {
        console.info(err)
      })
  }
  build(){
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text(this.type)
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back()
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })
        Grid() {
          ForEach(this.searchGoods, (item, i) => {
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
              .margin(2)
              .height(130)
              .width('100%')
              .borderRadius(10)
              .backgroundColor('#F0FFFF')
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
        }.columnsTemplate('1fr')
    }.backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('90%')
  }
}