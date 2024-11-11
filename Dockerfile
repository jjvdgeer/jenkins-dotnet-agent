FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/4b1d565b-7a3d-4e7e-87ad-7c662ec59020/4c6cb8a150efb42f7cea7e0b4c2f61cf/dotnet-sdk-7.0.410-linux-arm.tar.gz

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

