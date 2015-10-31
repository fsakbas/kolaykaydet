
server {


    server_name tekinmustafa.com   www.tekinmustafa.com;


    access_log /var/log/nginx/tekinmustafa.com.access.log rt_cache; 
    error_log /var/log/nginx/tekinmustafa.com.error.log;


    root /var/www/tekinmustafa.com/htdocs;
    
    

    index index.php index.html index.htm;


    include common/w3tc.conf;  
    
    include common/wpcommon.conf;
    include common/locations.conf;
    include /var/www/tekinmustafa.com/conf/nginx/*.conf;
}
