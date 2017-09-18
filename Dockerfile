FROM timotto/ubuntu-ptxdist:2014.12.0

ARG target=arm-1136jfs-linux-gnueabihf
ARG oselas=2014.12.0

WORKDIR /home/user

USER user

RUN curl http://public.pengutronix.de/oselas/toolchain/OSELAS.Toolchain-${oselas}.tar.bz2 | tar jx \
	&& cd OSELAS.Toolchain-${oselas} \
	&& ln -s $(which ptxdist) p \
	&& ./build_one.sh ${target}

USER root

RUN cd OSELAS.Toolchain-${oselas} \
	&& dpkg -i dist/oselas.toolchain-${oselas}-${target}*.deb \
	&& cd .. \
	&& rm -rf OSELAS.Toolchain-${oselas}
