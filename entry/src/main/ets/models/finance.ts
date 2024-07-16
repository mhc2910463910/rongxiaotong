export type IFinance = {
  bankId?: number
  combinationIdnum1?: string
  combinationIdnum2?: string
  combinationName1?: string
  combinationName2?: string
  combinationPhone1?: string
  combinationPhone2?: string
  createTime?: string
  fileInfo?: string
  financeId?: number
  idNum?: string
  money?: string
  ownName?: string
  phone?: string
  rate?: number
  realName?: string
  repayment?: string
  status?: number
  updateTime?: string
}

export type IIntention = {
  address?: string
  amount?: string
  application?: string
  area?: string
  createTime?: string
  item?: string
  phone?: string
  realName?: string
  repaymentPeriod?: string
  updateTime?: string
  userName?: string
  avatar?: string
}

export type IBank = {
  bankId?: number;
  bankName?: string;
  introduce?: string;
  bankPhone?: string;
  money?: string;
  rate?: string;
  repayment?: number;
}

// TODO，银行代码和名称映射临时解决方案
export const BankMap:{ [key: number]: string } = {
  1001: '青岛银行',
  1002: '中国银行',
  // FIXME, 没有1003图片
  1004: '中国工商银行',
  1005: '日照银行',
  1006: '华夏银行',
  // 1006: '',
  1007: '中国建设银行',
  1008: '浦发银行',
  1009: '平安银行',
  1010: '中国民生银行',
  // ...
};