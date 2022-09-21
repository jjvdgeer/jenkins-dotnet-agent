FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/451f282f-dd26-4acd-9395-36cc3a9758e4/f5399d2ebced2ad9640db6283aa9d714/dotnet-sdk-6.0.401-linux-arm.tar.gz

RUN apt-get update \
 && apt-get install -qy --no-install-recommends curl libicu-dev

USER jenkins

RUN downloadname="/tmp/$(basename ${DOTNETCORE_URL})" \
  && curl ${DOTNETCORE_URL} --output ${downloadname} \
  && mkdir -p $HOME/dotnet && tar zxf ${downloadname} -C $HOME/dotnet \
  && export DOTNET_ROOT=$HOME/dotnet \
  && export PATH=$PATH:$HOME/dotnet \
  && dotnet --version \
  && rm ${downloadname}

USER root

