FROM qnap:5000/jjvdgeer/jenkins-ssh-agent:latest

# dotnet core download URL
ENV DOTNETCORE_URL https://download.visualstudio.microsoft.com/download/pr/8f09af48-e88e-4b91-bae1-08a5c9183559/e10eefacab56a4f4c1165d4e26a5f0f9/dotnet-sdk-5.0.200-linux-arm.tar.gz

RUN apt-get update \
 && apt-get install -qy --no-install-recommends curl

USER jenkins

RUN downloadname="/tmp/$(basename ${DOTNETCORE_URL})" \
  && curl ${DOTNETCORE_URL} --output ${downloadname} \
  && mkdir -p $HOME/dotnet && tar zxf ${downloadname} -C $HOME/dotnet \
  && export DOTNET_ROOT=$HOME/dotnet \
  && export PATH=$PATH:$HOME/dotnet \
  && dotnet --version \
  && rm ${downloadname}

USER root

