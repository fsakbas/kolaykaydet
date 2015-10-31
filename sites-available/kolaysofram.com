
server {


    server_name kolaysofram.com   www.kolaysofram.com;


    access_log /var/log/nginx/kolaysofram.com.access.log ; 
    error_log /var/log/nginx/kolaysofram.com.error.log;


    root /var/www/kolaysofram.com/htdocs;
    
    

    index  index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    
    
    include common/locations.conf;
    include /var/www/kolaysofram.com/conf/nginx/*.conf;
}
