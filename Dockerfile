FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1
ENV PYTHONIOENCODING utf-8
EXPOSE 80

RUN mkdir /run/nginx/
RUN mkdir /app
WORKDIR /app

RUN apk update && \
 apk add git postgresql-libs nginx supervisor && \
 apk add --virtual .build-deps linux-headers gcc musl-dev postgresql-dev && \
 git clone -b prototype https://github.com/lbryio/lbryweb.git /app && \
 pip3 install pipenv uwsgi && \
 pipenv install --deploy && \
 apk --purge del .build-deps
RUN ln -s `pipenv --venv` /app/venv

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/supervisor.ini /etc/supervisor.d/
COPY uwsgi.ini /app/lbryweb

CMD ["supervisord", "-n"]
