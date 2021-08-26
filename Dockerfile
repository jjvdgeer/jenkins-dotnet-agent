FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/501903b0-5e47-4b76-a965-fabafcd95ff5/d6f197c99957b356ee8f0c6e2304ff09/dotnet-sdk-6.0.100-preview.7.21379.14-linux-arm.tar.gz

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

