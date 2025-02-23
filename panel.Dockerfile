# Playwright içeren resmi Node.js imajını kullanıyoruz
FROM mcr.microsoft.com/playwright:v1.40.0

# Türkiye saat dilimini ayarla
ENV TZ=Europe/Istanbul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Çalışma dizinini belirliyoruz
WORKDIR /app

# Paket dosyalarını kopyalıyoruz
COPY package.json package-lock.json ./

# Bağımlılıkları yüklüyoruz
RUN npm install

# Playwright bağımlılıklarını yüklüyoruz
RUN npx playwright install --with-deps

# Uygulama dosyalarını kopyalıyoruz
COPY . .

# Portu açıyoruz
EXPOSE  3006

# Sunucuyu başlatıyoruz
CMD ["npm", "run", "dev"]
