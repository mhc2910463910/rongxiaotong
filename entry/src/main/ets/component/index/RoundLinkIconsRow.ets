/** 对外表现为 */
import Router from '@system.router'
import router from '@ohos.router'
@Component
export struct RoundLinkIconsRow{
  build(){
    Column(){
      Row(){
        RoundLinkIcon({src:$r('app.media.image'),text:'商品资源'})
          .padding(10)
          .onClick(()=>{
            router.pushUrl({
                url: "pages/GoodsPage",
                params: {type:"goods"}
            })
          })
        RoundLinkIcon({src:$r('app.media.icon2'),text:'求购需求'})
          .padding(10)
          .onClick(()=>{
            router.pushUrl({
              url: "pages/GoodsPage",
              params: {type:"needs"}
            })
          })
        RoundLinkIcon({src:$r('app.media.icon3'),text:'农业知识'})
          .padding(10)
          .onClick(()=>{
            router.pushUrl({
              url: "pages/FramingPage"
            })
          })
        RoundLinkIcon({src:$r('app.media.icon4'),text:'专家指导'})
          .padding(10)
          .onClick(()=>{
            router.pushUrl({
              url: "pages/ExpertFAQPage"
            })
          })
      }.width('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}

@Component
struct RoundLinkIcon{
  private src:Resource;
  private text:string;
  build(){
    Column(){
      Image(this.src).objectFit(ImageFit.ScaleDown).width('100%')
      Text(this.text)
    }.width('20%')
  }
}