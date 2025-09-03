# Nginx - Enabling PUT

```bash
# Create a Directory to Handle Uploaded Files
sudo mkdir -p /var/www/uploads/SecretUploadDirectory
# Change the Owner to www-data
sudo chown -R www-data:www-data /var/www/uploads/SecretUploadDirectory  
```

## Create Nginx Configuration File
```nginx
server {
    listen 9001;
    
    location /SecretUploadDirectory/ {
        root    /var/www/uploads;
        dav_methods PUT;
    }
}
```

```bash
# Symlink our Site to the sites-enabled Directory
sudo ln -s /etc/nginx/sites-available/upload.conf /etc/nginx/sites-enabled/
# Start Nginx
sudo systemctl restart nginx.service
```

If we get any error messages, check `/var/log/nginx/error.log.` 

## All in Dockerfile (Optional)
```Dockerfile
FROM nginx

RUN mkdir -p /var/www/uploads/SecretUploadDirectory
# Asegurarse de que el usuario correcto (nginx or www-data) tenga permisos de escritura
RUN chown -R nginx:nginx /var/www/uploads/SecretUploadDirectory

RUN echo 'server {\
    listen 9001;\
    \
    location /SecretUploadDirectory/ {\
        root    /var/www/uploads;\
        dav_methods PUT;\
    }\
}' > /etc/nginx/conf.d/upload.conf


CMD ["nginx", "-g", "daemon off;"]
```

# Upload File Using cURL
```bash
  curl -T /etc/passwd http://localhost:9001/SecretUploadDirectory/users.txt
```

