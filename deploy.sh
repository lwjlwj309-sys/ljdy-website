#!/bin/bash
# 律金盾官网部署脚本

# 安装 Nginx（CentOS）
yum install -y nginx

# 创建网站目录
mkdir -p /var/www/ljdy

# 停止 Nginx（如果正在运行）
systemctl stop nginx

# 复制网站文件到目录（假设你会上传 dist 目录内容到这里）
# 你需要把 dist 目录的内容上传到 /var/www/ljdy

# 设置权限
chown -R nginx:nginx /var/www/ljdy
chmod -R 755 /var/www/ljdy

# 复制 Nginx 配置
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
cat > /etc/nginx/conf.d/ljdy.conf << 'EOF'
server {
    listen 80;
    server_name lvjindun.com www.lvjindun.com;
    
    root /var/www/ljdy;
    index index.html;
    
    # 启用 gzip 压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
    
    # 缓存静态资源
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
    
    # 所有请求都指向 index.html（SPA 支持）
    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# 检查 Nginx 配置
nginx -t

# 启动 Nginx
systemctl start nginx

# 设置开机启动
systemctl enable nginx

# 开放防火墙（如果有）
# firewall-cmd --permanent --add-service=http
# firewall-cmd --reload

echo "部署完成！请确保域名 lvjindun.com 已解析到 $(hostname -I | awk '{print $1}')"
