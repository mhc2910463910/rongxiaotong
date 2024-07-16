// xxx.ets
interface Iobj{
  a:{
    age:number
  }
}
@Entry
@Component
struct PopupExample {
  @State show: boolean = false
  @State message:string = ''
  @State list:Array<any> = [
    {
      age: 1
    }
  ]
  @State obj:Iobj = {
    a:{
      age:1
    }
  }
  build() {
    Column(){
      Text(String(this.list[0].age))
      Text('对象age：'+String(this.obj.a.age))
      Button('测试按钮').width(200).height(100)
        .onClick(()=>{
          // 改变这个判断，根据情况修改message的显示
          // this.list[0] = {
          //   age: ++this.list[0].age
          // }
          this.obj.a.age++
          this.list[0].age++;
          console.info(JSON.stringify(this.list))
          if(false){
            this.message = 'success'
          }else{
            this.message = 'fail'
          }
          this.show = true
          setTimeout(()=>{
            this.show = false
          },1000)
        })
        .bindPopup(this.show, {
          message: '添加成功'
        })
    }.width('100%').height('100%')

  }
}