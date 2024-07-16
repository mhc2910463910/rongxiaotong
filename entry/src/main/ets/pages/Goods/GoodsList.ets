/*
获取我要卖的商品列表
 */
import router from '@ohos.router';
import { baseUrl } from '../../api/BaseData';
import { deleteGoods, getGoodsList } from '../../api/GoodsApi';
@Entry
@Component
struct GoodsList{
  @State type: string="商品列表"
  @State pageNum: number=1;
  @State goodsList: Array<any> =[]
  scroller: Scroller=new Scroller()
  aboutToAppear() {
    this.getGoodsList()
  }
  //查询需求
  getGoodsList() {
    getGoodsList(this.pageNum).then((rst) => {
      let DataArray = JSON.parse(rst.result.toString()).data.list;
      // AlertDialog.show({message: "查到结果"+DataArray.length+"个"})
      for (let index = 0;index < DataArray.length; index++) {
        const element = DataArray[index]
          this.goodsList.push(element)
      }
    })
  }
  //删除需求
  deleteGoods(id: string){
    deleteGoods(id).then((res)=>{
      let rst = JSON.parse(res.result.toString());
      if (rst.code == 20000) {
        AlertDialog.show({message : "删除成功"})
        router.replaceUrl({url: "pages/Goods/GoodsList"})
      } else {
        AlertDialog.show({
          title: "提示",
          message: rst.message,
          primaryButton: {
            value: '关闭',
            action: () => {
            }
          }
        })
      }
    })
  }
  build(){
    Flex({direction: FlexDirection.Column}){
      Stack({alignContent: Alignment.Start}){
        Text(this.type)
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Row() {
          Text("发布")
            .fontSize(18)
            .onClick(()=>{
              router.pushUrl({
                url: "pages/Goods/PublishGoods"
              })
            })
        }.width('100%').justifyContent(FlexAlign.End)
        .padding({right:20})
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(()=>{
            router.back()
          }).margin({left:10})
      }.height(60).width('100%').margin({top:10})
      Scroll(this.scroller) {
        Grid() {
          ForEach(this.goodsList, (item, i) => {
            GridItem() {
              Flex({ direction: FlexDirection.Column }) {
                Image(`${baseUrl}/file/${item.picture}`)
                  .width('100%')
                  .height(120)
                Text(item.ownName)
                  .fontSize(18)
                  .fontWeight(600)
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(600)
                Text(`￥ ${item.price}`)
                  .fontColor(Color.Red)
                Row(){
                  Text("编辑")
                    .fontColor(Color.Gray)
                    .onClick(()=>{
                      router.pushUrl({
                        url: "pages/Goods/UpdateGoods",
                        params: {
                          "img" : item.picture, // 获取属性的值
                          "title" : item.title, // 获取属性的值
                          "content" : item.content, // 获取属性的值
                          "price" : item.price, // 获取属性的值
                          "orderId" : item.orderId // 获取属性的值
                        }
                      })
                    })
                  Blank()
                  Text("删除")
                    .fontColor(Color.Gray)
                    .onClick(()=>{
                      this.deleteGoods(item.orderId)
                    })
                }.width('100%')
                .padding({left:20,right:20})
              }
            }
            .padding(10)
            .width('48%')
            .shadow({ radius: 2, color: Color.Gray, offsetX: 10, offsetY: 10 })
            .borderRadius(20)
            .height(220)
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/GoodsInfoPage',
                params: {
                  info:item
                }
              })
            })
          })
        }.columnsTemplate('1rf 1rf')
        .width('100%')
      } .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
      .scrollBar(BarState.Off)  // 滚动条常驻显示
      .scrollBarWidth(10) // 滚动条宽度
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}