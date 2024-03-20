FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/cf62adad-ab62-4941-b474-ed275935e7b2/358b637e181b9a76a9a70a192b951760/dotnet-sdk-6.0.420-linux-arm.tar.gz

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

