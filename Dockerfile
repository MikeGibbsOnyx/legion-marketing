# Onyx Legion Marketing Site
# Static site served by nginx

FROM nginx:alpine

# Copy static files
COPY . /usr/share/nginx/html

# Copy custom nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
