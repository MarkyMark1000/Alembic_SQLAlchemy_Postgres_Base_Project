FROM python:3.12

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/test_project

ENV PYTHONPATH="${PYTHONPATH}:/srv/test_project"

COPY requirements.txt ./requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . /srv/test_project

RUN useradd mark && chown -R mark /srv
