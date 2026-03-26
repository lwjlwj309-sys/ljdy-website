# 律金盾官网部署到腾讯云指南

## 需要上传的文件

将 `dist` 文件夹下的**所有内容**上传到服务器 `/var/www/ljdy/` 目录。

## 上传方式

### 方式一：腾讯云控制台上传（推荐新手）

1. 登录 [腾讯云控制台](https://console.cloud.tencent.com/lighthouse)
2. 进入轻量服务器详情页
3. 点击「远程登录」或「一键登录」
4. 使用文件上传功能上传 dist.zip

### 方式二：手动打包上传

1. 在本机把 dist 目录打包成 zip
2. 通过腾讯云控制台上传
3. 在服务器上解压

---

## 部署步骤

### 1. 创建目录并上传文件

```bash
# 在服务器上执行
mkdir -p /var/www/ljdy
```

然后通过控制台上传文件到 `/var/www/ljdy`

### 2. 安装并配置 Nginx

```bash
# 安装 Nginx
yum install -y nginx

# 停止现有服务
systemctl stop nginx

# 备份原配置
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

# 编辑配置
vi /etc/nginx/conf.d/ljdy.conf
```

### 3. Nginx 配置文件内容

```nginx
server {
    listen 80;
    server_name lvjindun.com www.lvjindun.com;
    
    root /var/www/ljdy;
    index index.html;
    
    # 静态资源缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
    
    # 所有请求指向 index.html
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 4. 启动服务

```bash
# 检查配置
nginx -t

# 启动
systemctl start nginx

# 开机自启
systemctl enable nginx
```

### 5. 开放防火墙端口

在腾讯云控制台「防火墙」中添加规则，开放 80 端口。

### 6. 域名解析

在域名服务商（如 DNSPod）添加解析：

| 记录类型 | 主机记录 | 记录值 |
|---------|---------|--------|
| A | @ | 119.28.30.124 |
| A | www | 119.28.30.124 |

---

## SSL 证书（可选但推荐）

等网站能正常访问后，可以申请免费的 Let's Encrypt 证书：

```bash
yum install -y certbot python3-certbot-nginx
certbot --nginx -d lvjindun.com -d www.lvjindun.com
```

---

## 完成后验证

访问 http://lvjindun.com 查看是否正常显示。

---

## 目录结构（部署后）

```
/var/www/ljdy/
├── index.html
├── about/
│   └── index.html
├── yutiao/
│   └── index.html
├── baofang/
│   └── index.html
├── consult/
│   └── index.html
├── contact/
│   └── index.html
└── _astro/
    └── (静态资源)
```

---

## 常用命令

```bash
# 重启 Nginx
systemctl restart nginx

# 查看 Nginx 状态
systemctl status nginx

# 查看 Nginx 日志
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
```
