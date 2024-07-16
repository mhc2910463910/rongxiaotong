import { HttpManager } from '../../util/HttpManager'
import {RequestMethod} from '../../util/RequestOption'
import { baseUrl } from '../../api/BaseData'

import {RoundLinkIconsRow} from '../../component/index/RoundLinkIconsRow'
import {getMyIp} from '../../api/CityApi'
import {getLocation} from '../../api/CityApi'
import router from '@ohos.router'

// 轮播图
class DataSource implements IDataSource {
  private list: number[] = []
  private listener: DataChangeListener

  constructor(list: number[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}


@Preview
// @Entry
@Component
export struct Home{
  // // 导航栏
  // private tabsController : TabsController = new TabsController()
  // @State currentIndex:number = 0;
  // @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
  //   Column() {
  //     Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
  //       .size({ width: 25, height: 25 })
  //     Text(title)
  //       .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
  //   } .onClick(() => {
  //     this.currentIndex = targetIndex;
  //     this.tabsController.changeIndex(this.currentIndex);
  //   })
  //   .width('100%')
  //   .height(50)
  //   .justifyContent(FlexAlign.Center)
  //   .backgroundColor('#C1FFC1')
  //   .padding(5)
  // }
  // 搜索栏
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()
  // 轮播图
  private swiperController: SwiperController = new SwiperController()
  private data: DataSource = new DataSource([])
  // 商品列表

  private imageSrc: Array<any> =[]
  private scroller: Scroller=new Scroller()
  @State goodsSrc: Array<any> =[]
  @State pageNum: number=1
  @State cityName: string='';
  @State ip: string='';
  @State word: string='';
  // private baseUrl: string='http://localhost:9090'
//   获取所有商品
  getAllGoods(pn:number){
    HttpManager.getInstance()
      .request({
        url: baseUrl+"/order/All/"+this.pageNum,
        method: RequestMethod.GET
      })
      .then(data=>{
        // console.info("请求返回:"+data.result.toString())
        let imageDataArray=JSON.parse(data.result.toString())
          .data.list;
        for(let index=0;index<imageDataArray.length;index++){
          const element=imageDataArray[index];
          this.goodsSrc.push(element);
        }
        globalThis.goodsData=this.goodsSrc;
      })
      .catch(err=>{
        console.info(err)
      })

  }
  // 查询所有商品模糊查询
  getGoodsByParam(pn:number){
    this.pageNum=pn;
    let url=`${baseUrl}/order/searchAllByKeys/${this.word}/${this.pageNum}`;
    if(this.word.length==0){
      url=`${baseUrl}/order/All/${this.pageNum}`;
    }
    console.info("=======url"+encodeURI(url));
    HttpManager.getInstance()
      .request({
        url: encodeURI(url),
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
      })
  }
  showContent(content){
    return content.length>15?content.substring(0,15):content
  }
  showTitle(title){
    return title.length>15?title.substring(0,15):title
  }
  async aboutToAppear(){
    let list = []
    list.push($r('app.media.banner_01'))
    list.push($r('app.media.banner_02'))
    list.push($r('app.media.banner_03'))
    list.push($r('app.media.banner_04'))
    list.push($r('app.media.banner_05'))
    this.data = new DataSource(list)
    this.initializeImageData()
    this.getAllGoods(1)

    let resultIp=await getMyIp();
    let ip=resultIp.result.toString().replace(/\n/g,"")
    let resultLatLng=await getLocation(ip);
    console.info("我的ip: "+ip);
    console.info("位置: "+JSON.stringify(resultLatLng.result.toString()));
    // let cityName=JSON.parse(resultLatLng.result.toString()).result.cityName
    let cityName=JSON.parse(resultLatLng.result.toString()).result.provinceName+JSON.parse(resultLatLng.result.toString()).result.cityName
    this.cityName=cityName;

  }
  initializeImageData(){
    this.imageSrc=[
      {"img":$r('app.media.banner_01')}
    ]
  }
  build(){
    // Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
    //   // HOME
    //   TabContent() {
    //     // 首页
        Column() {
          Row() {
            // 定位
            Text(this.cityName).width('20%')
              .backgroundColor('#efefef')
              .height(40)
              .borderRadius(30)
              .textAlign(TextAlign.Center)
              .fontColor(Color.Black)
            // 搜索栏
            Search({ value: this.changeValue, placeholder: '搜索', controller: this.controller })
              .searchButton('确定')
              .width('70%')
              .height(40)
              .backgroundColor('#F5F5F5')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.submitValue = value
                router.pushUrl({
                  url: "pages/SearchRes",
                  params: {
                    word: value
                  }
                })
              })
              .onChange((value: string) => {
                this.changeValue = value
              })
              .margin(10)
          }
          //   轮播图
          Swiper(this.swiperController) {
            LazyForEach(this.data, (item: string) => {
              Image(item).width('90%').height(160).backgroundColor(0xAFEEEE)
            }, item => item)
          }
          .cachedCount(2)
          .index(1)
          .autoPlay(true)
          .interval(4000)
          .indicator(false)
          .loop(true)
          .duration(1000)
          .itemSpace(0)
          .curve(Curve.Linear)
          .onChange((index: number) => {
            // console.info(index.toString())
          })
          //   选项
          RoundLinkIconsRow()
          // 商品
          if (this.goodsSrc.length > 0) {
            Scroll(this.scroller) {
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
                ForEach(this.goodsSrc, (item, i) => {
                  Column() {
                    Image(`${baseUrl}/file/${item.picture}`)
                      .width('100%')
                      .height(100)
                    Column(){
                      Row(){
                        Image(item.type=='goods'?$r('app.media.gong'):$r('app.media.xu')).width(30).height(30)
                        Text(this.showTitle(item.title)).height(30).lineHeight(30)
                          .margin({left :10}).fontSize(18).fontWeight(FontWeight.Bolder)
                          .textOverflow({overflow:TextOverflow.Ellipsis})
                      }.margin({top:5})
                      Row(){
                        Text("￥"+item.price).fontColor(Color.Red).fontSize(18)

                      }.height(20).justifyContent(FlexAlign.SpaceBetween).width('100%')

                    }.layoutWeight(1).width('100%').alignItems(HorizontalAlign.Start)
                  }.width('47%')
                  .height(200)
                  .borderRadius(5)
                  .borderWidth(1)
                  .borderColor('#ffffff')
                  .margin(5)
                  .padding(10)
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/GoodsInfoPage',
                      params: {
                        info:item
                      }
                    })
                  })
                },item=>item)
              }.width('100%')
            }.scrollable(ScrollDirection.Vertical)
            .height(400)
            .margin({top:10,right:10,left:10})
            .onScrollEdge(()=>{
              if(this.word==''){
                this.getAllGoods(this.pageNum+1)
              }else{
                this.getGoodsByParam(this.pageNum+1)
              }
            })
          }else{
            Text("没有符合条件的数据")
          }
        }.width('100%')
        .height('100%')
        .backgroundImage($r('app.media.bg4'))
        .backgroundImageSize(ImageSize.Cover)
    //   }.tabBar(this.TabBuilder('首页', 0, $r('app.media.home3'), $r('app.media.home1')))
    //
    //   TabContent() {
    //     // 探索
    //     SearchView()
    //   }.tabBar(this.TabBuilder('探索', 1, $r('app.media.Search_3'), $r('app.media.Search_1')))
    //
    //   TabContent(){
    //     // 购物车
    //     CarInfo()
    //   }.tabBar(this.TabBuilder('购物车',2,$r('app.media.Bag'),$r('app.media.Bag2')))
    //
    //   TabContent(){
    //     // 我的
    //     MyInfo()
    //   }
    //   .tabBar(this.TabBuilder('我的',3,$r('app.media.user_3'),$r('app.media.user_1')))
    // }.onChange((index) => {
    //   this.currentIndex = index
    // })
    // .height('100%')
    // .width('100%')
    }
}