FROM jenkins/jenkins:lts

# Root yetkileri ile çalıştır
USER root

# Gerekli bağımlılıkları yükle
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    xvfb \
    xauth \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
           && apt-get install -y nodejs \
           && npm install -g npm@10

# Türkiye saat dilimini ayarla
ENV TZ=Europe/Istanbul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Çalışma dizinini belirliyoruz
WORKDIR /var/jenkins_home

# Playwright ve bağımlılıklarını yükle
RUN npx playwright install --with-deps

# Jenkins için port aç
EXPOSE 8080

# Jenkins başlatma komutu
CMD ["/usr/local/bin/jenkins.sh"]
