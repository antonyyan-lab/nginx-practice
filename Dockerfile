FROM nginx:latest

COPY ./web1/index.html /usr/share/nginx/html
COPY ./nginx.conf /usr/local/nginx/conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]




