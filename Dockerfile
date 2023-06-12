ARG CA_URL=https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt
ARG CA_FILENAME=russian_trusted_root_ca_pem.crt
ARG CA_NAME=russian_trusted_root_ca

FROM maven:3-eclipse-temurin-17 as build

ARG CA_URL
ARG CA_FILENAME
ARG CA_NAME

RUN wget $CA_URL -O /root/$CA_FILENAME \
    && cp /root/$CA_FILENAME /usr/local/share/ca-certificates/ \
    && update-ca-certificates \
    && keytool -import -trustcacerts -noprompt -storepass changeit -alias $CA_NAME -file /root/$CA_FILENAME -keystore $JAVA_HOME/lib/security/cacerts

WORKDIR /app
COPY . .
RUN mvn verify

FROM eclipse-temurin:17

ARG CA_URL
ARG CA_FILENAME
ARG CA_NAME

COPY --from=build /root/$CA_FILENAME /root/

RUN cp /root/$CA_FILENAME /usr/local/share/ca-certificates/ \
    && update-ca-certificates \
    && keytool -import -trustcacerts -noprompt -storepass changeit -alias $CA_NAME -file /root/$CA_FILENAME -keystore $JAVA_HOME/lib/security/cacerts

WORKDIR /app
COPY --from=build /app/target/client-jar-with-dependencies.jar ./client.jar

ENTRYPOINT ["java", "-jar", "client.jar"]