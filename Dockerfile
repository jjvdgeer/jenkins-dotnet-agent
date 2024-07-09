FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/9e0bdcde-1878-4351-883a-c0adbb570bba/156df738634f710dad131e993fc0f48a/dotnet-sdk-8.0.303-linux-arm.tar.gz

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive TZ="Europe/Oslo" \
    apt-get install -qy --no-install-recommends curl libicu-dev

USER jenkins

RUN downloadname="/tmp/$(basename ${DOTNETCORE_URL})" \
  && curl ${DOTNETCORE_URL} --output ${downloadname} \
  && mkdir -p $HOME/dotnet && tar zxf ${downloadname} -C $HOME/dotnet \
  && export DOTNET_ROOT=$HOME/dotnet \
  && export PATH=$PATH:$HOME/dotnet \
  && dotnet --version \
  && rm ${downloadname}

USER root

