FROM python:3.9.18-alpine3.17

LABEL maintainer="David Omokhodion <davidomokhodion097@gmail.com>"

WORKDIR /app

COPY . . 

ENV APP_DEBUG=1
ENV APP_VERSION=1.0.0
ENV APP_NAME=AssessmentApp
ENV USER_NAME=David_Nobleman
ENV USER_URL=https://github.com/nobleman97
# ENV DATABASE_URL=postgresql://postgres:davidson@postgres:5430/postgres
ENV FLASK_RUN_PORT=8000

# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt

RUN pip install --upgrade Flask-SQLAlchemy SQLAlchemy

EXPOSE 8000

CMD [ "/bin/sh", "-c", "flask db upgrade && gunicorn -w 4 -b 0.0.0.0:8000 app:app" ]