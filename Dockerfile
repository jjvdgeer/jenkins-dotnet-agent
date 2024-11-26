FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/44135b0f-e6d4-4e48-831b-fcd32c06a17f/b5dd8932aac6655a1ebd99ea9f24cc76/dotnet-sdk-8.0.404-linux-arm.tar.gz
ENV TZ=Europe/Oslo
ENV DOTNET_ROOT=/home/jenkins/dotnet
ENV PATH=${PATH}:/home/jenkins/dotnet

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy --no-install-recommends curl libicu-dev tzdata \
 && rm -rf /var/lib/apt/lists/* \
 && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

USER jenkins

RUN downloadname="/tmp/$(basename ${DOTNETCORE_URL})" \
  && curl -L ${DOTNETCORE_URL} --output ${downloadname} \
  && mkdir -p ${DOTNET_ROOT} \
  && tar zxf ${downloadname} -C ${DOTNET_ROOT} \
  && rm ${downloadname}

USER root
