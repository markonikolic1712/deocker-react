# sa 'as builder' kazemo da sve od ove linije pa na dole ce biti vezano za bilder fazu
# fajlovi koji su rezultat build-a ce biti u folderu /app/build
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# od ovog reda pa na dole su komande vezane za run fazu
FROM nginx
# '--from=builder' - hocu da kopiram nesto iz builder faze
# '/app/build' kopiraj iz /app/build foldera u /usr/share/nginx/html
# /usr/share/nginx/html je folder u koji trebaju da se kopiraju fajlovi koji trebaju da se serviraju - ovo je po nginx specifikaciji
COPY --from=builder /app/build /usr/share/nginx/html