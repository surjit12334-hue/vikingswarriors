FROM nginx:1.27-alpine

# Static site files
COPY *.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY gallery/ /usr/share/nginx/html/gallery/
COPY background.jpg /usr/share/nginx/html/

# PORT-aware nginx config, written inline so no extra context file is needed.
# The official nginx image runs envsubst on /etc/nginx/templates/*.template at startup.
RUN mkdir -p /etc/nginx/templates && printf '%s\n' \
  'server {' \
  '    listen ${PORT};' \
  '    server_name _;' \
  '    root /usr/share/nginx/html;' \
  '    index index.html;' \
  '' \
  '    location / {' \
  '        try_files $uri $uri/ /index.html;' \
  '    }' \
  '}' \
  > /etc/nginx/templates/default.conf.template

ENV PORT=80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
