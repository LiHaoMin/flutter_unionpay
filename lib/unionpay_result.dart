/**
 * 返回支付结果
 */
class  UnionpayResult{
  /**
   * 返回码:
   *  (0 支付成功 -1 失败 -2 用户取消)
   */
  int retCode;

  /**
   * 错误原因
   */
  String retMsg;

  /**
   * 支付渠道返回具体内容
   */
  dynamic channelData;

  void setOupayRest(int retCode,String retMsg,{String payChannel,dynamic channelData}){
    this.retCode = retCode;
    this.retMsg = retMsg;
    this.channelData = channelData;
  }

  @override
  String toString(){
     String result = '{retCode:$retCode,retMsg:$retMsg,channelData:$channelData}';
     return result;
  }
}