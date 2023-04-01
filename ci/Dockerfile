FROM python:3.8.15

RUN pip install mkdocs
RUN pip install mkdocs-material
RUN pip install mkdocs-static-i18n

WORKDIR /wikipain

COPY . .

EXPOSE 80

ENTRYPOINT ["mkdocs"]

CMD ["serve", "--dev-addr=0.0.0.0:80"]
