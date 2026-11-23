FROM nginx:1.27-alpine

# Static site files
COPY *.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY gallery/ /usr/share/nginx/html/gallery/
COPY background.jpg /usr/share/nginx/html/

# PORT-aware nginx config (official nginx image runs envsubst on templates)
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

ENV PORT=80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
