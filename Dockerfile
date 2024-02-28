FROM node:latest
RUN mkdir -p /home/app/
WORKDIR /home/app/
COPY . .
EXPOSE 3000
RUN npm install
CMD ["node","app"]
