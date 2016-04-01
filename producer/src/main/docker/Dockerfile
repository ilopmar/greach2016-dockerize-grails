FROM java:openjdk-8u72-jdk

VOLUME /tmp

RUN groupadd -r user && useradd -r -g user user

COPY producer-0.1.jar /app/producer.jar
RUN bash -c 'touch /app/producer.jar'
RUN chown -R user:user /app

USER user
WORKDIR /app

CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/producer.jar"]
