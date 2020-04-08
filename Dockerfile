FROM python:3.8.0

WORKDIR /app

RUN apt-get update -y

RUN apt-get install -y bash

RUN apt-get install -y libzbar-dev python3-dev

RUN apt-get install -y gcc

#RUN apt-get install -y --update alpine-sdk

#RUN apt-get install -y --virtual build-dependencies build-base gcc wget git

RUN pip install --upgrade pip

# dont'know use START
RUN apt-get install -y libpq-dev
# dont'know use END

# to run postgresql
RUN pip install psycopg2-binary
RUN pip install virtualenv

#RUN apt-get install -y postgresql-dev gcc  musl-dev

#EXPOSE 8000


ENV MY_USER="codexten" \
	MY_GROUP="codexten" \
	MY_UID="1000" \
	MY_GID="1000"

#RUN usermod -u MY_UID MY_USER

#USER ${MY_USER}

RUN set -x \
	&& groupadd -g ${MY_GID} -r ${MY_GROUP} \
&& useradd -u ${MY_UID} -m -s /bin/bash -g ${MY_GROUP} ${MY_USER}

RUN usermod -u 1000 ${MY_USER}
RUN chown -R codexten /home/${MY_USER}

#RUN chown -R ${MY_USER}:${MY_USER} /en /projects

USER ${MY_USER}
ENV USER ${MY_USER}
ENV PATH /home/codexten/.local/bin:${PATH}

#
#ENV USER www-data
#USER ${USER}
ADD ./django/init.sh /opt/init.sh
#RUN chown -R www-data:www-data /var/www/init.sh
#RUN chmod +x /var/www/init.sh
#RUN cd /app && virtualenv venv
#CMD tail -f /dev/null
CMD ["/bin/bash","/opt/init.sh"]

ENTRYPOINT "/opt/init.sh" && tail -f /dev/null
