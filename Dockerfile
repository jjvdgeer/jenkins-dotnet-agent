FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/ba992713-4a38-4b45-9c24-8222f2ba01d7/e8746f2e70e0f06e3d9282c6d43bce65/dotnet-sdk-9.0.100-rc.2.24474.11-linux-arm.tar.gz

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive TZ="Europe/Oslo" \
    apt-get install -qy --no-install-recommends curl libicu-dev libc6

USER jenkins

RUN downloadname="/tmp/$(basename ${DOTNETCORE_URL})" \
  && curl ${DOTNETCORE_URL} --output ${downloadname} \
  && mkdir -p $HOME/dotnet && tar zxf ${downloadname} -C $HOME/dotnet \
  && export DOTNET_ROOT=$HOME/dotnet \
  && export PATH=$PATH:$HOME/dotnet \
  && dotnet --version \
  && rm ${downloadname}

USER root

