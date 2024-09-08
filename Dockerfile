FROM python:3.12-alpine
LABEL maintainer="Almog Hamo"

ENV PYTHONUNBUFFERED=1


RUN apk update \
    && apk add --no-cache gcc musl-dev libffi-dev openssl-dev curl python3-dev build-base

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

COPY pyproject.toml poetry.lock ./

RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

COPY ./app /app

WORKDIR /app

EXPOSE 8000
RUN adduser --disabled-password --no-create-home django-user

USER django-user
