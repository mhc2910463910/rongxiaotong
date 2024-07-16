export type IUserLoginDTO = {
  username: string;
  password: string;
}

export type IUserRegisterDTO = {
  userName: string;
  password: string;
  nickName: string;
  avatar: string;
}

export type IUser = {
  address?: string;
  avatar?: string;
  createTime?: string;
  credit?: number;
  identityNum?: string;
  integral?: number;
  nickName?: string;
  password?: string;
  phone?: string;
  realName?: string;
  role?: string;
  updateTime?: string;
  userName?: string;
}

export type IPasswordParam = {
  newPassword?: string
  oldPassword?: string
}