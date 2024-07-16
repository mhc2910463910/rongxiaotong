export type IResponse<T> = {
  code: number;
  data?: T;
  message: string;
  flag: boolean;
}

export type IPageInfo<T> = {
  endRow: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  isFirstPage: boolean;
  isLastPage: boolean;
  list: Array<T>;
  navigateFirstPage: number;
  navigateLastPage: number;
  navigatePages: number;
  navigatepageNums: Array<number>;
  nextPage: number;
  pageNum: number
  pageSize: number;
  pages: number;
  prePage: number;
  size: number
  startRow: number
  total: number;
}