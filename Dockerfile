FROM python:3.7.8-slim

ENV USER=demo

# remember to expose the port your app'll be exposed on.
EXPOSE 8080

RUN pip install -U pip

COPY requirements.txt app/requirements.txt
RUN pip install -r app/requirements.txt

# copy into a directory of its own (so it isn't in the toplevel dir)
COPY . /app
WORKDIR /app

# switch to non-root user!
RUN useradd $USER && install -o $USER -g $USER -d /home/$USER
USER $USER

# run it!
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8080", "--server.address=0.0.0.0"]
