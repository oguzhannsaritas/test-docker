# Playwright içeren resmi Node.js imajını kullanıyoruz
FROM mcr.microsoft.com/playwright:v1.40.0

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
EXPOSE 3000

# Sunucuyu başlatıyoruz
CMD ["npm", "run", "start-server"]
