FROM arm64v8/python:3.8.15

RUN pip install mkdocs
RUN pip install mkdocs-material
RUN pip install mkdocs-static-i18n

WORKDIR /wikipain

COPY . .

EXPOSE 8000

ENTRYPOINT ["mkdocs"]

CMD ["serve", "--dev-addr=0.0.0.0:8000"]
