export interface RequestOptions {
  url?: string;
  method?: RequestMethod;
  queryParams?: Record<string,string>;
  extraData?: string|Object|ArrayBuffer;
  header?: Object;
}
export enum RequestMethod{
  OPTIONS="OPTIONS",
  GET="GET",
  HEAD="HEAD",
  POST="POST",
  PUT="PUT",
  DELETE="DELETE",
  TRACE="TRACE",
  CONNECT="CONNECT"
}