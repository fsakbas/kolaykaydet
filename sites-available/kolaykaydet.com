server {
 
        server_name kolaykaydet.com www.kolaykaydet.com;
        return 301 https://www.kolaykaydet.com$request_uri; 
        error_log    /var/log/nginx/kolaykaydet.com.error.log;
 
        root /var/www/kolaykaydet.com/htdocs;
        index index.php index.htm index.html;
 
        set $cache_uri $request_uri;
		
 
 
 
}
server {
    listen 443;
    server_name www.kolaykaydet.com;
 
    #wordpress install root
    root /var/www/kolaykaydet.com/htdocs;
    index index.php index.htm index.html;
	
 	
 
    ssl on;
	ssl_certificate /var/www/kolaykaydet.com/cert/ssl.crt;
	ssl_certificate_key /var/www/kolaykaydet.com/cert/www.kolaykaydet.com.key;
	
  ssl_ciphers 'AES128+EECDH:AES128+EDH:!aNULL';

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;


  ssl_stapling on;
  ssl_stapling_verify on;
  resolver 8.8.4.4 8.8.8.8 valid=300s;
  resolver_timeout 10s;

  ssl_prefer_server_ciphers on;
	
 
 
 
        access_log   /var/log/nginx/kolaykaydet.com.access.log rt_cache;
        error_log    /var/log/nginx/kolaykaydet.com.error.log;
 
        set $cache_uri $request_uri;
 
       

 
        location ~ \.php$ {
                try_files $uri =404;
                include fastcgi_params;
                fastcgi_pass php;
				
        }
		
		if ($bad_referer) {
		        return 444;
		    }

		
 	    include common/wpfc.conf;
        include common/wpcommon.conf;
        include common/locations.conf;
 
}


