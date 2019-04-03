FROM 202.116.46.215/hsdocker2019/hs_hadoop:v1.0
COPY spark_config/*  /tmp/
#install spark
RUN wget https://www.apache.org/dyn/closer.lua/spark/spark-2.2.3/spark-2.2.3-bin-hadoop2.7.tgz -O /tmp/spark-2.2.3-bin-hadoop2.7.tgz && \
	tar -xzvf /tmp/spark-2.2.3-bin-hadoop2.7.tgz &&\
    mv spark-2.2.3-bin-hadoop2.7 /usr/local/spark &&\
    rm /tmp/spark-2.2.3-bin-hadoop2.7.tgz
RUN wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz -O /tmp/scala-2.11.8.tgz && \
	tar -xzvf /tmp/scala-2.11.8.tgz &&\
    mv scala-2.11.8 /usr/local/scala &&\
    rm /tmp/scala-2.11.8.tgz
ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
ENV SPARK_HOME=/usr/local/spark
ENV SCALA_HOME=/usr/local/scala
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$SCALA_HOME/bin
RUN  mv /tmp/slaves  $SPARK_HOME/conf/ && \
     mv /tmp/spark-env.sh $SPARK_HOME/conf/ && \
     mv /tmp/start-spark.sh ~/start-spark.sh && \
     mv /tmp/profile /etc/ && \
     . /etc/profile
RUN chmod +x ~/start-spark.sh
CMD exec /bin/bash -c "service ssh start;trap : TERM INT; sleep infinity & wait"
